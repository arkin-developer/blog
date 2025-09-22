---
title: "Setting Up Remote Desktop Service with FRP"
description: "Simple tutorial for setting up remote desktop service using FRP intranet penetration technology"
keywords: ["FRP", "Remote Desktop", "Intranet Penetration", "Docker", "RDP"]
author: "Arkin"
date: 2021-10-15T15:00:00+08:00
lastmod: 2025-01-27T15:00:00+08:00
draft: false
tags: ["FRP", "Remote Desktop", "Intranet Penetration", "Docker"]
categories: ["Technology"]
aliases: ["/posts/frp-remote-desktop-setup"]
image: "img/frp-remote-desktop.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> FRP (Fast Reverse Proxy) is a high-performance reverse proxy application that supports TCP, UDP, HTTP, HTTPS and other protocols, helping you easily achieve intranet penetration. This tutorial shows how to set up remote desktop service using FRP.

## What is FRP?

FRP is a high-performance reverse proxy application focused on intranet penetration, supporting TCP, UDP, HTTP, HTTPS and other protocols. Through FRP, you can expose intranet services to the public network for remote access.

**How it works**:
- **Server (frps)**: Deployed on a server with public IP
- **Client (frpc)**: Deployed on intranet computers
- **Penetration process**: Client actively connects to server to establish tunnel

## Server Deployment (frps)

### 1. Deploy with Docker

Deploy FRP server on your server using Docker:

```bash
# Create configuration directory
sudo mkdir -p /etc/frp

# Create configuration file
sudo nano /etc/frp/frps.ini
```

Configuration file content:

```ini
[common]
bind_addr = 0.0.0.0
bind_port = 10106
token = Zkyy2021
```

### 2. Start Service

Run FRP server using Docker:

```bash
docker run -d \
  --name frps \
  --restart=always \
  -v /etc/frp/frps.ini:/etc/frp/frps.ini \
  -p 10106:10106 \
  -p 10107:10107 \
  snowdreamtech/frps
```

**Port Description**:
- `10106`: Client connection port
- `10107`: Remote desktop access port

## Client Configuration (frpc)

### 1. Download FRP Client

Visit GitHub to download the corresponding version of FRP:

```
https://github.com/fatedier/frp/releases
```

Choose the version suitable for your system:
- Windows: `frp_*_windows_amd64.zip`
- Linux: `frp_*_linux_amd64.tar.gz`

### 2. Configure frpc.ini

Create configuration file on client computer:

```ini
[common]
server_addr = 113.105.137.161
server_port = 10106
token = Zkyy2021

[remote-desktop]
type = tcp
local_ip = 127.0.0.1
local_port = 3389
remote_port = 10107
```

### 3. Start Client

**Windows System**:

```cmd
frpc.exe -c frpc.ini
```

**Linux System**:

```bash
chmod +x frpc
./frpc -c frpc.ini
```

Connection successful will show:

```
[I] login to server success
[I] [remote-desktop] proxy added
```

## Remote Desktop Connection

### 1. Enable Windows Remote Desktop

Enable remote desktop service on target computer:

1. Right-click "This PC" → "Properties"
2. Click "Remote settings"
3. Select "Allow remote connections to this computer"

### 2. Connect Remote Desktop

Use remote desktop client to connect:

- **Connection Address**: `Public Server IP:10107`
- **Username**: Target computer username
- **Password**: Target computer password

**Windows Remote Desktop Connection**:

```cmd
mstsc /v:113.105.137.161:10107
```

## Summary

Through the above steps, you can use FRP to achieve intranet penetration and remotely access intranet computers:

1. **Server Deployment**: Deploy FRP server using Docker
2. **Client Configuration**: Configure FRP client connection
3. **Remote Desktop**: Enable Windows remote desktop service
4. **Connection Test**: Access remote desktop through public IP

## Multiple Client Configuration

If you need to connect multiple intranet computers, you can configure different ports for each computer:

### Server Configuration

Ensure the server opens enough ports:

```bash
docker run -d \
  --name frps \
  --restart=always \
  -v /etc/frp/frps.ini:/etc/frp/frps.ini \
  -p 10106:10106 \
  -p 10107:10107 \
  -p 10108:10108 \
  -p 10109:10109 \
  snowdreamtech/frps
```

### Client Configuration

Create different configurations for each computer:

**Computer 1** - frpc1.ini:
```ini
[common]
server_addr = 113.105.137.161
server_port = 10106
token = Zkyy2021

[remote-desktop-1]
type = tcp
local_ip = 127.0.0.1
local_port = 3389
remote_port = 10107
```

**Computer 2** - frpc2.ini:
```ini
[common]
server_addr = 113.105.137.161
server_port = 10106
token = Zkyy2021

[remote-desktop-2]
type = tcp
local_ip = 127.0.0.1
local_port = 3389
remote_port = 10108
```

### Connection Methods

- **Computer 1**: `mstsc /v:113.105.137.161:10107`
- **Computer 2**: `mstsc /v:113.105.137.161:10108`

## Notes

- Ensure firewall opens corresponding ports (10106, 10107, 10108, etc.)
- Use strong passwords as authentication tokens
- Regularly update FRP version for latest features and security fixes

## Related Resources

- [FRP Official Documentation](https://gofrp.org/docs/)
- [FRP GitHub Repository](https://github.com/fatedier/frp)