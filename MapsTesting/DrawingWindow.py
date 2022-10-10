import tkinter
from tkinter import filedialog, Canvas
from tkinter import *
from PIL import Image as PIL_Image, ImageTk as PIL_ImageTk, ImageGrab

currLabel = None
currentCanvas = None
prevClick = None
root = None
canvas = None

def TestFunction(event):
    global prevClick
    global currentCanvas
    global currLabel

    if prevClick is None:
        prevClick = [event.x, event.y]
        return

    currentCanvas.create_line(prevClick[0], prevClick[1], event.x, event.y, width=3, fill='red')
    currentCanvas.pack()
    prevClick = [event.x, event.y]


def AskFileDialog(event):
    global canvas
    filename = filedialog.asksaveasfilename()
    canvas.focus_force()

    OutputMap(filename)


def OutputMap(filename):
    global currentCanvas
    global root
    global canvas

    x = canvas.winfo_rootx() + canvas.winfo_x()
    y = canvas.winfo_rooty() + canvas.winfo_y()
    x1 = x + canvas.winfo_width()
    y1 = y + canvas.winfo_height()

    ImageGrab.grab().crop((x, y, x1, y1)).save(filename)
    canvas.destroy()


def OpenScreenshot(newWindow, passedRoot):
    global currentCanvas
    global currLabel
    global root
    global canvas
    imageFile = 'out.gif'
    root = passedRoot

    canvas = Canvas(newWindow, width=1910, height=1020)
    canvas.focus_force()
    currentCanvas = canvas

    background_image = PIL_ImageTk.PhotoImage(file=imageFile)
    canvas.pack(fill=tkinter.BOTH, expand=1)
    canvas.create_image(0, 0, anchor=tkinter.NW, image=background_image)
    canvas.background_image = background_image
    canvas.bind("<Shift-Button-1>", TestFunction)
    canvas.bind("<Shift-Button-3>", AskFileDialog)







