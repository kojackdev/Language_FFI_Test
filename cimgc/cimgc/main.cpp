
#include "CImg.h"
#include "kf/kf_time.h"
#include "cimgc.h"
#include "fstream"

using namespace cimg_library;

CImg<float> g_image;
CImgDisplay g_mainDisp;
unsigned int g_width = 0;
unsigned int g_height = 0;
kf::Time g_timer;
long long g_lastTime = 0;
double g_maxFPS = 0;
bool g_showFPS = true;
int g_frameCount = 0;

CIMGC_API void openWindow(unsigned int width, unsigned height)
{
	g_image.assign(width, height, 1, 3, 0);
	g_mainDisp.assign(g_image);
	g_mainDisp.set_normalization(0);
	g_width = width;
	g_height = height;
	g_lastTime = g_timer.getTicks();
}

CIMGC_API void setPixel(unsigned int x, unsigned int y, float r, float g, float b)
{
	g_image(x % g_width, y % g_height, 0, 0) = r * 255;
	g_image(x % g_width, y % g_height, 0, 1) = g * 255;
	g_image(x % g_width, y % g_height, 0, 2) = b * 255;
}

CIMGC_API float getPixel(unsigned int x, unsigned int y, unsigned int channel)
{
	return g_image(x % g_width, y % g_height, 0, channel) / 255.0f;
}

CIMGC_API void clear(float r, float g, float b)
{
	for (unsigned int y = 0; y < g_height; ++y)
	{
		for (unsigned int x = 0; x < g_width; ++x)
		{
			g_image(x, y, 0, 0) = r * 255;
			g_image(x, y, 0, 1) = g * 255;
			g_image(x, y, 0, 2) = b * 255;
		}
	}
}

CIMGC_API void saveBMP(const char* name)
{
	g_image.save_bmp(name);
}

CIMGC_API void display()
{
	if (g_showFPS)
	{
		long long current = g_timer.getTicks();
		double time = g_timer.ticksToSeconds(current - g_lastTime);
		double fps = 1.0 / time;

		if (fps > g_maxFPS && g_frameCount>2)
			g_maxFPS = fps;
		g_frameCount++;
		if (g_frameCount % 4 == 0)
			g_mainDisp.set_title("FPS: %0.2f (%0.2f)", fps, g_maxFPS);
		g_lastTime = current;
	}
	g_mainDisp.display(g_image);
}

CIMGC_API unsigned int isClosed()
{
	return g_mainDisp.is_closed() ? 1 : 0;
}

CIMGC_API void setTitle(const char* title)
{
	g_mainDisp.set_title(title);
}

CIMGC_API void showFPS(unsigned int show)
{
	g_showFPS = show;
}

