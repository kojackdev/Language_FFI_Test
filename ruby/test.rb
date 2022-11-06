require 'fiddle'

RubyInstaller::Runtime.add_dll_directory('../lib')

libm = Fiddle.dlopen('cimgc.dll')

openWindow = Fiddle::Function.new(libm['openWindow'], [Fiddle::TYPE_INT, Fiddle::TYPE_INT], Fiddle::TYPE_VOID)
setTitle = Fiddle::Function.new(libm['setTitle'], [Fiddle::TYPE_VOIDP], Fiddle::TYPE_VOID)
clear = Fiddle::Function.new(libm['clear'], [Fiddle::TYPE_FLOAT, Fiddle::TYPE_FLOAT, Fiddle::TYPE_FLOAT], Fiddle::TYPE_VOID)
display = Fiddle::Function.new(libm['display'], [], Fiddle::TYPE_VOID)
setPixel = Fiddle::Function.new(libm['setPixel'], [Fiddle::TYPE_INT, Fiddle::TYPE_INT, Fiddle::TYPE_FLOAT, Fiddle::TYPE_FLOAT, Fiddle::TYPE_FLOAT], Fiddle::TYPE_VOID)
isClosed = Fiddle::Function.new(libm['isClosed'], [], Fiddle::TYPE_INT)

openWindow.call(1024,1024)
setTitle.call("Ruby")
clear.call(0.5,1,0.5)
offset=0
while isClosed.call()==0
    1024.times {|y|
        1024.times {|x|
            dx=x-512.0
			dy=y-512.0
			r=Math.sqrt(dx*dx+dy*dy)
			if r>300
				setPixel.call(x,y,((x+offset)%1024)/1023.0,y/1023.0,0)
			else
				setPixel.call(x,y,1,1,1)
			end
        }
    }
	
    offset=offset+1
    display.call()
end

