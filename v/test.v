import math
#flag -lcimgc
#flag -I../lib
#flag -L../lib
#include "cimgc.h"

fn C.openWindow(width int, height int)
fn C.setTitle(title &char)
fn C.isClosed() int
fn C.display()
fn C.setPixel(x u32, y u32, r f32, g f32, b f32)
fn C.clear(r f32, g f32, b f32)
fn C.getPixel(x u32, y u32, channel u32) f32
fn C.saveBMP(name &char)

fn main() {
	C.openWindow(1024, 1024)
	C.setTitle(c'V')
	mut offset:=0
	mut dx := 0.0
	mut dy := 0.0
	mut r := 301.0
	for C.isClosed()==0
	{
		for y in 0 .. 1023 
		{
			for x in 0 .. 1023 
			{
				dx = x - 512
				dy = y - 512
				r = math.sqrt(dx*dx+dy*dy)
				if r>300.0 
				{
					C.setPixel(x, y, f32((x+offset) % 1024) / 1023.0, y / 1023.0, 0.0)
				}
				else
				{
					C.setPixel(x, y, 1.0, 1.0, 1.0)
				}
			}
		}
		offset=offset+1
		C.display()
	}
	println(dx+dy)
}
