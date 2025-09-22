---
title: "Windows MCVS C++项目移植到Linux编译教程"
description: "详细介绍如何将Windows平台下的MCVS C++项目成功移植到Linux环境进行编译，包括环境准备、CMakeLists.txt编写、第三方库依赖处理、源码修改和编译测试等完整流程"
keywords: ["C++", "Linux", "Windows", "项目移植", "CMake", "编译", "MCVS", "跨平台开发"]
author: "Arkin"
date: 2024-05-16T10:00:00+08:00
lastmod: 2025-01-27T17:30:00+08:00
draft: false
tags: ["C++", "Linux", "Windows", "项目移植", "CMake", "编译", "跨平台开发"]
categories: ["技术"]
aliases: ["/posts/windows-cpp-linux-migration"]
image: "img/cpp-linux-migration.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> 本文将详细介绍如何将Windows平台下的MCVS C++项目成功移植到Linux环境进行编译，包括环境准备、CMakeLists.txt编写、第三方库依赖处理、源码修改和编译测试等完整流程。

## 概述

在软件开发过程中，经常需要将Windows平台下开发的C++项目移植到Linux环境。本文将基于实际项目经验，详细介绍从Windows MCVS C++项目到Linux编译的完整移植流程。

## 学习目标

通过本教程，您将学会：

- 如何在Linux上准备编译环境
- 如何创建`CMakeLists.txt`文件，转换项目文件
- 如何处理第三方库依赖
- 如何在Linux上编译和测试项目

## 移植流程

### 1. 确认Linux环境

首先需要确认Linux系统是否安装了必要的编译工具：

```bash
# 检验命令
gcc --version
g++ --version
make --version
cmake --version

# 如果没有，Ubuntu系统安装
sudo apt update
sudo apt install g++ gcc
sudo apt install cmake
sudo apt install make
```

### 2. 编写CMakeLists.txt

#### 2.1 基础CMakeLists.txt

创建项目根目录下的`CMakeLists.txt`文件：

```cmake
# CMakeLists.txt
# 需要根据自己项目的实际情况编写，并不通用
cmake_minimum_required(VERSION 3.10)
project(CGALTools)

# 添加源文件
file(GLOB_RECURSE SOURCES "*.cpp" "*.h")

# 生成动态链接库
add_library(CGALTools SHARED ${SOURCES})
```

#### 2.2 清理MCVS项目文件

在移植过程中，需要删除Windows特有的项目文件：

![清理MCVS项目文件](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516100910445.png)

### 3. 处理源码

#### 3.1 修改Windows特有的头文件

移植过程中最常见的问题是源码引入了Windows特有的模块导致编译失败：

![Windows头文件错误](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516102057048.png)

**修改前的代码：**

```c
#ifndef PCH_H
#define PCH_H
#include <windows.h> // 确保windows.h首先被包含

#ifndef WINGDIAPI
#define WINGDIAPI extern __declspec(dllimport)
#endif
#ifndef APIENTRY
#define APIENTRY __stdcall
#endif
#ifndef GLAPI
#define GLAPI extern
#endif

#include <GL/gl.h>
#endif // PCH_H
```

**修改后的代码：**

```c
#ifndef PCH_H
#define PCH_H

#ifndef _WIN32
#include <GL/gl.h>
#endif

#endif // PCH_H
```

#### 3.2 修改函数导出语法

对于需要将C++函数导出成C函数的项目，需要处理平台差异：

```cpp
// Windows的语法为 __declspec(dllexport)
// Linux的语法为 DLL_EXPORT
// 为了兼容，需要将所有使用到该声明的地方 __declspec(dllexport) 修改成 DLL_EXPORT

// 在头文件的开头处加入以下代码
#if defined(_WIN32) || defined(__CYGWIN__)
  #define DLL_EXPORT __declspec(dllexport)
#else
  #define DLL_EXPORT
#endif
// 这样可以保证Windows也能使用该头文件
```

### 4. 处理依赖库

#### 4.1 方式一：源码编译

适用于第三方库比较小众或需要特殊版本的场景：

```bash
# 一般通过编译方式需要根据源码方式来选择，正常都是支持make工具还有cmake工具
```

#### 4.2 方式二：包管理器安装

适用于大部分场景，比较轻松：

```bash
# 举例，当前项目需要安装的依赖如下：
sudo apt-get update
# 安装OpenSceneGraph库
sudo apt-get install libopenscenegraph-dev
# 安装GDAL库
sudo apt-get install libgdal-dev
# 安装TinyXML2库
sudo apt-get install libtinyxml2-dev
# 安装OpenGL库
sudo apt-get install libgl-dev
# 安装CGAL库
sudo apt-get install libcgal-dev
# 安装PugiXML库
sudo apt-get install libpugixml-dev
# 由于需要用到Java的jni.h，还需要安装JDK
sudo apt-get install default-jdk
```

