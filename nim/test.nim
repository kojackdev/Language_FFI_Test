import math

proc openWindow(width:uint32, height:uint32, title: cstring): void {.importc, dynlib: "../lib/cimgc.dll".}
proc setPixel(x:uint32, y:uint32, r:float32, g:float32, b:float32): void {.importc, dynlib: "../lib/cimgc.dll".}
proc clear(r:float32, g:float32, b:float32): void {.importc, dynlib: "../lib/cimgc.dll".}
proc saveBMP(filename: cstring): void {.importc, dynlib: "../lib/cimgc.dll".}
proc display(): void {.importc, dynlib: "../lib/cimgc.dll".}
proc isClosed(): uint32 {.importc, dynlib: "../lib/cimgc.dll".}

openWindow(1024,1024,"Test Nim")
clear(0.0,0.0,0.0)
var offset:int32=0
while(isClosed()==0):
    for y in 0..1023:
        for x in 0..1023:
            var dx = float(x)-512
            var dy = float(y)-512
            var r = math.sqrt(dx*dx+dy*dy)
            if r>300:
                setPixel(uint32(x), uint32(y), float((x+offset) mod 1024)/1023.0f, float(y)/1023.0f, 0.0f)
            else:
                setPixel(uint32(x), uint32(y), 1.0f, 1.0f, 1.0f)
    offset=offset+1
    display()
