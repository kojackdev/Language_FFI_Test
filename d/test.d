module testd;

import std.stdio;
import std.math;

extern (C) void openWindow(uint width, uint height);
extern (C) void setTitle(const char *title);
extern (C) void setPixel(uint x, uint y, float r, float g, float b);
extern (C) void clear(float r, float g, float b);
extern (C) void saveBMP(const char *filename);
extern (C) void display();
extern (C) uint isClosed();

int main()
{

    openWindow(1024,1024);
	setTitle("D");
	clear(0.5,0.5,0.5);
	int offset=0;
	while(!isClosed())
	{
		for(uint y=0;y<1024;++y)
		{
			for(uint x=0;x<1024;++x)
			{
				float dx = x - 512.0;
				float dy = y - 512.0;
				float r = sqrt(dx*dx+dy*dy);
				if(r>300.0)
				{
					setPixel(x, y, ((x+offset) % 1024) / 1023.0, y / 1023.0, 0.0);
				}
				else
				{
					setPixel(x, y, 1.0, 1.0, 1.0);
				}
			}
		}
		++offset;
		display();
	}
    return 0;
}
