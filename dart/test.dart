import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';

typedef openWindow_func = Void Function(Int32 a, Int32 b);
typedef openWindow = void Function(int a, int b);

typedef setTitle_func = Void Function(Pointer<Utf8> title);
typedef setTitle = void Function(Pointer<Utf8> title);

typedef isClosed_func = Int32 Function();
typedef isClosed = int Function();

typedef setPixel_func = Void Function(Int32 x, Int32 y, Float r, Float g, Float b);
typedef setPixel = void Function(int x, int y, double r, double g, double b);

typedef display_func = Void Function();
typedef display = void Function();

main() 
{
  var path = "../lib/cimgc.dll";
  final dylib = ffi.DynamicLibrary.open(path);

  final openWindow openWindowD = dylib.lookup<ffi.NativeFunction<openWindow_func>>('openWindow').asFunction();
  final setTitle setTitleD = dylib.lookup<ffi.NativeFunction<setTitle_func>>('setTitle').asFunction();
  final isClosed isClosedD = dylib.lookup<ffi.NativeFunction<isClosed_func>>('isClosed').asFunction();
  final display displayD = dylib.lookup<ffi.NativeFunction<display_func>>('display').asFunction();
  final setPixel setPixelD = dylib.lookup<ffi.NativeFunction<setPixel_func>>('setPixel').asFunction();

  // Call the function
  openWindowD(1024,1024);
  setTitleD("Dart".toNativeUtf8());
  
  int offset = 0;
  while(isClosedD()==0)
  {
	for(int y=0;y<1024;++y)
	{
		for(int x=0;x<1024;++x)
		{
			double dx = x - 512.0;
			double dy = y - 512.0;
			double r = sqrt(dx*dx+dy*dy);
			if(r>300.0)
			{
				setPixelD(x,y,((x+offset)%1024)/1023.0,y/1023.0,0);
			}
			else
			{
				setPixelD(x,y,1,1,1);
			}
		}
	
	}
	++offset;
	displayD();
  }
}
