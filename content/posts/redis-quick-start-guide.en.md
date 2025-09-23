---
title: "Redis Quick Start Guide: From NoSQL to High-Performance Caching"
description: "A comprehensive introduction to Redis basics, installation configuration, performance testing, and the development history of NoSQL databases with Redis application scenarios in real projects"
keywords: ["Redis", "NoSQL", "Caching", "Database", "In-Memory Database", "High Performance", "Quick Start", "Technical Guide"]
author: "Arkin"
date: 2022-06-24T10:30:00+08:00
lastmod: 2022-06-24T10:30:00+08:00
draft: false
tags: ["Redis", "NoSQL", "Caching", "Database", "In-Memory Database", "High Performance", "Quick Start"]
categories: ["Technology"]
aliases: ["/posts/redis-quick-start"]
image: "img/redis-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Redis, as one of the most popular NoSQL technologies today, has become an indispensable component in modern application development with its high performance, diverse data types, and rich functional features. This article provides a detailed introduction to Redis basic concepts, installation configuration, and practical applications.

## Overview

Redis, as one of the most popular NoSQL technologies today, has become an indispensable component in modern application development with its high performance, diverse data types, and rich functional features. This article provides a detailed introduction to Redis basic concepts, installation configuration, and practical applications.

### Learning Content Overview

- **Five Basic Data Types**: String, List, Set, Hash, Zset
- **Three Special Data Types**: geo, hyperloglog, bitmap
- **Redis Configuration Details**
- **Redis Persistence**: RDB, AOF
- **Redis Transaction Operations**
- **Redis Pub/Sub Implementation (Message Queue)**
- **Redis Master-Slave Replication**
- **Redis Sentinel Mode** (All clusters in companies now use sentinel mode)
- **Cache Penetration and Solutions**
- **Cache Breakdown and Solutions**
- **Cache Avalanche and Solutions**
- **Basic API Jedis Details**
- **SpringBoot Redis Integration**
- **Redis Practice Analysis**

## NoSQL Overview

### Why Use NoSQL

We are in the era of big data, and single-machine mode can no longer support analysis and processing.

*1. Single MySQL Era*

![Single MySQL Era](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624103159115.png)

In the 1990s, basic website traffic wasn't too high, and a single database was completely sufficient!

In that era, static HTML web pages were used more, and servers didn't have too much pressure!

**Bottlenecks:**

1. If the data volume is too large, one machine can't hold it
2. Data indexes (B+Tree), one machine's memory can't hold it either
3. Traffic (read-write mixed), one server can't handle it

*2. Memcached (Cache) + MySQL + Vertical Split*

80% of website situations are reads, and querying the database every time is very troublesome! Caching can reduce database pressure and ensure efficiency!

Development process: Optimize data structure and indexes -> File cache (IO) -> Memcached (the hottest technology at that time)

![Memcached Architecture](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624104926411.png)

*3. Database/Table Split + Horizontal Split*

As technology and business develop, requirements for people are getting higher and higher!

*Essence: Database (read, write)*

Early MyISAM: Table locks (1 million), affecting efficiency, causing serious problems under high concurrency.

Switched to Innodb: Row locks

Later solved write pressure through database/table splitting! MySQL introduced `table partitioning` but it wasn't widely used

MySQL clusters solved the needs of that era very well.

![Database/Table Split Architecture](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624105610347.png)

*4. Current Era | Technology Explosion*

Over the past decade, explosive growth in data volume and traffic, single-machine mode can no longer adapt to business needs

MySQL and other relational databases can no longer meet business development.

MySQL is sometimes used to store relatively large files, blogs, images! When database tables are large, efficiency decreases, and there's a need for a database specifically designed to handle this type of data.

How does MySQL handle these problems? Under big data IO pressure, tables can hardly get bigger!

*Current Basic Internet Project*

![Modern Internet Architecture](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220624111259421.png)

*Answer*

User personal information, social networks, geographic locations. User-generated data, user logs explosive growth.

At this point, NoSQL databases are needed to solve the encountered problems.

### What is NoSQL

*NoSQL*

NoSQL = Not Only SQL

Relational databases: Tables, rows, columns

Refers to non-relational databases. With the birth of web2.0 internet! Traditional relational databases are difficult to deal with the web2.0 era! Especially ultra-large-scale high-concurrency communities! Many insurmountable problems are exposed. NoSQL develops very rapidly in today's big data environment. Redis is the fastest developing and is a technology that must be mastered today.

Many data types: user personal information, social networks, geographic locations. These data types don't need a fixed format for storage! Horizontal expansion can be completed without extra operations! Map<String,Object> uses key-value pairs to control!

*NoSQL Features*

1. Easy to expand (no relationships between data, easy to expand)
2. Big data volume, high performance (Redis writes 80,000 times per second, reads 110,000 times per second. NoSQL cache record level is fine-grained caching with relatively high performance)
3. Diverse data types! (No need to design database in advance! Use as needed!)
4. Traditional RDBMS and NoSQL

**Traditional RDBMS vs NoSQL:**

```
Traditional RDBMS
- Structured organization
- SQL
- Data and relationships exist in separate tables
- Operations, data definition language
- Strict consistency
- Basic transactions
```

```
NoSQL
- Not only data
- No fixed query language
- Key-value storage, column storage, document storage, graph database (social relationships)
- Eventual consistency
- CAP theorem and BASE (geo-distributed multi-active)
- High performance, high availability, high scalability
```

*Understanding: 3V+3H*

3V of big data era: Describing problems encountered in the big data era

1. Volume (Massive)
2. Variety (Diverse)
3. Velocity (Real-time)

3H of big data era: Mainly requirements for programs

1. High concurrency
2. High scalability (horizontal splitting anytime by adding servers)
3. High performance

