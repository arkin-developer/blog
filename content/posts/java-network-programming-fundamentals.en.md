---
title: "Java Network Programming Fundamentals: TCP/UDP Communication Guide"
description: "A comprehensive guide to Java network programming fundamentals, covering network communication elements, IP addresses and ports, TCP/UDP protocol principles, and complete client-server communication implementation examples"
keywords: ["Java", "Network Programming", "TCP", "UDP", "Socket", "Network Communication", "Client", "Server", "Programming Fundamentals"]
author: "Arkin"
date: 2021-11-21T16:00:00+08:00
lastmod: 2025-01-27T17:45:00+08:00
draft: false
tags: ["Java", "Network Programming", "TCP", "UDP", "Socket", "Network Communication", "Programming Fundamentals"]
categories: ["Technology"]
aliases: ["/posts/java-network-programming"]
image: "img/java-network-programming.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Network programming is an important skill in software development. This article provides a detailed introduction to Java network programming fundamentals, covering network communication elements, IP addresses and ports, TCP/UDP protocol principles, and complete client-server communication implementation examples.

## Overview

### Computer Networks

A computer network refers to a computer system that connects multiple **computers** and their external devices with independent functions in *different geographical locations* through communication lines, and under the management and coordination of network operating systems, network management software, and **network communication protocols**, realizes **resource sharing** and **information transmission**.

### Purpose of Network Programming

Information dissemination and exchange, data exchange, and communication.

### Problems to Solve for Network Communication

1. How to accurately locate a host on the network?
2. After finding this host, how to transmit data?
3. Clarify the difference between "web programming" and "network programming"

## Network Communication Elements

### How to Implement Network Communication?

**Addresses of communicating parties:**
- IP address
- Port number

**Rules: Network communication protocols**

TCP/IP Reference Model:

![TCP/IP Reference Model](C:\Users\mr-lai\AppData\Roaming\Typora\typora-user-images\image-20211121162841011.png)

### Summary

1. **Two main problems in network programming**:
   - How to accurately locate one or more hosts on the network
   - How to communicate after finding the host

2. **Elements in network programming**:
   - IP and port number
   - Network communication protocols UDP, TCP/IP

3. **Everything is an object**

## IP Address

### InetAddress

IP Address: InetAddress

- Uniquely locates a computer on the network
- 127.0.0.1: localhost
- IP address classification
  - IPv4 / IPv6
    - **IPv4**: 127.0.0.1, composed of 4 bytes. 0~255, 4.2 billion; 3 billion in North America, 400 million in Asia. Exhausted in 2011
    - **IPv6**: 2409:8a55:d646:7ae0:24b9:8e1b:6914:d1e2, 128 bits. 8 unsigned integers
  - Public network (Internet) - Private network (LAN)
    - Class A, B, C, D addresses
    - 192.168.xx.xx specifically for internal organization use
- Domain name: Remembering IP problem!

### Java IP Address Operation Example

```java
package com.dahongdou.study;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class TextInetAddress {
    public static void main(String[] args) {
        try {
            //Query local machine IP address
            InetAddress inetAddress1 = InetAddress.getByName("127.0.0.1");
            System.out.println(inetAddress1);
            InetAddress inetAddress3 = InetAddress.getByName("localhost");
            System.out.println(inetAddress3);
            InetAddress inetAddress4 = InetAddress.getLocalHost();
            System.out.println(inetAddress4);

            //Query website IP address
            InetAddress inetAddress2 = InetAddress.getByName("www.baidu.com");
            System.out.println(inetAddress2);

            //Common methods
            System.out.println(inetAddress1.getAddress());
            System.out.println(inetAddress1.getCanonicalHostName());  //Canonical name
            System.out.println(inetAddress1.getHostAddress());   //ip
            System.out.println(inetAddress1.getHostName());   //Domain name, or your computer name

        }catch (UnknownHostException e){
            e.printStackTrace();
        }
    }
}
```

## Port

Port represents a program process on a computer

- Different processes have different port numbers! Cannot conflict. Used to distinguish software
- Regulated 0~65535
- TCP, UDP: 65535*2 tcp:80, udp:80. Port numbers cannot conflict under a single protocol

### Port Classification

- **Public ports 0~1023**
  - HTTP:80
  - HTTPS:443
  - FTP:21
  - Telnet:23

- **Program registered ports: 1024~49151**, allocated to users or programs
  - Tomcat:8080
  - MySQL:3306
  - Oracle:1521

