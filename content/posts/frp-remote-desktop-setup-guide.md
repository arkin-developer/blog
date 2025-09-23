---
title: "FRP 搭建远程桌面服务"
description: "使用FRP内网穿透技术搭建远程桌面服务的简明教程，快速实现内网计算机的远程访问"
keywords: ["FRP", "远程桌面", "内网穿透", "Docker", "RDP"]
author: "Arkin"
date: 2021-10-15T15:00:00+08:00
lastmod: 2021-10-15T15:00:00+08:00
draft: false
tags: ["FRP", "远程桌面", "内网穿透", "Docker"]
categories: ["技术"]
aliases: ["/posts/frp-remote-desktop-setup"]
image: "img/frp-remote-desktop.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> FRP (Fast Reverse Proxy) 是一个高性能的反向代理应用，支持 TCP、UDP、HTTP、HTTPS 等协议，可以帮助您轻松实现内网穿透。本教程将介绍如何使用 FRP 搭建远程桌面服务，让您能够远程访问内网计算机。

## 什么是 FRP？

FRP 是一个专注于内网穿透的高性能的反向代理应用，支持 TCP、UDP、HTTP、HTTPS 等协议。通过 FRP，您可以将内网服务暴露到公网，实现远程访问。

**工作原理**：
- **服务端 (frps)**: 部署在有公网IP的服务器上
- **客户端 (frpc)**: 部署在内网计算机上
- **穿透过程**: 客户端主动连接服务端，建立隧道

## 服务端部署 (frps)

### 1. 使用 Docker 部署

在服务器上使用 Docker 快速部署 FRP 服务端：

```bash
# 创建配置目录
sudo mkdir -p /etc/frp

# 创建配置文件
sudo nano /etc/frp/frps.ini
```

配置文件内容：

```ini
[common]
bind_addr = 0.0.0.0
bind_port = 10106
token = Zkyy2021
```

### 2. 启动服务

使用 Docker 运行 FRP 服务端：

```bash
docker run -d \
  --name frps \
  --restart=always \
  -v /etc/frp/frps.ini:/etc/frp/frps.ini \
  -p 10106:10106 \
  -p 10107:10107 \
  snowdreamtech/frps
```

**端口说明**：
- `10106`: 客户端连接端口
- `10107`: 远程桌面访问端口

## 客户端配置 (frpc)

### 1. 下载 FRP 客户端

访问 GitHub 下载对应版本的 FRP：

```
https://github.com/fatedier/frp/releases
```

选择适合您系统的版本：
- Windows: `frp_*_windows_amd64.zip`
- Linux: `frp_*_linux_amd64.tar.gz`

### 2. 配置 frpc.ini

在客户端计算机上创建配置文件：

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

### 3. 启动客户端

**Windows 系统**：

```cmd
frpc.exe -c frpc.ini
```

**Linux 系统**：

```bash
chmod +x frpc
./frpc -c frpc.ini
```

连接成功后会显示：

```
[I] login to server success
[I] [remote-desktop] proxy added
```

## 远程桌面连接

### 1. 启用 Windows 远程桌面

在目标计算机上启用远程桌面服务：

1. 右键点击"此电脑" → "属性"
2. 点击"远程设置"
3. 选择"允许远程连接到此计算机"

### 2. 连接远程桌面

使用远程桌面客户端连接：

- **连接地址**: `公网服务器IP:10107`
- **用户名**: 目标计算机的用户名
- **密码**: 目标计算机的密码

**Windows 远程桌面连接**：

```cmd
mstsc /v:113.105.137.161:10107
```

## 总结

通过以上步骤，您就可以使用 FRP 实现内网穿透，远程访问内网计算机了：

1. **服务端部署**: 使用 Docker 部署 FRP 服务端
2. **客户端配置**: 配置 FRP 客户端连接
3. **远程桌面**: 启用 Windows 远程桌面服务
4. **连接测试**: 通过公网IP访问远程桌面

## 多客户端配置

如果需要连接多台内网计算机，可以为每台计算机配置不同的端口：

### 服务端配置

确保服务端开放足够的端口：

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

### 客户端配置

为每台计算机创建不同的配置：

**计算机1** - frpc1.ini：
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

**计算机2** - frpc2.ini：
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

### 连接方式

- **计算机1**: `mstsc /v:113.105.137.161:10107`
- **计算机2**: `mstsc /v:113.105.137.161:10108`

## 注意事项

- 确保防火墙开放相应端口（10106、10107、10108等）
- 使用强密码作为认证 token
- 定期更新 FRP 版本以获得最新功能和安全修复

## 相关资源

- [FRP 官方文档](https://gofrp.org/docs/)
- [FRP GitHub 仓库](https://github.com/fatedier/frp)

---

*感谢阅读，欢迎交流与反馈。*

*我的邮箱📮 arkin-dev@qq.com（需要交流请发邮件）。*
