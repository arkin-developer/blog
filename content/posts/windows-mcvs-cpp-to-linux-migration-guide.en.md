---
title: "Windows MCVS C++ Project Migration to Linux Compilation Guide"
description: "A comprehensive guide on successfully migrating Windows MCVS C++ projects to Linux environment for compilation, including environment setup, CMakeLists.txt creation, third-party library dependency handling, source code modification, and compilation testing"
keywords: ["C++", "Linux", "Windows", "Project Migration", "CMake", "Compilation", "MCVS", "Cross-platform Development"]
author: "Arkin"
date: 2024-05-16T10:00:00+08:00
lastmod: 2024-05-16T10:00:00+08:00
draft: false
tags: ["C++", "Linux", "Windows", "Project Migration", "CMake", "Compilation", "Cross-platform Development"]
categories: ["Technology"]
aliases: ["/posts/windows-cpp-linux-migration"]
image: "img/cpp-linux-migration.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> This article provides a detailed guide on successfully migrating Windows MCVS C++ projects to Linux environment for compilation, including environment setup, CMakeLists.txt creation, third-party library dependency handling, source code modification, and compilation testing.

## Overview

In software development, it's often necessary to migrate C++ projects developed on Windows platform to Linux environment. This article, based on practical project experience, provides a comprehensive guide for the complete migration process from Windows MCVS C++ projects to Linux compilation.

## Learning Objectives

Through this tutorial, you will learn:

- How to prepare compilation environment on Linux
- How to create `CMakeLists.txt` files and convert project files
- How to handle third-party library dependencies
- How to compile and test projects on Linux

## Migration Process

### 1. Confirm Linux Environment

First, confirm whether the Linux system has installed necessary compilation tools:

```bash
# Check commands
gcc --version
g++ --version
make --version
cmake --version

# If not installed, install on Ubuntu system
sudo apt update
sudo apt install g++ gcc
sudo apt install cmake
sudo apt install make
```

### 2. Write CMakeLists.txt

#### 2.1 Basic CMakeLists.txt

Create the `CMakeLists.txt` file in the project root directory:

```cmake
# CMakeLists.txt
# Needs to be written according to your actual project situation, not universal
cmake_minimum_required(VERSION 3.10)
project(CGALTools)

# Add source files
file(GLOB_RECURSE SOURCES "*.cpp" "*.h")

# Generate dynamic link library
add_library(CGALTools SHARED ${SOURCES})
```

#### 2.2 Clean MCVS Project Files

During migration, Windows-specific project files need to be deleted:

![Clean MCVS Project Files](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516100910445.png)

### 3. Handle Source Code

#### 3.1 Modify Windows-Specific Headers

The most common issue during migration is source code including Windows-specific modules causing compilation failure:

![Windows Header Error](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516102057048.png)

**Code Before Modification:**

```c
#ifndef PCH_H
#define PCH_H
#include <windows.h> // Ensure windows.h is included first

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

**Code After Modification:**

```c
#ifndef PCH_H
#define PCH_H

#ifndef _WIN32
#include <GL/gl.h>
#endif

#endif // PCH_H
```

#### 3.2 Modify Function Export Syntax

For projects that need to export C++ functions as C functions, platform differences need to be handled:

```cpp
// Windows syntax: __declspec(dllexport)
// Linux syntax: DLL_EXPORT
// For compatibility, all occurrences of __declspec(dllexport) need to be changed to DLL_EXPORT

// Add the following code at the beginning of the header file
#if defined(_WIN32) || defined(__CYGWIN__)
  #define DLL_EXPORT __declspec(dllexport)
#else
  #define DLL_EXPORT
