---
title: "Golang C Interface Integration Tutorial: CGo Cross-Language Programming Practice"
description: "A comprehensive guide on using CGo tools to integrate C/C++ libraries in Golang, covering environment configuration, DLL compilation, CGo code writing, and complete implementation methods for cross-language interface calls"
keywords: ["Golang", "CGo", "C Language", "Cross-Language Programming", "DLL", "GDAL", "MSYS2", "MinGW", "Programming Practice"]
author: "Arkin"
date: 2024-05-02T17:30:00+08:00
lastmod: 2025-01-27T18:15:00+08:00
draft: false
tags: ["Golang", "CGo", "C Language", "Cross-Language Programming", "DLL", "GDAL", "MSYS2", "MinGW"]
categories: ["Technology"]
aliases: ["/posts/golang-cgo-integration"]
image: "img/golang-cgo-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Go language is designed to provide interfaces to external languages, especially C language. Through CGo tools, you can directly include C code in Go programs or call dynamically linked libraries compiled by C. This article provides a detailed introduction to the complete implementation methods of CGo cross-language programming.

## Overview

Go language is designed to provide interfaces to external languages, especially C language. Through CGo tools, you can directly include C code in Go programs or call dynamically linked libraries compiled by C. This mechanism not only enhances Go's flexibility but also enables Go to leverage a large number of existing C/C++ libraries, especially in system programming and high-performance application scenarios.

### Important Notes

- Recommend using MSYS2 uniformly for management (Windows system), Linux system to be supplemented later
- Using MinGW environment is better than MCVS environment (personal experience)
- CGo can only be compatible with C interfaces, so if the library used is C++, you need to rewrite scripts to export C interfaces
- If not using standard libraries, recommend first compiling C projects into DLLs and then using them in CGo

## Implementation Process

### Environment Setup