#### 4.3 完整CMakeLists.txt配置

处理完成之后，有些库可能无法自动识别位置，需要通过`CMakeLists.txt`文件来指定具体路径：

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.10)
project(CGALTools)

# 添加源文件，排除main.cpp
file(GLOB_RECURSE SOURCES "*.cpp" "*.h")
list(REMOVE_ITEM SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

# 生成动态链接库
add_library(CGALTools SHARED ${SOURCES})

# 添加包含gdal, jni的项目
include_directories(/usr/include/gdal)
include_directories(/usr/lib/jvm/java-11-openjdk-amd64/include)
include_directories(/usr/lib/jvm/java-11-openjdk-amd64/include/linux)

# 查找并链接库
find_package(OpenSceneGraph REQUIRED COMPONENTS osgDB osgUtil osgViewer)

# 手动设置TinyXML2的包含路径
include_directories(/usr/include)

# 链接库
# 这里的mpfr和gmp两个库的安装和链接顺序都有影响，需要注意
target_link_libraries(CGALTools
    ${GDAL_LIBRARIES}
    tinyxml2
    mpfr
    gmp
    ${OPENSCENEGRAPH_LIBRARIES}
)

# 添加测试可执行文件
add_executable(CGALToolsTest main.cpp)

# 链接库到测试可执行文件
target_link_libraries(CGALToolsTest CGALTools gdal tinyxml2 mpfr)
```

### 5. 编译

```bash
# 跳转到项目文件夹
cd /path/to/project
# 创建build目录
mkdir build
# 跳转到编译目录
cd build
# 执行cmake
cmake ..
# 执行make
make
```

编译成功如下图所示：

![编译成功](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516143118767.png)

### 6. 测试

#### 6.1 准备测试环境

当成功编译后，得到了`.so`动态链接库，我们可以新创建一个项目来测试函数是否正常：

```bash
# 跳转到测试项目
cd /path/to/cgal-tools-test
# 将.so和.so相关的头文件copy到根目录下
# 创建测试脚本test.cpp
```

#### 6.2 Java JNI测试

由于这个示例项目是针对Java项目的JNI使用，因此测试代码需要在Java层面去写：

**创建CGALTools.java文件：**

```java
// 注意，这里文件名是唯一的，因为要和jni.h生成的头文件签名匹配，不匹配会报错说找不到函数
/*
 * Class:     CGALTools
 * Method:    buildHexahedron
 * Signature: ([D[D)J

JNIEXPORT jlong JNICALL Java_CGALTools_buildHexahedron
  (JNIEnv *, jobject, jdoubleArray, jdoubleArray);
*/
```

**完整的测试代码：**

```java
// CGALTools.java
public class CGALTools {
    static {
        System.load("/media/lwq/git/cgal-tools-test/libCGALTools.so");
    }

    public native long buildHexahedron(double[] upperVerts, double[] lowerVerts);

    public static void main(String[] args) {
        CGALTools cgalTools = new CGALTools();
        double[] upperVerts = {118.12388888888889, 22.12388888888889, 67.52235458791256,
                                118.12444444444444, 22.12388888888889, 67.52235458791256,
                                118.12444444444444, 22.124444444444443, 67.52235458791256,
                                118.12388888888889, 22.124444444444443, 67.52235458791256};
        double[] lowerVerts = {118.12388888888889, 22.12388888888889, 13.224607621319592,
                                118.12444444444444, 22.12388888888889, 13.224607621319592,
                                118.12444444444444, 22.124444444444443, 13.224607621319592,
                                118.12388888888889, 22.124444444444443, 13.224607621319592};

        long result = cgalTools.buildHexahedron(upperVerts, lowerVerts);
        if (result != 0) {
            System.out.println("多面体创建成功。");
        } else {
            System.out.println("多面体创建失败。");
        }
    }
}
```

**运行测试：**

```bash
# 创建完成CGALTools.java后，运行
javac CGALTools.java 
java CGALTools 
```

输出正常即测试成功：

![测试成功](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516155411679.png)

## 总结

通过以上步骤，我们成功将Windows MCVS C++项目移植到Linux环境。关键点包括：

1. **环境准备**：确保Linux系统安装了必要的编译工具
2. **项目转换**：使用CMake替代MCVS项目文件
3. **源码修改**：处理Windows特有的头文件和语法
4. **依赖处理**：通过包管理器或源码编译安装第三方库
5. **编译测试**：使用标准的CMake构建流程进行编译和测试

这个过程虽然繁琐，但通过系统性的方法，可以确保项目在Linux环境下正常运行。
