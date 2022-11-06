#pragma once
#define CIMGC_API __declspec(dllexport)

extern "C"
{
	CIMGC_API void openWindow(unsigned int width, unsigned height);
	CIMGC_API void setPixel(unsigned int x, unsigned int y, float r, float g, float b);
	CIMGC_API float getPixel(unsigned int x, unsigned int y, unsigned int channel);
	CIMGC_API void clear(float r, float g, float b);
	CIMGC_API void saveBMP(const char* name);
	CIMGC_API void display();
	CIMGC_API unsigned int isClosed();
	CIMGC_API void setTitle(const char* title);
	CIMGC_API void showFPS(unsigned int show);

}
