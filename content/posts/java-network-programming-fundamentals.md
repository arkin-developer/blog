---
title: "Java网络编程基础：TCP/UDP通信详解"
description: "详细介绍Java网络编程的基础概念，包括网络通信要素、IP地址和端口、TCP/UDP协议原理，以及完整的客户端-服务端通信实现示例"
keywords: ["Java", "网络编程", "TCP", "UDP", "Socket", "网络通信", "客户端", "服务端", "编程基础"]
author: "Arkin"
date: 2021-11-21T16:00:00+08:00
lastmod: 2025-01-27T17:45:00+08:00
draft: false
tags: ["Java", "网络编程", "TCP", "UDP", "Socket", "网络通信", "编程基础"]
categories: ["技术"]
aliases: ["/posts/java-network-programming"]
image: "img/java-network-programming.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> 网络编程是软件开发中的重要技能，本文详细介绍Java网络编程的基础概念，包括网络通信要素、IP地址和端口、TCP/UDP协议原理，以及完整的客户端-服务端通信实现示例。

## 概述

### 计算机网络

计算机网络是指将*地理位置不同*的具有独立功能的多台**计算机**及其外部设备，通过通信线路连接起来，在网络操作系统、网络管理软件及**网络通信协议**的管理和协调下，实现**资源共享**和**信息传递**的计算机系统。

### 网络编程的目的

传播交流信息，数据交换、通信。

### 实现网络通信需要解决的问题

1. 如何准确定位网络上的一台主机？
2. 找到了这个主机，如何传输数据呢？
3. 弄清楚"网页编程"和"网络编程"

## 网络通信的要素

### 如何实现网络通信？

**通信双方的地址：**
- IP地址
- 端口号

**规则：网络通信的协议**

TCP/IP参考模型：

![TCP/IP参考模型](C:\Users\mr-lai\AppData\Roaming\Typora\typora-user-images\image-20211121162841011.png)

### 小结

1. **网络编程中两个主要问题**：
   - 如何准确定位到网络上的一台或者多台主机
   - 找到主机之后如何进行通信

2. **网络编程中的要素**：
   - IP和端口号
   - 网络通信协议 UDP、TCP/IP

3. **万物皆对象**

## IP地址

### InetAddress

IP地址：InetAddress

- 唯一定位一台网络上计算机
- 127.0.0.1：本机 localhost
- IP地址的分类
  - IPv4 / IPv6
    - **IPv4**：127.0.0.1，4个字节组成。0~255，42亿；30亿都在北美，亚洲4亿。2011年就用尽
    - **IPv6**：2409:8a55:d646:7ae0:24b9:8e1b:6914:d1e2，128位。8个无符号整型
  - 公网（互联网）- 私网（局域网）
    - ABCD类地址
    - 192.168.xx.xx 专门给组织内部使用
- 域名：记忆IP问题！

### Java IP地址操作示例

```java
package com.dahongdou.study;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class TextInetAddress {
    public static void main(String[] args) {
        try {
            //查询本机IP地址
            InetAddress inetAddress1 = InetAddress.getByName("127.0.0.1");
            System.out.println(inetAddress1);
            InetAddress inetAddress3 = InetAddress.getByName("localhost");
            System.out.println(inetAddress3);
            InetAddress inetAddress4 = InetAddress.getLocalHost();
            System.out.println(inetAddress4);

            //查询网站IP地址
            InetAddress inetAddress2 = InetAddress.getByName("www.baidu.com");
            System.out.println(inetAddress2);

            //常用方法
            System.out.println(inetAddress1.getAddress());
            System.out.println(inetAddress1.getCanonicalHostName());  //规范名称
            System.out.println(inetAddress1.getHostAddress());   //ip
            System.out.println(inetAddress1.getHostName());   //域名，或者自己电脑名称

        }catch (UnknownHostException e){
            e.printStackTrace();
        }
    }
}
```

## 端口

端口表示计算机上的一个程序的进程

- 不同的进程有不同的端口号！不能冲突。用来区分软件
- 被规定0~65535
- TCP，UDP：65535*2 tcp:80, udp:80。单个协议下的端口号不能冲突

### 端口分类

- **公有端口0~1023**
  - HTTP:80
  - HTTPS:443
  - FTP:21
  - Telent:23

- **程序注册端口：1024~49151**，分配用户或者程序
  - Tomcat:8080
  - MySQL:3306
  - Oracle:1521

- **动态、私有：49152~65535**

### 端口查看命令

```shell
# 配合任务管理器的PID 查看端口号
netstat -ano # 查看所有的端口
netstat -ano|findstr "5900"  # 查看指定的端口
tasklist|findstr "8696" # 查看指定端口的进程
```

### Java端口操作示例

