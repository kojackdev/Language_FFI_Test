using System.Runtime.InteropServices;

[DllImport("cimgc")]
static extern void openWindow(uint width, uint height);
[DllImport("cimgc")]
static extern void setPixel(uint x, uint y, float r, float g, float b);
[DllImport("cimgc")]
static extern float getPixel(uint x, uint y, uint channel);
[DllImport("cimgc")]
static extern void clear(float r, float g, float b);
[DllImport("cimgc")]
static extern void saveBMP(string filename);
[DllImport("cimgc")]
static extern void display();
[DllImport("cimgc")]
static extern uint isClosed();
[DllImport("cimgc")]
static extern void setTitle(string title);
[DllImport("cimgc")]
static extern void showFPS(uint show);


Console.WriteLine("Hello, World!");
openWindow(1024, 1024);
clear(0.5f, 0.5f, 0.5f);
int offset = 0;

while (isClosed()==0)
{
	for (uint y = 0; y < 1024; ++y)
	{
		for (uint x = 0; x < 1024; ++x)
		{
			float dx = x - 512.0f;
			float dy = y - 512.0f;
			float r = (float)Math.Sqrt(dx * dx + dy * dy);
			if (r > 300.0)
			{
				setPixel(x, y, ((x + offset) % 1024) / 1023.0f, y / 1023.0f, 0.0f);
			}
			else
			{
				setPixel(x, y, 1.0f, 1.0f, 1.0f);
			}
		}
	}
	++offset;
	display();
}