Real company practice: RDBMS+NoSQL usage

### Alibaba Evolution Analysis

Open source is the king of technology

Many companies do the same business;

As competition intensifies, business becomes more and more perfect, and requirements for developers are also getting higher and higher.

![Alibaba Evolution Analysis](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626215228941.png)

Architect: There's nothing that can't be solved by adding a layer, the main purpose is to eliminate differences

```bash
# 1. Basic product information
	Name, price, merchant information;
	Relational database can solve! MySQL / Oracle (Taobao early removed IOE! Wang Jian: "The Madmen of Alibaba Cloud")
	
# 2. Product descriptions, reviews (lots of text)
	Document database, MongoDB
	
# 3. Images
	Distributed file system FastDFS
	- Taobao TFS
	- Google GFS
    - Hadoop HDFS
    - Alibaba Cloud OSS

# 4. Product keywords (search)
	- Search engines solr elasticsearch
	- ISearch: Duolong
	
# 5. Product hot segment information
	- In-memory database
	- Redis Tair Memcache..
	
# 6. Product transactions, external payment interfaces
	- Third-party applications
```

The technology used by a simple webpage is not as simple as understood.

Large internet application problems:

![Large Internet Application Problems](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626235716002.png)

- Too many data types
- Too many data sources, frequent refactoring
- Data needs transformation, large-scale transformation

Solutions

![Solutions](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626235823957.png)

![Technical Architecture](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220626235959603.png)

### Four Categories of NoSQL

**KV Key-Value**

- Sina: Redis
- Meituan: Redis + Tair
- Alibaba, Baidu: Redis+Memecache

**Document Database (bson format and json)**

- MongoDB (generally must master)
  - MongoDB is a database based on distributed file storage, written in C++, mainly used to handle large amounts of documents
  - MongoDB is a product between relational and non-relational databases! Most like relational database.
- ConthDB

**Column Storage Database**

- HBase
- Distributed file system

**Graph Database**

- Stores relationships, such as: social networks like WeChat moments
- Neo4j, InfoGrid

*Four-way Comparison*

![NoSQL Four Categories Comparison](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220627175846312.png)

## Redis Introduction

### Overview

*What is Redis*

Redis (**R**emote **D**ictionary **S**erver), remote dictionary service

An open-source database written in ANSI C language, supporting network, memory-based or persistent log-type, Key-Value database, providing APIs for multiple languages.

Free and open source! One of the hottest NoSQL technologies today! Also called structured database!

*Redis Functions*

1. Memory storage, persistence, memory is lost on power failure, RDB, AOF
2. High efficiency, can be used for high-speed caching
3. Publish-subscribe system
4. Geographic information analysis
5. Timers, counters (page views!)
6. ......

*Features*

1. Diverse data types
2. Persistence
3. Clustering
4. Transactions
5. ......

*Learning Tools*

1. Kuangshen's public account
2. Redis official website *[Redis](https://redis.io/)*
3. Chinese website *[Redis Chinese Website](https://www.redis.net.cn/)*

*Not recommended to deploy Redis on Windows*

### Linux Installation

1. Download installation package

2. Extract installation package, put in /opt

3. Enter extracted file, find Redis configuration file (redis.conf)

4. Basic environment installation

   ```bash
   yum install gcc-c++
   
   make 
   
   make install
   ```

5. Redis default installation path `/usr/local/bin`
6. Save Redis configuration file as backup for safety
7. Redis doesn't start in background mode by default, need to change to background startup
8. Start Redis service
9. Use redis-cli client to connect
10. Check if Redis process is running
11. Close Redis service `shutdown`
12. Check process again
13. Later use single-machine multi-redis for cluster testing

### Docker Installation

Pull Redis image

```bash
docker pull redis
```

Create corresponding mount directories for data storage

```bash
mkdir /docker/redis/data
mkdir /docker/redis/conf
```

Modify configuration file

```bash
bind 127.0.0.1      #Comment out this part to allow Redis external access
daemonize no      #Start in daemon thread mode
requirepass   your_password     #Set password for Redis
appendonly yes   #Redis persistence　　 default is no
tcp-keepalive 300      #Prevent remote host forced close existing connection error default is 300
```

Start docker command

```bash
docker run -d -p 6379:6379 --name redis -v /media/lwq/docker/redis/conf/redis.conf:/etc/redis/redis.conf -v /media/lwq/docker/redis/data:/data --restart=always redis redis-server /etc/redis/redis.conf --appendonly yes
```

```bash
-p 6379:6379: Map container's 6379 port to host's 6379 port
-v /data/redis/redis.conf:/etc/redis/redis.conf: Put host's configured redis.conf into container at this location
-v /data/redis/data:/data: Display Redis persistent data on host for data backup
redis-server /etc/redis/redis.conf: This is key configuration, let Redis start with this redis.conf configuration instead of no-config startup
–appendonly yes: Redis data persistence after startup
--restart=always: This parameter enables automatic startup of related containers when restarting docker.
```

### Performance Testing

redis-benchmark is a stress testing tool

Official performance testing tool

redis-benchmark

## Summary

Through this article, we learned about:

1. **NoSQL Development History**: Evolution from single MySQL to modern distributed architecture
2. **NoSQL Features**: High performance, high scalability, diverse data types
3. **Redis Overview**: Remote dictionary service, supporting multiple data types and persistence
4. **Installation Configuration**: Two installation methods for Linux and Docker
5. **Performance Testing**: Using redis-benchmark for stress testing

Redis, as an indispensable component in modern application development, mastering its basic concepts and installation configuration is the foundation for further learning Redis advanced features. In subsequent learning, we will delve into Redis data types, persistence mechanisms, cluster configuration, and other core functions.

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
