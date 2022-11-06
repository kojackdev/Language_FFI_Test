from ctypes import *
import math

so_file = "../lib/cimgc.dll"
cimgc = WinDLL(so_file)

cimgc.openWindow(1024,1024)
cimgc.setTitle("Python".encode('utf-8'))
cimgc.clear(c_float(0.5),0,0)


offset = 0
while not cimgc.isClosed():
    for y in range(1024):
        for x in range(1024):
            dx = x - 512.0
            dy = y - 512.0
            r = math.sqrt(dx*dx+dy*dy)
            if r>300.0:
                cimgc.setPixel(x, y, c_float(((x+offset) % 1024) / 1023.0), c_float(y / 1023.0), c_float(0.0))
            else:
                cimgc.setPixel(x, y, c_float(1.0), c_float(1.0), c_float(1.0))
    offset = offset + 1
    cimgc.display()