```java
package com.dahongdou.study;

import java.net.InetSocketAddress;

public class TextInetSockerAddress {
    public static void main(String[] args) {
        InetSocketAddress socketAddress1 = new InetSocketAddress("127.0.0.1", 8080);
        InetSocketAddress socketAddress2 = new InetSocketAddress("localhost", 8080);
        System.out.println(socketAddress1);
        System.out.println(socketAddress2);

        System.out.println(socketAddress1.getAddress());
        System.out.println(socketAddress1.getHostName());
        System.out.println(socketAddress1.getPort());
    }
}
```

## 通信协议

协议：约定

**网络通信协议：**速率，传输码率，代码结构，传输控制......

**TCP/IP协议簇：**是一组协议

重要：
- **TCP**：用户传输协议
- **UDP**：用户数据报协议

### 对比

**TCP：打电话**
- 连接，稳定
- 三次握手，四次挥手

```shell
# 为了保持连接，至少需要三次
A: 你瞅啥？
B: 瞅你咋地？
A: 干一场？

# 四次分手
A: 我要走了
B: 你真的要走了吗？
B: 你真的真的要走了吗？
A: 我真的要走了！
```

- 客户端、服务端
- 传输完成，释放连接，效率低

**UDP：发短信**
- 不连接、不稳定
- 客户端、服务端：没有明确的界限

## TCP编程

### 客户端实现

1. 连接服务器Socket
2. 发送消息

```java
package com.dahongdou.study02;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;

//客户端
public class TcpClientDemo01 {
    public static void main(String[] args) {
        Socket socket = null;
        OutputStream os = null;

        try {
            //1. 要知道服务器的地址、端口号
            InetAddress serverIP = InetAddress.getByName("127.0.0.1");
            int port = 9999;
            //2. 创建一个socket连接
            socket = new Socket(serverIP, port);
            //3. 发送信息, IO流
            os = socket.getOutputStream();

            os.write("hello,欢迎学习".getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (os!= null){
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (socket!= null){
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```

### 服务端实现

1. 建立服务的端口
2. 等待用户的连接accept
3. 接收用户的消息

```java
package com.dahongdou.study02;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class TcpServerSocket {
    public static void main(String[] args) {
        //提升作用域
        ServerSocket severSocket = null;
        Socket socket = null;
        InputStream is = null;
        ByteArrayOutputStream baos = null;

        try {
            //1. 我得有一个地址
            severSocket = new ServerSocket(9999);
            while (true){
                //2. 等待客户端连接过来
                socket = severSocket.accept();
                //3. 读取客户端的消息
                is = socket.getInputStream();

                //管道流
                baos = new ByteArrayOutputStream();
                byte[] buffer = new byte[1024];
                int len;
                while ((len = is.read(buffer)) != -1) {
                    baos.write(buffer, 0, len);
                }
                System.out.println(baos.toString());
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            //关闭资源
            if (baos!=null){
                try {
                    baos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (is!=null){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (socket!=null){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (severSocket!=null){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```

### 文件上传

Tomcat

## UDP编程

### 发送端

```java
package com.dahongdou.study03;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

// 不需要连接服务器
public class UdpClientDemo01 {
    public static void main(String[] args) throws Exception{
        // 1. 建立一个Socket
        DatagramSocket socket = new DatagramSocket();

        // 2. 建个包
        String msg = "你好呀，服务器！";
        InetAddress localhost = InetAddress.getByName("localhost");
        int port = 9090;

        // 数据，数据的长度始末，要发送给谁
        DatagramPacket packet = new DatagramPacket(msg.getBytes(),0,msg.getBytes().length,localhost,port);

        // 3. 发送包
        socket.send(packet);

        // 4. 关闭流
        socket.close();
    }
}
```

### 接收端

```java
package com.dahongdou.study03;

import java.net.DatagramPacket;
import java.net.DatagramSocket;

// 还是要等待客户端的连接
public class UdpServerDemo01 {
    public static void main(String[] args) throws Exception{
        // 开放端口
        DatagramSocket socket = new DatagramSocket(9090);
        // 接收数据包
        byte[] buffer = new byte[1024];
        DatagramPacket packet = new DatagramPacket(buffer, 0, buffer.length);
        socket.receive(packet); // 阻塞接收

        System.out.println(packet.getAddress().getHostAddress());
        System.out.println(new String(packet.getData(),0,packet.getLength()));

        // 关闭连接
        socket.close();
    }
}
```

多线程，两人既是接收方，也是发送方

## URL

https://www.baidu.com/

统一资源定位符：定位资源的，定位互联网上的某一个资源

DNS 域名解析：把域名还原为IP地址

```
协议：//ip地址：端口/项目名/资源/
```

## 总结

通过本文的学习，我们了解了Java网络编程的基础知识：

1. **网络通信要素**：IP地址和端口号是网络通信的基础
2. **协议选择**：TCP提供可靠的连接，UDP提供高效的传输
3. **编程实现**：通过Socket编程可以实现客户端和服务端的通信
4. **实际应用**：网络编程广泛应用于Web开发、分布式系统等领域

掌握这些基础知识是进行更高级网络编程的前提，也是理解现代网络应用架构的重要基础。
