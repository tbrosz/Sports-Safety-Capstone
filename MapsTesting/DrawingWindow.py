import tkinter
from tkinter import *
from PIL import Image as PIL_Image, ImageTk as PIL_ImageTk

currLabel = None
currentCanvas = None
prevClick = None


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


def OpenScreenshot(newWindow):
    global currentCanvas
    global currLabel
    imageFile = 'out.gif'

    canvas = Canvas(newWindow, width=1910, height=1020)
    currentCanvas = canvas

    background_image = PIL_ImageTk.PhotoImage(file=imageFile)
    canvas.pack(fill=tkinter.BOTH, expand=1)
    canvas.create_image(0, 0, anchor=tkinter.NW, image=background_image)
    canvas.background_image = background_image
    canvas.bind("<Button-1>", TestFunction)







