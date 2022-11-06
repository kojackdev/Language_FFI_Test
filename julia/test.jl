function openWindow(width,height)
    ccall((:openWindow, "../lib/cimgc"), Cvoid, (UInt32, UInt32), width, height)
end
function setTitle(title)
    ccall((:setTitle, "../lib/cimgc"), Cvoid, (Cstring,), title)
end
function clear(r,g,b)
    ccall((:clear, "../lib/cimgc"), Cvoid, (Float32, Float32, Float32), r, g, b)
end
function setPixel(x,y,r,g,b)
    ccall((:setPixel, "../lib/cimgc"), Cvoid, (UInt32, UInt32, Float32, Float32, Float32), x, y, r, g, b)
end
function saveBMP(filename)
    ccall((:saveBMP, "../lib/cimgc"), Cvoid, (Cstring,), filename)
end
function display()
    ccall((:display, "../lib/cimgc"), Cvoid, ())
end
function isClosed()
    ccall((:isClosed, "../lib/cimgc"), UInt32, ())
end

openWindow(1024,1024)
setTitle("Julia")

function render()
	offset=0
	while isClosed()==0
		for y=0:1023
			for x=0:1023
				dx=x-512.0
				dy=y-512.0
				r=sqrt(dx*dx+dy*dy)
				if r>300
					setPixel(x,y,((x+offset)%1024)/1023.0,y/1023.0,0)
				else
					setPixel(x,y,1,1,1)
				end
			end
		end
		offset=offset+1
		display()
	end
end

render()
