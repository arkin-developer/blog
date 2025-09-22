---
title: "Golang Development Guide: Environment Management, Testing, and Cross-Compilation"
description: "A comprehensive guide to Golang development essentials, covering GVM multi-version environment management, unit testing, benchmarking, example functions, and cross-platform compilation implementation"
keywords: ["Golang", "Go Language", "Environment Management", "GVM", "Unit Testing", "Cross-Compilation", "Development Guide", "Programming Fundamentals"]
author: "Arkin"
date: 2021-11-21T16:30:00+08:00
lastmod: 2025-01-27T18:00:00+08:00
draft: false
tags: ["Golang", "Go Language", "Environment Management", "GVM", "Unit Testing", "Cross-Compilation", "Development Guide"]
categories: ["Technology"]
aliases: ["/posts/golang-development"]
image: "img/golang-development.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Golang, as a modern programming language, requires mastering core skills such as environment management, test writing, and cross-platform compilation during development. This article provides detailed coverage of GVM multi-version management, unit testing practices, and cross-compilation deployment methods.

## Overview

Golang (Go language), with its concise syntax, high performance, and powerful concurrency capabilities, has become an important choice for modern software development. In Golang development, mastering skills such as environment management, test writing, and cross-platform compilation is crucial.

## Environment Management

### GVM Multi-Version Manager

*[moovweb/gvm: Go Version Manager (github.com)](https://github.com/moovweb/gvm)*

GVM is Golang's version management tool, similar to Node.js's nvm, which can conveniently manage multiple Go versions.

#### Installing GVM

```bash
# Install gvm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```

#### Important Notes

Since Go implemented *bootstrapping* in version 1.5, to install Go version 1.5 or above, you need to install version 1.4 first as a compiler:

```bash
gvm install go1.4
gvm use go1.4 [--default]
```

#### Common Commands

```bash
# List all installed environments
gvm list
# List all available versions for installation
gvm listall
# Select version to use
gvm use go <--version-->
```

## Unit Testing

Testing in Golang relies on the `go test` command, and writing test code is no different from writing regular code.

The `go test` command is a test code driver program organized according to conventions. Within package directories, all source code files with `_test.go` suffix are part of go test and will not be compiled into the final executable by go build.

### Test Function Types

There are three types of functions in `*_test.go` files: *unit test* functions, *benchmark* functions, and *example* functions.

| Type | Format | Purpose |
|:------:|:-------------------:|:----------------------------:|
| Test Function | Function name prefix Test | Test whether program logic behavior is correct |
| Benchmark Function | Function name prefix Benchmark | Test function performance |
| Example Function | Function name prefix Example | Provide example documentation |

### Test Execution Process

The `go test` command traverses all functions in `*_test.go` files that match the above naming rules, then generates a temporary main package to call the corresponding test functions, builds and runs them, reports test results, and finally cleans up temporary files generated during testing.

### Common Test Commands

```bash
# Test all test functions in current package
go test  # Test all *_test.go in root directory

# Test packages in a subdirectory
go test ./dir  # Test all *_test.go files in subdirectory
go test -v ./dir  # -v show detailed execution results
```

## Cross-Compilation/Deployment

Golang can compile main.go files into binaries through the `go build` command, which can be directly deployed to the same operating system, and also supports compilation across different platform systems.

### Go Build Parameters

The `go build` command has the following parameters:

- `-o`: Specify output file name and path
- `-i`: Install related dependency packages
- `-a`: Force recompile all packages
- `-n`: Output command lines during compilation process
- `-v`: Output detailed information during compilation process
- `-x`: Output executed command lines during compilation process
- `-race`: Enable Go language race detection mechanism
- `-tags`: Specify tags used during compilation
- `-work`: Output temporary directory during compilation
- `-mod`: Specify dependency package version management mode
- `-buildmode`: Specify compilation mode, options include 'exe', 'c-shared', 'shared', 'plugin', 'archive'
- `-compiler`: Specify compiler to use
- `-gccgoflags`: Additional parameters passed to GCC
- `-gcflags`: Additional parameters passed to linker
- `-msan`: Enable memory safety detection

### Windows System Cross-Compilation

```cmd
# Open cmd and run the following commands sequentially
# Compile linux amd64 executable file on windows
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=amd64
go build

# PowerShell command line
$env:GOOS="linux"
$env:GOARCH="amd64"

# Compile mac amd64 executable program on windows
SET CGO_ENABLED=0  # Disable CGO
SET GOOS=darwin  # Target platform is mac
SET GOARCH=amd64  # Target processor architecture is amd64
go build
```

### Mac System Cross-Compilation

```bash
# Compile linux amd64 system executable file on mac
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
# Compile win amd64 system executable file on mac
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
```

### Linux System Cross-Compilation

```bash
# Compile mac amd64 system executable file on linux
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build
# Compile win amd64 system executable file on linux
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build  
```

## Summary

Through this article, we have mastered the core skills of Golang development:

1. **Environment Management**: Use GVM to manage multiple Go versions, ensuring development environment flexibility
2. **Testing Practices**: Master writing unit tests, benchmarks, and example functions
3. **Cross-Compilation**: Implement cross-platform deployment, improving development efficiency and deployment convenience

These skills are essential foundational knowledge for Golang developers. Mastering them can significantly improve development efficiency and code quality. In actual development, proper use of these tools and methods can help build higher-quality Golang applications.
