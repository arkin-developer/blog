---
title: "Redis快速入门指南：从NoSQL到高性能缓存"
description: "详细介绍Redis的基础概念、安装配置、性能测试，以及NoSQL数据库的发展历程和Redis在实际项目中的应用场景"
keywords: ["Redis", "NoSQL", "缓存", "数据库", "内存数据库", "高性能", "快速入门", "技术指南"]
author: "Arkin"
date: 2022-06-24T10:30:00+08:00
lastmod: 2025-01-27T18:45:00+08:00
draft: false
tags: ["Redis", "NoSQL", "缓存", "数据库", "内存数据库", "高性能", "快速入门"]
categories: ["技术"]
aliases: ["/posts/redis-quick-start"]
image: "img/redis-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Redis作为当下最热门的NoSQL技术之一，以其高性能、多样数据类型和丰富的功能特性，成为现代应用开发中不可或缺的组件。本文详细介绍Redis的基础概念、安装配置和实际应用。

## 概述

Redis作为当下最热门的NoSQL技术之一，以其高性能、多样数据类型和丰富的功能特性，成为现代应用开发中不可或缺的组件。本文详细介绍Redis的基础概念、安装配置和实际应用。

### 学习内容概览

- **五大基本数据类型**：String、List、Set、Hash、Zset
- **三种特殊数据类型**：geo、hyperloglog、bitmap
- **Redis配置详解**
- **Redis持久化**：RDB、AOF
- **Redis事务操作**
- **Redis实现订阅发布（消息队列）**
- **Redis主从复制**
- **Redis哨兵模式**（现在公司中所有集群都用哨兵模式）
- **缓存穿透及解决方案**
- **缓存击穿及解决方案**
- **缓存雪崩及解决方案**
- **基础API之Jedis详解**
- **SpringBoot集成Redis操作**
- **Redis的实践分析**

## NoSQL概述

### 为什么要用NoSQL

所处大数据时代，单机模式已经支撑不起分析处理。

*1、单机MySQL时代*

![单机MySQL时代](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624103159115.png)

90年代，一个基本的网站访问量不会太大，单个数据库完全足够！

那个时代，更多的去使用静态网页Html，服务器没有太大压力！

**瓶颈：**

1. 数据量如果太大、一个机器放不下了
2. 数据的索引（B+Tree），一个机器内存也放不下
3. 访问量（读写混合），一个服务器承受不了

*2、Memcached（缓存）+ MySQL + 垂直拆分*

网站80%的情况都是在读，每次都要去查询数据库十分麻烦！通过缓存可以减轻数据库的压力，保证效率！

发展过程：优化数据结构和索引->文件缓存(IO)->Memcached(当时最热门的技术)

![Memcached架构](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624104926411.png)

*3、分库分表+水平拆分*

技术和业务在发展的同时，对人的要求越来越高！

*本质：数据库（读、写）*

早年MyISAM：表锁（100万），影响效率，高并发下会出现严重问题。

转战Innodb：行锁

后续通过分库分表来解决写的压力！MySQL推出`表分区`但应用并不广

MySQL的集群，很好解决了那个年代的需求。

![分库分表架构](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624105610347.png)

*4、如今最近的年代|技术爆炸*

过去十年，数据量的激增，访问量激增，单机模式下已经无法适应业务需求

MySQL等关系型数据库已经使用不了业务发展。

MySQL有的使用它来存储一些比较大的文件，博客，图片！数据库表很大，效率就低了，需要有一种数据库专门来处理这种类型的数据。

MySQL如何处理这些问题，大数据的IO压力下，表几乎无法更大！

*目前一个基本的互联网项目*

![现代互联网架构](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624111259421.png)

*答案*

用户的个人信息，社交网络，地理位置。用户自己产生的数据，用户日志爆发式增长。

这个时候需要使用NoSQL数据库来解决遇到的问题。

### 什么是NoSQL

*NoSQL*

NoSQL = Not Only SQL（不仅仅是SQL）

关系型数据库：表格，行，列

泛指非关系型数据库的，随着web2.0互联网的诞生！传统的关系型数据库很难对付web2.0时代！尤其是超大规模的高并发的社区！暴露出来很多难以克服的问题，NoSQL在当今大数据环境下发展十分迅速。Redis是发展最快的，是当下必须掌握的技术。

很多的数据类型用户的个人信息，社交网络，地理位置。这些数据类型的存储不需要一个固定的格式！不需要多余的操作即可完成横向扩展！Map<String,Object>使用键值对来控制！

*NoSQL特点*

1. 方便扩展（数据之间没有关系，很好扩展）
2. 大数据量高性能（Redis一秒写8万次，读11万次，NoSQL的缓存记录级，是一种细粒度的缓存，性能会比较高）
3. 数据类型是多样型的！（不需要事先设计数据库！随取随用！）

**传统RDBMS和NoSQL对比：**

```
传统的RDBMS
- 结构化组织
- SQL
- 数据和关系都存在单独的表中
- 操作，数据定义语言
- 严格的一致性
- 基础的事务
```

```
NoSQL
- 不仅仅是数据
- 没有固定的查询语言
- 键值对存储，列存储，文档存储，图形数据库（社交关系）
- 最终一致性
- CAP定理和BASE（异地多活）
- 高性能、高可用、高可拓展
```

*了解：3V+3高*

大数据时代的3V：描述大数据时代遇到的问题

1. 海量Volume
2. 多样Varlety
3. 实时Velocity

大数据时代的3高：主要是对程序的要求

1. 高并发
2. 高可扩（随时水平拆分，通过增加服务器扩展）
3. 高性能

真正在公司中的实践：RDBMS+NoSQL使用

### 阿里巴巴演进分析

开源才是技术的王道

