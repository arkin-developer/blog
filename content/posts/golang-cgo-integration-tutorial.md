---
title: "Golang集成C接口教程：CGo跨语言编程实践"
description: "详细介绍如何使用CGo工具在Golang中集成C/C++库，包括环境配置、DLL编译、CGo代码编写和跨语言接口调用的完整实现方法"
keywords: ["Golang", "CGo", "C语言", "跨语言编程", "DLL", "GDAL", "MSYS2", "MinGW", "编程实践"]
author: "Arkin"
date: 2024-05-02T17:30:00+08:00
lastmod: 2025-01-27T18:15:00+08:00
draft: false
tags: ["Golang", "CGo", "C语言", "跨语言编程", "DLL", "GDAL", "MSYS2", "MinGW"]
categories: ["技术"]
aliases: ["/posts/golang-cgo-integration"]
image: "img/golang-cgo-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Go语言设计上提供了对外部语言的接口，尤其是C语言，通过CGo工具，可以在Go程序中直接包含C代码，或者调用C编译的动态库。本文详细介绍CGo跨语言编程的完整实现方法。

## 概述

Go语言设计上提供了对外部语言的接口，尤其是C语言，通过CGo工具，可以在Go程序中直接包含C代码，或者调用C编译的动态库。这一机制不仅增强了Go的灵活性，也使得Go能够利用到大量现有的C/C++库，特别是在系统编程、性能要求高的应用场合。

### 重要注意事项

- 建议统一使用MSYS2来（Windows系统）管理，Linux系统待后续补充
- 使用MinGW环境会比MCVS环境会更好（个人使用体验）
- CGo只能兼容C的接口，因此如果是用的库是C++的，需要重新写脚本导出成C接口
- 如果用的不是标准库，建议先用C项目编译成DLL再在CGo中使用

## 实现流程

### 环境设置

