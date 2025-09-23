---
title: "HBase快速入门指南：分布式NoSQL数据库实战"
description: "详细介绍HBase分布式数据库的核心概念、架构设计、环境配置、Shell操作以及高级应用场景，帮助开发者快速掌握HBase的使用方法"
keywords: ["HBase", "NoSQL", "分布式数据库", "大数据", "Hadoop", "列式存储", "快速入门", "实战指南"]
author: "Arkin"
date: 2022-04-12T15:00:00+08:00
lastmod: 2025-03-27T19:15:00+08:00
draft: false
tags: ["HBase", "NoSQL", "分布式数据库", "大数据", "Hadoop", "列式存储", "快速入门"]
categories: ["技术"]
aliases: ["/posts/hbase-quick-start-guide"]
image: "img/hbase-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> HBase作为Apache Hadoop生态系统中的重要组件，是处理海量数据的分布式NoSQL数据库。本文详细介绍HBase的核心概念、架构设计、环境配置和实际操作方法。

## 概述

**主要了解Hbase是什么、主要的应用场景、如何部署、增删改查四点内容。**

HBase作为Apache Hadoop生态系统中的重要组件，是处理海量数据的分布式NoSQL数据库。本文详细介绍HBase的核心概念、架构设计、环境配置和实际操作方法。

## 一、HBase简介

*定义*

HBase是一种分布式、可扩展、支持海量数据存储的NoSQL数据库。

### 1.1 数据类型

*数据类型*

逻辑上，HBase的数据模型同关系型数据库很类似，数据存储在一张表中，有行有列。但从HBase的底层物理存储结构（K-V）来看，HBase更像是一个`**multi-dimensional map**`。

![HBase数据模型](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220412150103261.png)

`store`在数据库中保存的物理存储结构

![物理存储结构](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220418144932282.png)

- Row key是有序的，字典序，按位比较，插入任何数据的时候一定要指定row key，不然就会报错；
- store是物理存储结构，需要存在数据库中，
- 插入数据需要注意时间戳，windows和linux时间戳不同会导致多种问题；
- `时间戳`，很重要的概念，是hbase实现随机增删改查的重要手段

### 1.2 数据模型

*数据模型*

#### 1.2.1 Name Space

命名空间，类似于关系型数据库的database概念，每个命名空间下有多个表。Hbase有两个自带的命名空间，分别是`hbase`和`default`，`hbase`中存放的是Hbase内置的表，default表是用户默认使用的命名空间。

#### 1.2.2 Region

类似于关系型数据库的表概念。不同的是，HBase定义表时只需要声明列族即可，不需要声明具体的列。这意味着，往HBase写入数据时，字段可以**动态**、**按需**指定。因此，和关系型数据库相比，HBase能轻松应对字段变更的场景。

#### 1.2.3 Row

HBase表中的每行数据都由一个`RowKey`和多个`Column（列）`组成，数据是按照RowKey的**字典顺序存储**的，并且查询数据时只能根据RowKey进行检索，所以RowKey的设计十分重要。

#### 1.2.4 Column

HBase中的每个列都由`Column Family(列族)`和`Column Qualifier(列限定符)`进行限定，例如info: name, info: age。建表时，只需指明列族，而列限定符无需预先定义。

#### 1.2.5 Time Stamp（重点）

用于标识数据的不同版本（version），每条数据写入时，如果不指定时间戳，系统就会自动为其加上该字段，其值为写入HBase的时间。

#### 1.2.6 Cell

由{rowkey, column Family: column Qualifier, time Stamp}唯一确定的单元。cell中的数据时没有类型的，全部是字节码形式存贮。

### 1.3 HBase基本架构

![HBase体系结构](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220418161930916.png)

*HBase体系结构*

HBase的服务器体系结构遵从简单的主从服务器架构，它由==HRegion Server==群和==HBase Master==服务器构成。HBase Master负责管理所有的==HRegion Server==，而HBase中的所有==RegionServer==都是通过ZooKeeper来协调，并处理HBase服务器运行期间可能遇到的错误。

1. **Client**：管理类，Client与==HMaster==进行RPC；数据读写类操作，Client与==HRegionServer==及进行RPC
2. **Zookeeper**：中间件，ZooKeeper是一个分布式的，开放源码的分布式应用程序协调服务，在这里==HMaster==可以感知到各个==HRegionServer==的健康状态。此外，Zookeeper也避免了HMaster的单点问题
3. **HMaster**：每台==HRegionServer==都会与==HMaster==进行通信，==HMaster==的主要任务就是要告诉每台==HRegion Server==它要维护哪些==HRegion==。
   当一台新的HRegionServer登录到HMaster时，HMaster会告诉它等待分配数据。而当一台HRegion死机时，HMaster会把它负责的HRegion标记为未分配，然后再把它们分配到其他的HRegion Server中。
   HBase已经解决了HMaster单点故障问题（SPFO），并且HBase中可以启动多个HMaster，那么它就能够通过Zookeeper来保证系统中总有一个Master在运行。HMaster在功能上主要负责Table和Region的管理工作
4. **HRegion**：当表的大小超过设置值得时候，HBase会自动地将表划分为不同的区域，每个区域包含所有行的一个子集。对用户来说，每个表是一堆数据的集合，靠主键来区分。从物理上来说，一张表被拆分成了多块，每一块就是一个HRegion。我们用表名+开始/结束主键来区分每一个HRegion，一个HRegion会保存一个表里面某段连续的数据，从开始主键到结束主键，一张完整的表格是保存在多个HRegion上面：
   - 管理用户对Table的增删改查操作
   - 管理HRegionServer的负载均衡，调整Region分布
   - 在Region Split后，负责新Region的分配
   - 在HRegionServer停机后，负责失效HRegionServer上的Region迁移