- **Dynamic, private: 49152~65535**

### Port Viewing Commands

```shell
# Use with Task Manager PID to view port numbers
netstat -ano # View all ports
netstat -ano|findstr "5900"  # View specified port
tasklist|findstr "8696" # View process of specified port
```

### Java Port Operation Example

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

## Communication Protocol

Protocol: Agreement

**Network communication protocol:** Rate, transmission bit rate, code structure, transmission control...

**TCP/IP protocol suite:** A set of protocols

Important:
- **TCP**: User Transport Protocol
- **UDP**: User Datagram Protocol

### Comparison

**TCP: Making a phone call**
- Connection, stable
- Three-way handshake, four-way handshake

```shell
# At least three times needed to maintain connection
A: What are you looking at?
B: What's it to you?
A: Let's fight!

# Four-way breakup
A: I'm leaving
B: Are you really leaving?
B: Are you really really leaving?
A: I'm really leaving!
```

- Client, server
- Release connection after transmission, low efficiency

**UDP: Sending text messages**
- No connection, unstable
- Client, server: no clear boundaries

## TCP Programming

### Client Implementation

1. Connect to server Socket
2. Send messages

```java
package com.dahongdou.study02;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;

//Client
public class TcpClientDemo01 {
    public static void main(String[] args) {
        Socket socket = null;
        OutputStream os = null;

        try {
            //1. Need to know server address, port number
            InetAddress serverIP = InetAddress.getByName("127.0.0.1");
            int port = 9999;
            //2. Create a socket connection
            socket = new Socket(serverIP, port);
            //3. Send message, IO stream
            os = socket.getOutputStream();

            os.write("hello,welcome to learn".getBytes());
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

### Server Implementation

1. Establish service port
2. Wait for user connection accept
3. Receive user messages

```java
package com.dahongdou.study02;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class TcpServerSocket {
    public static void main(String[] args) {
        //Elevate scope
        ServerSocket severSocket = null;
        Socket socket = null;
        InputStream is = null;
        ByteArrayOutputStream baos = null;

        try {
            //1. Need an address
            severSocket = new ServerSocket(9999);
            while (true){
                //2. Wait for client connection
                socket = severSocket.accept();
                //3. Read client message
                is = socket.getInputStream();

                //Pipeline stream
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
            //Close resources
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

### File Upload

Tomcat

## UDP Programming

### Sender

```java
package com.dahongdou.study03;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

// No need to connect to server
public class UdpClientDemo01 {
    public static void main(String[] args) throws Exception{
        // 1. Create a Socket
        DatagramSocket socket = new DatagramSocket();

        // 2. Create a packet
        String msg = "Hello, server!";
        InetAddress localhost = InetAddress.getByName("localhost");
        int port = 9090;

        // Data, data length start/end, who to send to
        DatagramPacket packet = new DatagramPacket(msg.getBytes(),0,msg.getBytes().length,localhost,port);

        // 3. Send packet
        socket.send(packet);

        // 4. Close stream
        socket.close();
    }
}
```

### Receiver

```java
package com.dahongdou.study03;

import java.net.DatagramPacket;
import java.net.DatagramSocket;

// Still need to wait for client connection
public class UdpServerDemo01 {
    public static void main(String[] args) throws Exception{
        // Open port
        DatagramSocket socket = new DatagramSocket(9090);
        // Receive data packet
        byte[] buffer = new byte[1024];
        DatagramPacket packet = new DatagramPacket(buffer, 0, buffer.length);
        socket.receive(packet); // Blocking receive

        System.out.println(packet.getAddress().getHostAddress());
        System.out.println(new String(packet.getData(),0,packet.getLength()));

        // Close connection
        socket.close();
    }
}
```

Multi-threading, both are receivers and senders

## URL

https://www.baidu.com/

Uniform Resource Locator: Locate resources, locate a resource on the Internet

DNS domain name resolution: Convert domain name back to IP address

```
Protocol://IP address:port/project name/resource/
```

## Summary

Through this article, we learned the basics of Java network programming:

1. **Network communication elements**: IP addresses and port numbers are the foundation of network communication
2. **Protocol selection**: TCP provides reliable connections, UDP provides efficient transmission
3. **Programming implementation**: Client-server communication can be achieved through Socket programming
4. **Practical applications**: Network programming is widely used in web development, distributed systems, and other fields

Mastering these fundamentals is a prerequisite for advanced network programming and an important foundation for understanding modern network application architectures.