*[MSYS2 官网](https://www.msys2.org/)*

Golang在使用CGo功能的时候，会自动找当前可用的GCC编译器（MinGW/TDM-GCC），建议MinGW。

1. **安装**，可以通过exe安装；

2. **设置环境变量**，将bin路径添加到环境变量下；

3. **打开MSYS2命令窗口**，找到合适自己系统的命令行窗口，例如：`MSYS2 MINGW64`

4. **安装MinGW**；

   ```cmd
   # 如果提示重启MSYS2，关闭终端窗口，重新打开并再次运行上述命令
   pacman -Syu
   # 根据您的需求选择安装MinGW-w64的32位或64位版本。对于64位系统，运行：
   pacman -S mingw-w64-x86_64-toolchain
   ```

5. **将MinGW加入到系统路径**，MinGW的bin目录通常位于`C:\msys64\mingw64\bin`（对于64位）或`C:\msys64\mingw32\bin`（对于32位）

### 创建C/C++项目编译DLL

这里选择实现CGo集成GDAL库来做示例

#### 1. 创建C++项目

GDAL是一个C++项目，因此我需要先将GDAL我需要的函数先导出C接口

```cmd
# 创建项目文件夹
mkdir cgo-test2
# 创建gdal_wrapper.h gdal_wrapper.cpp Makefile在windows cmd的创建命令
echo. > gdal_wrapper.h
echo. > gdal_wrapper.cpp
echo. > Makefile
```

**gdal_wrapper.h**：

```cpp
// gdal_wrapper.h

#ifdef __cplusplus
// 必须要通过C接口导出
extern "C" {	
#endif

void* CreateTransformer(int sourceEPSG, int targetEPSG);
void DestroyTransformer(void* transformer);
int TransformPoint(void* transformer, double* x, double* y, double* z);

#ifdef __cplusplus
}
#endif
```

**gdal_wrapper.cpp**：

```cpp
// gdal_wrapper.cpp
// 导入已经定义好的头文件，完成具体实现
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

#### 2. 编写Makefile

通过Makefile完成编译以及动态依赖文件DLL的获取

```makefile
# Makefile示例

# 编译器设置
CXX=g++
CXXFLAGS=-IC:/msys64/mingw64/include
LDFLAGS=-LC:/msys64/mingw64/lib -lgdal

# 源代码和目标设置
SRC=gdal_wrapper.cpp
TARGET=E:/Git/My/cgo-test2/gdal_wrapper.dll
COPY_DIR=E:/Git/My/cgo-test2

# 默认目标
all: $(TARGET) copy_dlls

# 构建目标
$(TARGET): $(SRC)
	$(CXX) -shared -o $@ $^ $(CXXFLAGS) $(LDFLAGS)

# 复制DLL文件
copy_dlls:
	@echo "Copying DLL files..."
	@cp C:/msys64/mingw64/bin/libgdal*.dll $(COPY_DIR)/
	@cp C:/msys64/mingw64/bin/libproj*.dll $(COPY_DIR)/
	@cp C:/msys64/mingw64/bin/libgeos_c*.dll $(COPY_DIR)/

# 清理目标
clean:
	rm -f $(TARGET)
	rm -f $(COPY_DIR)/*.dll
```

#### 3. 编译项目

通过MSYS2完成项目的编译

打开`MSYS2 MINGW64`命令指示符

```
zkyy_lai@zkyylai1 MINGW64 /e/Git/My/cgo-test2
# cd "e:/Git/My/cgo-test2"

zkyy_lai@zkyylai1 MINGW64 /e/Git/My/cgo-test2
# make
Copying DLL files...

zkyy_lai@zkyylai1 MINGW64 /e/Git/My/cgo-test2
# 
```

输出完如图所示：

![编译完成](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240502175340059.png)

### 编写CGo代码

#### 1. 创建Go项目

为了方便可以在cgo-test2中创建

```cmd
# 跳转到cgo-test2
cd E:\Git\My\cgo-test2
# 创建go项目
go mod init cgo-test2
go mod tidy
```

#### 2. 编写主函数

在主函数中编写CGo代码，也就是注释部分

```go
// main.go
package main

/*
#cgo CFLAGS: -IC:/msys64/mingw64/include
#cgo LDFLAGS: -LC:/msys64/mingw64/lib -lgdal
// gdal_wrapper.h就是自己编译好的.dll的头文件
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

## 技术细节

### 使用CGo指令

在Go源文件中，可以通过`CGo`指令设置编译器和链接器参数：

```go
/*
#cgo CFLAGS: -I/usr/local/include
#cgo LDFLAGS: -L/usr/local/lib -lmylib
#include "mylib.h"
*/
import "C"
```

这里记得`import "C"`和以上的`/* CGo指令 */`之间不能留空，不能**空一行**。

### CGo指令的含义

- **#cgo CFLAGS**：设置C编译器（gcc或clang）的编译选项。这些标志可以指定包含文件搜索路径、优化级别、警告级别等。例如，`-I`用于添加头文件的搜索路径。
- **#cgo LDFLAGS**：设置链接器的选项。这些标志用于指定库文件搜索路径、链接的库等。例如，`-L`用于添加库文件的搜索路径，`-l`用于指定要链接的库。
- **#cgo CPPFLAGS**：设置C预处理器的选项。这通常用于设置宏定义或包含路径。它们在预处理阶段被使用，例如，`-D`用于定义宏，`-I`同样用于添加包含文件的搜索路径。注意，CPPFLAGS通常会影响所有的C、C++和Objective-C文件。
- **#cgo pkg-config**：用于简化库文件和头文件路径的设置。`pkg-config`是一个帮助管理编译和链接参数的工具，特别是在处理包含和库路径时非常有用。通过指定需要的包名，`pkg-config`会自动配置正确的`CFLAGS`和`LDFLAGS`。例如，如果你使用`pkg-config --cflags --libs glfw3`，这会自动添加使用GLFW3需要的编译器和链接器标志。

### 关于在头文件导入第三方库引发的问题

先看我第一次头文件的版本

```cpp
// gdal_wrapper.h

=================== 不同的部分 ==================
#include <gdal.h>
#include <ogr_spatialref.h>
=================== 不同的部分 ==================
    
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

第一次这样做的时候，在go build编译一直出现问题，应该是CGo在导入`gdal_wrapper.h`，又会去重新导入一次`gdal.h`和`ogr_spatialref.h`，这两个库是用C++实现的，因此会有冲突，我们在`gdal_wrapper.h`项目中已经转换成C接口，因此是兼容的，这种更改有效地将C++的内容限制在CPP文件中，避免了C编译器处理C++代码时的问题。以后记得.h文件极可能不要导入具体的第三方库。

![编译错误](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240502182533181.png)

## 总结

通过本文的学习，我们掌握了Golang集成C接口的完整流程：

1. **环境配置**：使用MSYS2和MinGW搭建C/C++编译环境
2. **DLL编译**：将C++库封装成C接口并编译为动态链接库
3. **CGo集成**：在Go代码中使用CGo指令调用C接口
4. **问题解决**：避免头文件中的第三方库冲突问题

CGo为Golang提供了强大的跨语言编程能力，使得Go能够充分利用现有的C/C++生态系统，在系统编程和高性能应用开发中发挥重要作用。