大量的公司做的是相同的业务；

随着这样的竞争，业务越来越完善，然后对开发者的要求也是越来越高。

![阿里巴巴演进分析](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626215228941.png)

架构师：没什么加一层解决不了，主要目的就是去差异化

```bash
# 1、商品的基本信息
	名称、价格、商家信息；
	关系型数据库可以解决！MySQL / Oracle（淘宝早点就去IOE！王坚：《阿里云的这群疯子》）
	
# 2、商品的秒速、评论（文字比较多）
	文档型数据库中，MongoDB
	
# 3、图片
	分布式文件系统FastDFS
	- 淘宝TFS
	- Google GFS
    - Hadoop HDFS
    - 阿里云OSS

# 4、商品的关键字（搜索）
	- 搜索引擎solr elasticsearch
	- ISearch: 多隆
	
# 5、商品热门的波段信息
	- 内存数据库
	- Redis Tair Memache..
	
# 6、商品的交易，外部的支付接口
	- 三方应用
```

一个简单的网页所用到的技术并非所理解的那么简单。

大型互联网应用问题：

![大型互联网应用问题](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626235716002.png)

- 数据类型太多
- 数据源太多，经常重构
- 数据要改造，大面积改造

解决方案

![解决方案](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626235823957.png)

![技术架构](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626235959603.png)

### NoSQL的四大分类

**KV键值对**

- 新浪：Redis
- 美团：Redis + Tair
- 阿里、百度：Redis+Memecache

**文档行数据库（bson格式和json）**

- MongoDB（一般必须要掌握）
  - MongoDB是一个基于分布式文件存储的数据库，C++编写，主要用来处理大量的文档
  - MongoDB是一个介于关系型数据库和非关系型数据库中间的产品！最像关系型数据库。
- ConthDB

**列存储数据库**

- HBase
- 分布式文件系统

**图关系数据库**

- 存放的是关系，比如：朋友圈社交网络
- Neo4j, InfoGrid

*四者对比*

![NoSQL四大分类对比](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220627175846312.png)

## Redis入门

### 概述

*Redis是什么*

Redis（**R**emote **D**ictionary **S**erver），远程字典服务

是一个开源的使用ANSI C语言编写、支持网络、可基于内存亦可持久化的日志型、Key-Value数据库，并提供多种语言的API。

免费和开源！是当下最热门的NoSQL技术之一！也被称为结构化数据库！

*Redis的作用*

1. 内存存储、持久化，内存是断电即失，RDB、AOF
2. 效率高，可以用于高速缓存
3. 发布订阅系统
4. 地图信息分析
5. 计时器、计数器（浏览量！）
6. ......

*特性*

1. 多样的数据类型
2. 持久化
3. 集群
4. 事务
5. ......

*学习工具*

1. 狂神公众号
2. redis官网*[Redis](https://redis.io/)*
3. 中文网*[Redis中文网](https://www.redis.net.cn/)*

*不推荐在windows部署redis*

### Linux安装

1. 安装包下载

2. 解压安装包，放到/opt

3. 进入解压后的文件，找到redis的配置文件（redis.conf）

4. 基本的环境安装

   ```bash
   yum install gcc-c++
   
   make 
   
   make install
   ```

5. redis的默认安装路径`/usr/local/bin`
6. 将redis配置文件，保存一份保证安全
7. redis默认不是后台的方式启动，需要改成后台启动
8. 启动redis服务
9. 使用redis-cli客户端连接
10. 查看redis的进程是否开启
11. 关闭redis服务`shutdown`
12. 再次查看进程是否
13. 后面使用单机多redis做集群测试

### Docker安装

拉取redis镜像

```bash
docker pull redis
```

创建相应的挂接目录用以存储数据

```bash
mkdir /docker/redis/data
mkdir /docker/redis/conf
```

修改配置文件

```bash
bind 127.0.0.1      #注释掉这部分，使redis可以外部访问
daemonize no      #用守护线程的方式启动
requirepass   你的密码     #给redis设置密码
appendonly yes   #redis持久化　　默认是no
tcp-keepalive 300      #防止出现远程主机强迫关闭了一个现有的连接的错误 默认是300
```

启动docker命令

```bash
docker run -d -p 6379:6379 --name redis -v /media/lwq/docker/redis/conf/redis.conf:/etc/redis/redis.conf -v /media/lwq/docker/redis/data:/data --restart=always redis redis-server /etc/redis/redis.conf --appendonly yes
```

```bash
-p 6379:6379：把容器内的6379端口映射到宿主机6379端口
-v /data/redis/redis.conf：/etc/redis/redis.conf：把宿主机配置好的redis.conf放到容器内的这个位置中
-v /data/redis/data:/data：把redis持久化的数据在宿主机内显示，做数据备份
redis-server /etc/redis/redis.conf：这个是关键配置，让redis不是无配置启动，而是按照这个redis.conf的配置启动
–appendonly yes：redis启动后数据持久化
--restart=always：此参数能够使我们在重启docker时，自动启动相关容器。
```

### 测试性能

redis-benchmark是一个压力测试工具

官方自带的性能测试工具

redis-benchmark

## 总结

通过本文的学习，我们了解了：

1. **NoSQL发展历程**：从单机MySQL到现代分布式架构的演进
2. **NoSQL特点**：高性能、高可扩展、多样数据类型
3. **Redis概述**：远程字典服务，支持多种数据类型和持久化
4. **安装配置**：Linux和Docker两种安装方式
5. **性能测试**：使用redis-benchmark进行压力测试

Redis作为现代应用开发中不可或缺的组件，掌握其基础概念和安装配置是进一步学习Redis高级特性的基础。在后续的学习中，我们将深入探讨Redis的数据类型、持久化机制、集群配置等核心功能。