5. **HRegionServer**：HRegionServer主要负责响应用户I/O请求，向HDFS文件系统中读写数据，是HBase中最核心的模块。

*RPC:*

RPC是远程过程调用（Remote Procedure Call）的缩写形式。SAP系统RPC调用的原理其实很简单，有一些类似于三层构架的C/S系统，第三方的客户程序通过接口调用SAP内部的标准或自定义函数，获得函数返回的数据进行处理后显示或打印。

- Master管理Resion的增删改查
- RegionServer管理数据的增删改查
- Zookeeper中间件，ZooKeeper是一个分布式的，开放源码的分布式应用程序协调服务，是Google的Chubby一个开源的实现，是Hadoop和Hbase的重要组件。它是一个为分布式应用提供一致性服务的软件，提供的功能包括：配置维护、域名服务、分布式同步、组服务等。

## 二、HBase环境配置（docker）

HBase的安装有三种模式，`单机模式`，`伪分布模式`和`完全分布模式`，前提是Hadoop集群和Zoopeeper已经安装完成。

![HBase配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220419154235311.png)

*hbase配置*

*[Hbase环境配置_陌上人间的博客-CSDN博客_配置hbase环境变量](https://blog.csdn.net/zjy15737869372/article/details/121922588)*

*java配置*

如果电脑没有java的话就要先装，因为hbase运行在java环境上

![Java配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220420161945336.png)

*https://blog.51cto.com/zhangxueliang/2968963*

*https://segmentfault.com/a/1190000024471678*

## 三、HBase Shell操作（重点）

```bash
# 如果是用docker部署的HBase，先进入到容器中
docker exec -it hbase /bin/bash

# 输入命令进入hbase shell
bash-4.4> hbase shell

help # 可以帮助查看相关操作命令
exit # 退出shell
```

![HBase Shell界面](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220419171322632.png)

*DDL命令对命名空间和表进行增删改查的操作*

命名空间和表的增删改查类似，以下只展示表的增删改查

```bash
# 创建表
create '表名', '列簇名称' 

# 修改表
alter '表名', '新增的列簇'  # 新增表的列簇，可以用describe命令来看是否创建成功

# 删除表的列簇
alter '表名', 'delete' => '需要删除的列簇'

# 删除已存在的表名, 有时候删除前需要将表禁用掉disable
drop '表名'

# 禁用表
disable '表名'

# 清空表数据
truncate '表名'

list # 查询已创建的表
describe '表名' # 查看表的信息，相当于SQL的表的结构
```

*DML命令，对数据的增删改查操作*

对数据的增删改查

```bash
# 插入数据, 写和改是一个方式
put '表名'，'rowkey', '列簇：列名', '值'

# 多版本的列簇的数据存储
alter '表名'，NAME => '列簇', VERSION=>5  # 可以给列簇设置最多5个版本

# 这个时候查询某个表的某个列，以及指定返回的版本数量，这样就会返回所有版本的数据
get '表名', 'rowkey', {COLUMN=>'列簇:列名', VERSION=>5}

# 删除数据
deleteall '表名', 'rowkey'  # HBase支持按照行删除这一行所有列的数据
delete '表名', 'rowkey', '列簇:列名'

# 查询数据
get '表名', 'rowkey'  # 获取一行数据
get '表名', 'rowkey', '列簇:列名'  # 查询一个单元格的数据
scan '表名', {STARTROW=>'002', ENDROW=>'003'}  # 获取某几行指定列的数据
scan '表名', {COLUMN=>['列簇:列名'，'列簇:列名1'],STARTROW=>'002', ENDROW=>'003'}  # 获取某几行指定列的数据
```

## 四、进阶理解

#### 4.1 Hbase写流程

![HBase写流程](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220420135640406.png)

客户端发起写入请求时，先要去和`Zookeeper`进行RPC获取到mate表所在的服务器地址，找到对应的`RegionServer`之后，发送`put`请求，将数据写入到内存中，自此，写操作完成。

#### 4.2 性能设计

- 列簇越少越好，两个及以上的列簇会影响性能

#### 4.3 rowkey设计原则

1. 避免使用递增的行键/时序数据（单个region server的负载过大）
2. 避免`rowkey`和`列`的长度过大
3. 使用`long`类型比`String`类型更省空间
4. `RowKey`唯一性

#### 4.4 避免数据热点

- 热点是指客户端（client）直接访问一个或几个节点

## 五、高阶使用（Hbase+elasticsearch）

![HBase+Elasticsearch架构](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220531140659197.png)

*[ES--二级索引_韩家小志的博客-CSDN博客_es二级索引](https://blog.csdn.net/qq_46893497/article/details/112420211)*

## 总结

通过本文的学习，我们掌握了HBase分布式NoSQL数据库的核心知识：

1. **基础概念**：HBase作为分布式、可扩展的海量数据存储解决方案
2. **数据模型**：NameSpace、Region、Row、Column、TimeStamp、Cell等核心组件
3. **架构设计**：HMaster、HRegionServer、ZooKeeper的协同工作机制
4. **环境配置**：Docker部署和Java环境配置
5. **Shell操作**：DDL和DML命令的实际使用方法
6. **性能优化**：RowKey设计原则和数据热点避免策略
7. **高级应用**：与Elasticsearch结合实现二级索引

HBase作为大数据生态系统中的重要组件，在处理海量数据存储和实时查询方面具有独特优势。在实际应用中，需要根据业务需求合理设计RowKey，优化列族结构，确保系统的高性能和可扩展性。

---

*感谢阅读，欢迎交流与反馈。*

*我的邮箱📮 arkin-dev@qq.com（需要交流请发邮件）。*