*[MSYS2 Official Website](https://www.msys2.org/)*

When Golang uses CGo functionality, it automatically finds the currently available GCC compiler (MinGW/TDM-GCC). MinGW is recommended.

1. **Installation**, can be installed through exe;

2. **Set environment variables**, add bin path to environment variables;

3. **Open MSYS2 command window**, find the command line window suitable for your system, for example: `MSYS2 MINGW64`

4. **Install MinGW**;

   ```cmd
   # If prompted to restart MSYS2, close the terminal window, reopen and run the above command again
   pacman -Syu
   # According to your needs, choose to install 32-bit or 64-bit version of MinGW-w64. For 64-bit systems, run:
   pacman -S mingw-w64-x86_64-toolchain
   ```

5. **Add MinGW to system path**, MinGW's bin directory is usually located at `C:\msys64\mingw64\bin` (for 64-bit) or `C:\msys64\mingw32\bin` (for 32-bit)

### Create C/C++ Project Compile DLL

Here we choose to implement CGo integration with GDAL library as an example

#### 1. Create C++ Project

GDAL is a C++ project, so I need to first export the functions I need from GDAL as C interfaces

```cmd
# Create project folder
mkdir cgo-test2
# Create gdal_wrapper.h gdal_wrapper.cpp Makefile commands in windows cmd
echo. > gdal_wrapper.h
echo. > gdal_wrapper.cpp
echo. > Makefile
```

**gdal_wrapper.h**:

```cpp
// gdal_wrapper.h

#ifdef __cplusplus
// Must export through C interface
extern "C" {	
#endif

void* CreateTransformer(int sourceEPSG, int targetEPSG);
void DestroyTransformer(void* transformer);
int TransformPoint(void* transformer, double* x, double* y, double* z);

#ifdef __cplusplus
}
#endif
```

**gdal_wrapper.cpp**:

```cpp
// gdal_wrapper.cpp
// Import pre-defined header files and complete specific implementation
#include "gdal_wrapper.h"
#include <gdal.h>
#include <ogr_spatialref.h>

void* CreateTransformer(int sourceEPSG, int targetEPSG) {
    GDALAllRegister();

    OGRSpatialReferenceH src = OSRNewSpatialReference(NULL);
    OGRSpatialReferenceH dst = OSRNewSpatialReference(NULL);

    OSRImportFromEPSG(src, sourceEPSG);
    OSRImportFromEPSG(dst, targetEPSG);

    OGRCoordinateTransformationH transformer = OCTNewCoordinateTransformation(src, dst);
    return (void*)transformer;
}

void DestroyTransformer(void* transformer) {
    OCTDestroyCoordinateTransformation((OGRCoordinateTransformationH)transformer);
}

int TransformPoint(void* transformer, double* x, double* y, double* z) {
    double z_in = *z;
    if (OCTTransform((OGRCoordinateTransformationH)transformer, 1, x, y, &z_in)) {
        *z = z_in;
        return 1;
    }
    return 0;
}
```

#### 2. Write Makefile

Complete compilation and dynamic dependency file DLL acquisition through Makefile

```makefile
# Makefile Example

# Compiler settings
CXX=g++
CXXFLAGS=-IC:/msys64/mingw64/include
LDFLAGS=-LC:/msys64/mingw64/lib -lgdal

# Source code and target settings
SRC=gdal_wrapper.cpp
TARGET=E:/Git/My/cgo-test2/gdal_wrapper.dll
COPY_DIR=E:/Git/My/cgo-test2

# Default target
all: $(TARGET) copy_dlls

# Build target
$(TARGET): $(SRC)
	$(CXX) -shared -o $@ $^ $(CXXFLAGS) $(LDFLAGS)

# Copy DLL files
copy_dlls:
	@echo "Copying DLL files..."
	@cp C:/msys64/mingw64/bin/libgdal*.dll $(COPY_DIR)/
	@cp C:/msys64/mingw64/bin/libproj*.dll $(COPY_DIR)/
	@cp C:/msys64/mingw64/bin/libgeos_c*.dll $(COPY_DIR)/

# Clean target
clean:
	rm -f $(TARGET)
	rm -f $(COPY_DIR)/*.dll
```

#### 3. Compile Project

Complete project compilation through MSYS2

Open `MSYS2 MINGW64` command prompt

```
zkyy_lai@zkyylai1 MINGW64 /e/Git/My/cgo-test2
# cd "e:/Git/My/cgo-test2"

zkyy_lai@zkyylai1 MINGW64 /e/Git/My/cgo-test2
# make
Copying DLL files...

zkyy_lai@zkyylai1 MINGW64 /e/Git/My/cgo-test2
# 
```

Output completion as shown in the figure:

![Compilation Complete](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240502175340059.png)

### Write CGo Code

#### 1. Create Go Project

For convenience, can be created in cgo-test2

```cmd
# Navigate to cgo-test2
cd E:\Git\My\cgo-test2
# Create go project
go mod init cgo-test2
go mod tidy
```

#### 2. Write Main Function

Write CGo code in the main function, which is the comment section

```go
// main.go
package main

/*
#cgo CFLAGS: -IC:/msys64/mingw64/include
#cgo LDFLAGS: -LC:/msys64/mingw64/lib -lgdal
// gdal_wrapper.h is the header file of the self-compiled .dll
#include "gdal_wrapper.h" 
*/
import "C"
import (
	"fmt"
)

func main() {
	// Source and target EPSG codes
	sourceEPSG := C.int(4326) // WGS 84
	targetEPSG := C.int(3857) // Web Mercator

	// Create transformer
	transformer := C.CreateTransformer(sourceEPSG, targetEPSG)
	defer C.DestroyTransformer(transformer)

	// Input coordinates
	x := C.double(23.0)
	y := C.double(114.0)
	z := C.double(0.0)

	// Transform point
	success := C.TransformPoint(transformer, &x, &y, &z)
	if success != 0 {
		fmt.Printf("Transformed Point: %.2f, %.2f, %.2f\n", float64(x), float64(y), float64(z))
	} else {
		fmt.Println("Failed to transform point")
	}
}
```

## Technical Details

### Using CGo Directives

In Go source files, you can set compiler and linker parameters through `CGo` directives:

```go
/*
#cgo CFLAGS: -I/usr/local/include
#cgo LDFLAGS: -L/usr/local/lib -lmylib
#include "mylib.h"
*/
import "C"
```

Remember that there should be no empty line between `import "C"` and the above `/* CGo directives */`.

### Meaning of CGo Directives

- **#cgo CFLAGS**: Set compilation options for C compiler (gcc or clang). These flags can specify include file search paths, optimization levels, warning levels, etc. For example, `-I` is used to add header file search paths.
- **#cgo LDFLAGS**: Set linker options. These flags are used to specify library file search paths, linked libraries, etc. For example, `-L` is used to add library file search paths, `-l` is used to specify libraries to link.
- **#cgo CPPFLAGS**: Set C preprocessor options. This is usually used to set macro definitions or include paths. They are used in the preprocessing stage, for example, `-D` is used to define macros, `-I` is also used to add include file search paths. Note that CPPFLAGS usually affects all C, C++, and Objective-C files.
- **#cgo pkg-config**: Used to simplify the setting of library file and header file paths. `pkg-config` is a tool that helps manage compilation and linking parameters, especially useful when dealing with include and library paths. By specifying the required package names, `pkg-config` automatically configures the correct `CFLAGS` and `LDFLAGS`. For example, if you use `pkg-config --cflags --libs glfw3`, this will automatically add the compiler and linker flags needed to use GLFW3.

### Issues Caused by Importing Third-Party Libraries in Header Files

Let me first look at my first version of the header file

```cpp
// gdal_wrapper.h

=================== Different parts ==================
#include <gdal.h>
#include <ogr_spatialref.h>
=================== Different parts ==================
    
#ifdef __cplusplus
extern "C" {
#endif

void* CreateTransformer(int sourceEPSG, int targetEPSG);
void DestroyTransformer(void* transformer);
int TransformPoint(void* transformer, double* x, double* y, double* z);

#ifdef __cplusplus
}
#endif
```

When I did this the first time, there were always problems during go build compilation. It should be that CGo, when importing `gdal_wrapper.h`, would re-import `gdal.h` and `ogr_spatialref.h`. These two libraries are implemented in C++, so there would be conflicts. We have already converted them to C interfaces in the `gdal_wrapper.h` project, so they are compatible. This change effectively restricts C++ content to CPP files, avoiding problems when C compilers process C++ code. Remember in the future that .h files should avoid importing specific third-party libraries.

![Compilation Error](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240502182533181.png)

## Summary

Through this article, we have mastered the complete process of Golang C interface integration:

1. **Environment Configuration**: Use MSYS2 and MinGW to set up C/C++ compilation environment
2. **DLL Compilation**: Package C++ libraries into C interfaces and compile into dynamic link libraries
3. **CGo Integration**: Use CGo directives in Go code to call C interfaces
4. **Problem Solving**: Avoid third-party library conflicts in header files

CGo provides Golang with powerful cross-language programming capabilities, enabling Go to fully leverage the existing C/C++ ecosystem and play an important role in system programming and high-performance application development.
