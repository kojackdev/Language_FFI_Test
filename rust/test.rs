use std::ffi::{CString};
use std::os::raw::c_char;

#[link(name = "../lib/cimgc")]
extern {
  fn openWindow(width:u32,height:u32,title:*const c_char);
  fn setPixel(x:u32,y:u32,r:f32,g:f32,b:f32);
  fn clear(r:f32,g:f32,b:f32);
  fn saveBMP(filename:*const c_char);
  fn display();
  fn isClosed()->u32;
}

fn main() {
	let s = CString::new("data data data data").expect("CString::new failed");
	let name = CString::new("test.bmp").expect("CString::new failed");
	unsafe
	{
		openWindow(1024,1024,s.as_ptr());
		clear(0.0,1.0,0.0);
		let mut offset = 0;
		while isClosed()==0
		{
			for y in 0..1024
			{
				for x in 0..1024
				{
					let dx = x as f32 - 512.0;
					let dy = y as f32 - 512.0;
					let r = f32::sqrt(dx*dx+dy*dy);
					if r>300.0
					{
						setPixel(x,y,((x+offset)%1024) as f32 / 1023.0,y as f32 /1023.0,0.0);
					}
					else
					{
						setPixel(x,y,1.0,1.0,1.0);
					}
				}
			}
			offset = offset + 1;
			display();
		}
	}
}