#endif
// This ensures Windows can also use this header file
```

### 4. Handle Dependencies

#### 4.1 Method One: Source Compilation

Suitable for scenarios where third-party libraries are niche or require special versions:

```bash
# Generally, compilation method needs to be chosen based on source code method, usually supporting make tool and cmake tool
```

#### 4.2 Method Two: Package Manager Installation

Suitable for most scenarios, relatively easy:

```bash
# Example, current project requires the following dependencies:
sudo apt-get update
# Install OpenSceneGraph library
sudo apt-get install libopenscenegraph-dev
# Install GDAL library
sudo apt-get install libgdal-dev
# Install TinyXML2 library
sudo apt-get install libtinyxml2-dev
# Install OpenGL library
sudo apt-get install libgl-dev
# Install CGAL library
sudo apt-get install libcgal-dev
# Install PugiXML library
sudo apt-get install libpugixml-dev
# Since jni.h from Java is needed, JDK also needs to be installed
sudo apt-get install default-jdk
```

#### 4.3 Complete CMakeLists.txt Configuration

After processing, some libraries may not be automatically recognized, so specific paths need to be specified through the `CMakeLists.txt` file:

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.10)
project(CGALTools)

# Add source files, exclude main.cpp
file(GLOB_RECURSE SOURCES "*.cpp" "*.h")
list(REMOVE_ITEM SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

# Generate dynamic link library
add_library(CGALTools SHARED ${SOURCES})

# Add includes for gdal, jni projects
include_directories(/usr/include/gdal)
include_directories(/usr/lib/jvm/java-11-openjdk-amd64/include)
include_directories(/usr/lib/jvm/java-11-openjdk-amd64/include/linux)

# Find and link libraries
find_package(OpenSceneGraph REQUIRED COMPONENTS osgDB osgUtil osgViewer)

# Manually set TinyXML2 include path
include_directories(/usr/include)

# Link libraries
# Note: mpfr and gmp library installation and linking order have impact, need attention
target_link_libraries(CGALTools
    ${GDAL_LIBRARIES}
    tinyxml2
    mpfr
    gmp
    ${OPENSCENEGRAPH_LIBRARIES}
)

# Add test executable
add_executable(CGALToolsTest main.cpp)

# Link libraries to test executable
target_link_libraries(CGALToolsTest CGALTools gdal tinyxml2 mpfr)
```

### 5. Compilation

```bash
# Navigate to project folder
cd /path/to/project
# Create build directory
mkdir build
# Navigate to compilation directory
cd build
# Execute cmake
cmake ..
# Execute make
make
```

Successful compilation is shown in the figure below:

![Successful Compilation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516143118767.png)

### 6. Testing

#### 6.1 Prepare Test Environment

After successful compilation, we get a `.so` dynamic link library, and we can create a new project to test whether functions work properly:

```bash
# Navigate to test project
cd /path/to/cgal-tools-test
# Copy .so and related header files to root directory
# Create test script test.cpp
```

#### 6.2 Java JNI Testing

Since this example project is for Java project JNI usage, test code needs to be written at Java level:

**Create CGALTools.java file:**

```java
// Note: this filename is unique because it needs to match jni.h generated header file signature, mismatch will cause function not found error
/*
 * Class:     CGALTools
 * Method:    buildHexahedron
 * Signature: ([D[D)J

JNIEXPORT jlong JNICALL Java_CGALTools_buildHexahedron
  (JNIEnv *, jobject, jdoubleArray, jdoubleArray);
*/
```

**Complete Test Code:**

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
            System.out.println("Polyhedron created successfully.");
        } else {
            System.out.println("Polyhedron creation failed.");
        }
    }
}
```

**Run Test:**

```bash
# After creating CGALTools.java, run
javac CGALTools.java 
java CGALTools 
```

Normal output indicates successful testing:

![Test Success](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20240516155411679.png)

## Summary

Through the above steps, we successfully migrated the Windows MCVS C++ project to Linux environment. Key points include:

1. **Environment Preparation**: Ensure Linux system has installed necessary compilation tools
2. **Project Conversion**: Use CMake to replace MCVS project files
3. **Source Code Modification**: Handle Windows-specific headers and syntax
4. **Dependency Handling**: Install third-party libraries through package managers or source compilation
5. **Compilation Testing**: Use standard CMake build process for compilation and testing

Although this process is tedious, through systematic methods, we can ensure projects run normally in Linux environment.

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
