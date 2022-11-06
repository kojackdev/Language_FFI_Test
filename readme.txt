Language FFI Test

This is a simple test of Foreign Function Interface access to dlls.
It uses cimgc.dll, a wrapper I wrote around the Cimg library.

The purpose of cimgc is to provide easy pixel access to a window, for software rendering.

The language tests are experiments in accessing a C API dll (in this case cimgc.dll) from other languages. For some languages (such as Julia), the dll is loaded by the test script using FFI features of the language. For some other languages (such as D or Rust) the cimgc.lib file is linked to the executable and loading of cimgc.dll is automatic.

Performance
The framerate of rendering the 1024x1024 pixels is displayed. There are two main things that are affecting performance:
- speed of the language
- speed of the FFI system
These tests don't try to break down performance to determine which of those was the bottleneck. 
This isn't really a benchmark, just a rough estimate of doing lots of FFI calls and more so what the FFI interface is like from a source code perspective.

