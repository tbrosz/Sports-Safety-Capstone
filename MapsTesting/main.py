# Example of embedding CEF Python browser using Tkinter toolkit.
# This example has two widgets: a navigation bar and a browser.
#
# NOTE: This example often crashes on Mac (Python 2.7, Tk 8.5/8.6)
#       during initial app loading with such message:
#       "Segmentation fault: 11". Reported as Issue #309.
#
# Tested configurations:
# - Tk 8.5 on Windows/Mac
# - Tk 8.6 on Linux
# - CEF Python v55.3+
#
# Known issue on Linux: When typing url, mouse must be over url
# entry widget otherwise keyboard focus is lost (Issue #255
# and Issue #284).

from cefpython3 import cefpython as cef
import ctypes

import tkinter.simpledialog
from tkinter import Toplevel
from PIL import ImageGrab
import sys
import os
import platform
import logging as _logging
import gmplot
import win32gui
import win32ui
import win32con

import DrawingWindow

root = tkinter.Tk()

with open('MapsAPIKey.txt') as file:
    api_key = file.readline()
    file.close()

# Fix for PyCharm hints warnings
WindowUtils = cef.WindowUtils()

# Platforms
WINDOWS = (platform.system() == "Windows")
LINUX = (platform.system() == "Linux")
MAC = (platform.system() == "Darwin")

# Globals
logger = _logging.getLogger("tkinter_.py")

# Constants
# Tk 8.5 doesn't support png images
IMAGE_EXT = ".png" if tkinter.TkVersion > 8.5 else ".gif"


def TakeScreenshot(widget):
    w = 1920
    h = 1080
    out_file_name = "out.gif"  # this needs to be a .gif file for the next step of the code to function

    x = root.winfo_rootx() + widget.winfo_x()
    y = root.winfo_rooty() + widget.winfo_y()
    x1 = x + widget.winfo_width()
    y1 = y + widget.winfo_height()
    ImageGrab.grab().crop((x + 10, y + 30, x1, y1)).save("out.gif")

    newWindow = tkinter.Toplevel(root)
    DrawingWindow.OpenScreenshot(newWindow, root)


class MainFrame(tkinter.Frame):

    def __init__(self, root):
        self.browser_frame = None
        self.navigation_bar = None

        # Root
        root.geometry("1920x1080")
        tkinter.Grid.rowconfigure(root, 0, weight=1)
        tkinter.Grid.columnconfigure(root, 0, weight=1)

        # MainFrame
        tkinter.Frame.__init__(self, root)
        self.master.title("Map Example")
        self.master.protocol("WM_DELETE_WINDOW", self.on_close)
        self.master.bind("<Configure>", self.on_root_configure)
        self.setup_icon()
        self.bind("<Configure>", self.on_configure)
        self.bind("<FocusIn>", self.on_focus_in)
        self.bind("<FocusOut>", self.on_focus_out)

        # NavigationBar
        self.navigation_bar = NavigationBar(self)
        self.navigation_bar.grid(row=0, column=0,
                                 sticky=(tkinter.N + tkinter.S + tkinter.E + tkinter.W))
        tkinter.Grid.rowconfigure(self, 0, weight=0)
        tkinter.Grid.columnconfigure(self, 0, weight=0)

        # BrowserFrame
        self.browser_frame = BrowserFrame(self, self.navigation_bar)
        self.browser_frame.grid(row=1, column=0,
                                sticky=(tkinter.N + tkinter.S + tkinter.E + tkinter.W))
        tkinter.Grid.rowconfigure(self, 1, weight=1)
        tkinter.Grid.columnconfigure(self, 0, weight=1)

        # Pack MainFrame
        self.pack(fill=tkinter.BOTH, expand=tkinter.YES)

    def on_root_configure(self, _):
        logger.debug("MainFrame.on_root_configure")
        if self.browser_frame:
            self.browser_frame.on_root_configure()

    def on_configure(self, event):
        logger.debug("MainFrame.on_configure")
        if self.browser_frame:
            width = event.width
            height = event.height
            if self.navigation_bar:
                height = height - self.navigation_bar.winfo_height()
            self.browser_frame.on_mainframe_configure(width, height)

    def on_focus_in(self, _):
        logger.debug("MainFrame.on_focus_in")

    def on_focus_out(self, _):
        logger.debug("MainFrame.on_focus_out")

    def on_close(self):
        if self.browser_frame:
            self.browser_frame.on_root_close()
        self.master.destroy()

    def get_browser(self):
        if self.browser_frame:
            return self.browser_frame.browser
        return None

    def get_browser_frame(self):
        if self.browser_frame:
            return self.browser_frame
        return None

    def setup_icon(self):
        resources = os.path.join(os.path.dirname(__file__), "resources")
        icon_path = os.path.join(resources, "tkinter" + IMAGE_EXT)
        if os.path.exists(icon_path):
            self.icon = tkinter.PhotoImage(file=icon_path)
            # noinspection PyProtectedMember
            self.master.call("wm", "iconphoto", self.master._w, self.icon)


