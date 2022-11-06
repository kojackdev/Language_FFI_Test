local ffi = require("ffi")
ffi.cdef[[
void openWindow(unsigned int width, unsigned int height, const char *name);
void setPixel(unsigned int x, unsigned int y, float r, float g, float b);
void display();
void clear(float r, float g, float b);
unsigned int isClosed();
]]
local cimgc = ffi.load("../lib/cimgc")

cimgc.openWindow(1024,1024,"Lua")

offset=0
while cimgc.isClosed()==0 do
    for y=0,1023 do
        for x=0,1023 do
            dx=x-512.0
            dy=y-512.0
            r=math.sqrt(dx*dx+dy*dy)
            if r>300 then
                cimgc.setPixel(x,y,((x+offset)%1024)/1023.0,y/1023.0,0)
            else
                cimgc.setPixel(x,y,1,1,1)
            end
        end
    end
    offset=offset+1
    cimgc.display()
end