class BrowserFrame(tkinter.Frame):

    def __init__(self, master, navigation_bar=None):
        self.navigation_bar = navigation_bar
        self.closing = False
        self.browser = None
        tkinter.Frame.__init__(self, master)
        self.bind("<FocusIn>", self.on_focus_in)
        self.bind("<FocusOut>", self.on_focus_out)
        self.bind("<Configure>", self.on_configure)
        self.focus_set()

    def embed_browser(self):
        window_info = cef.WindowInfo()
        rect = [0, 0, self.winfo_width(), self.winfo_height()]
        window_info.SetAsChild(self.get_window_handle(), rect)
        self.browser = cef.CreateBrowserSync(window_info,
                                             url=os.path.abspath("map.html"))  # todo
        assert self.browser
        self.browser.SetClientHandler(LoadHandler(self))
        self.browser.SetClientHandler(FocusHandler(self))
        self.message_loop_work()

    def get_window_handle(self):
        if self.winfo_id() > 0:
            return self.winfo_id()
        elif MAC:
            # On Mac window id is an invalid negative value (Issue #308).
            # This is kind of a dirty hack to get window handle using
            # PyObjC package. If you change structure of windows then you
            # need to do modifications here as well.
            # noinspection PyUnresolvedReferences
            from AppKit import NSApp
            # noinspection PyUnresolvedReferences
            import objc
            # Sometimes there is more than one window, when application
            # didn't close cleanly last time Python displays an NSAlert
            # window asking whether to Reopen that window.
            # noinspection PyUnresolvedReferences
            return objc.pyobjc_id(NSApp.windows()[-1].contentView())
        else:
            raise Exception("Couldn't obtain window handle")

    def message_loop_work(self):
        cef.MessageLoopWork()
        self.after(10, self.message_loop_work)

    def on_configure(self, _):
        if not self.browser:
            self.embed_browser()

    def on_root_configure(self):
        # Root <Configure> event will be called when top window is moved
        if self.browser:
            self.browser.NotifyMoveOrResizeStarted()

    def on_mainframe_configure(self, width, height):
        if self.browser:
            if WINDOWS:
                ctypes.windll.user32.SetWindowPos(
                    self.browser.GetWindowHandle(), 0,
                    0, 0, width, height, 0x0002)
            elif LINUX:
                self.browser.SetBounds(0, 0, width, height)
            self.browser.NotifyMoveOrResizeStarted()

    def on_focus_in(self, _):
        logger.debug("BrowserFrame.on_focus_in")
        if self.browser:
            self.browser.SetFocus(True)

    def on_focus_out(self, _):
        logger.debug("BrowserFrame.on_focus_out")
        if self.browser:
            self.browser.SetFocus(False)

    def on_root_close(self):
        if self.browser:
            self.browser.CloseBrowser(True)
            self.clear_browser_references()
        self.destroy()

    def clear_browser_references(self):
        # Clear browser references that you keep anywhere in your
        # code. All references must be cleared for CEF to shutdown cleanly.
        self.browser = None


class LoadHandler(object):

    def __init__(self, browser_frame):
        self.browser_frame = browser_frame

    def OnLoadStart(self, browser, **_):
        test = 1
        #if self.browser_frame.master.navigation_bar:
            #self.browser_frame.master.navigation_bar.set_url(browser.GetUrl())


class FocusHandler(object):

    def __init__(self, browser_frame):
        self.browser_frame = browser_frame

    def OnTakeFocus(self, next_component, **_):
        logger.debug("FocusHandler.OnTakeFocus, next={next}"
                     .format(next=next_component))

    def OnSetFocus(self, source, **_):
        logger.debug("FocusHandler.OnSetFocus, source={source}"
                     .format(source=source))
        return False

    def OnGotFocus(self, **_):
        """Fix CEF focus issues (#255). Call browser frame's focus_set
           to get rid of type cursor in url entry widget."""
        logger.debug("FocusHandler.OnGotFocus")
        self.browser_frame.focus_set()


class NavigationBar(tkinter.Frame):
    def __init__(self, master):
        self.back_state = tkinter.NONE
        self.forward_state = tkinter.NONE
        self.back_image = None
        self.forward_image = None
        self.reload_image = None

        tkinter.Frame.__init__(self, master)
        resources = os.path.join(os.path.dirname(__file__), "resources")

        # Back button
        back_png = os.path.join(resources, "back" + IMAGE_EXT)
        if os.path.exists(back_png):
            self.back_image = tkinter.PhotoImage(file=back_png)
        self.back_button = tkinter.Button(self, image=self.back_image,
                                     command=self.go_back)
        self.back_button.grid(row=0, column=0)

        # Forward button
        forward_png = os.path.join(resources, "forward" + IMAGE_EXT)
        if os.path.exists(forward_png):
            self.forward_image = tkinter.PhotoImage(file=forward_png)
        self.forward_button = tkinter.Button(self, image=self.forward_image,
                                        command=self.go_forward)
        self.forward_button.grid(row=0, column=1)

        # Reload button
        reload_png = os.path.join(resources, "reload" + IMAGE_EXT)
        if os.path.exists(reload_png):
            self.reload_image = tkinter.PhotoImage(file=reload_png)
        self.reload_button = tkinter.Button(self, image=self.reload_image,
                                       command=self.on_button3)
        self.reload_button.grid(row=0, column=2)

        # Update state of buttons
        self.update_state()

    def go_back(self):
        if self.master.get_browser():
            self.master.get_browser().GoBack()

    def go_forward(self):
        if self.master.get_browser():
            self.master.get_browser().GoForward()

    def reload(self):
        if self.master.get_browser():
            self.master.get_browser().Reload()

    def on_url_focus_in(self, _):
        logger.debug("NavigationBar.on_url_focus_in")

    def on_url_focus_out(self, _):
        logger.debug("NavigationBar.on_url_focus_out")

    def on_load_url(self, _):
        if self.master.get_browser():
            self.master.get_browser().StopLoad()
            self.master.get_browser().LoadUrl(self.url_entry.get())

    def on_button1(self, _):
        """Fix CEF focus issues (#255). See also FocusHandler.OnGotFocus."""
        logger.debug("NavigationBar.on_button1")
        self.master.master.focus_force()

    def on_button3(self):
        test = self.master.browser_frame.browser.allowedClientCallbacks
        TakeScreenshot(self.master)


    def update_state(self):
        browser = self.master.get_browser()
        if not browser:
            if self.back_state != tkinter.DISABLED:
                self.back_button.config(state=tkinter.DISABLED)
                self.back_state = tkinter.DISABLED
            if self.forward_state != tkinter.DISABLED:
                self.forward_button.config(state=tkinter.DISABLED)
                self.forward_state = tkinter.DISABLED
            self.after(100, self.update_state)
            return
        if browser.CanGoBack():
            if self.back_state != tkinter.NORMAL:
                self.back_button.config(state=tkinter.NORMAL)
                self.back_state = tkinter.NORMAL
        else:
            if self.back_state != tkinter.DISABLED:
                self.back_button.config(state=tkinter.DISABLED)
                self.back_state = tkinter.DISABLED
        if browser.CanGoForward():
            if self.forward_state != tkinter.NORMAL:
                self.forward_button.config(state=tkinter.NORMAL)
                self.forward_state = tkinter.NORMAL
        else:
            if self.forward_state != tkinter.DISABLED:
                self.forward_button.config(state=tkinter.DISABLED)
                self.forward_state = tkinter.DISABLED
        self.after(100, self.update_state)


if __name__ == '__main__':
    logger.setLevel(_logging.INFO)
    stream_handler = _logging.StreamHandler()
    formatter = _logging.Formatter("[%(filename)s] %(message)s")
    stream_handler.setFormatter(formatter)
    logger.addHandler(stream_handler)
    logger.info("CEF Python {ver}".format(ver=cef.__version__))
    logger.info("Python {ver} {arch}".format(
        ver=platform.python_version(), arch=platform.architecture()[0]))
    logger.info("Tk {ver}".format(ver=tkinter.Tcl().eval('info patchlevel')))
    assert cef.__version__ >= "55.3", "CEF Python v55.3+ required to run this"
    sys.excepthook = cef.ExceptHook  # To shutdown all CEF processes on error

    pathlat = 38.209852675168314, 38.209794865507746, 38.20963296639867, 38.20797132999889, 38.207909145630744
    pathlon = -84.55806318740112, -84.5568792916732, -84.55442383125227, -84.55462578588273, -84.55358331513037

    location = tkinter.simpledialog.askstring('TITLE', 'Enter location')
    gmap = gmplot.GoogleMapPlotter.from_geocode(location, apikey=api_key, zoom=17)
    gmap.enable_marker_dropping('orange', draggable=True)
    gmap.plot(pathlat, pathlon, 'cornflowerblue', edge_width=10)
    gmap.draw("map.html")

    app = MainFrame(root)
    # Tk must be initialized before CEF otherwise fatal error (Issue #306)
    cef.Initialize()

    app.mainloop()
    cef.Shutdown()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
