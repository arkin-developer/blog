---
title: "HBase Quick Start Guide: Distributed NoSQL Database in Practice"
description: "A detailed introduction to HBase distributed database core concepts, architecture design, environment configuration, Shell operations, and advanced application scenarios to help developers quickly master HBase usage"
keywords: ["HBase", "NoSQL", "Distributed Database", "Big Data", "Hadoop", "Columnar Storage", "Quick Start", "Practical Guide"]
author: "Arkin"
date: 2022-04-12T15:00:00+08:00
lastmod: 2025-03-27T19:15:00+08:00
draft: false
tags: ["HBase", "NoSQL", "Distributed Database", "Big Data", "Hadoop", "Columnar Storage", "Quick Start"]
categories: ["Technology"]
aliases: ["/posts/hbase-quick-start-guide"]
image: "img/hbase-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> HBase, as an important component of the Apache Hadoop ecosystem, is a distributed NoSQL database for processing massive data. This article provides a detailed introduction to HBase's core concepts, architecture design, environment configuration, and practical operation methods.

## Overview

*Mainly understand what HBase is, main application scenarios, how to deploy, and CRUD operations - four key points.*

HBase, as an important component of the Apache Hadoop ecosystem, is a distributed NoSQL database for processing massive data. This article provides a detailed introduction to HBase's core concepts, architecture design, environment configuration, and practical operation methods.

## I. HBase Introduction

*Definition*

HBase is a distributed, scalable, massive data storage NoSQL database.

### 1.1 Data Types

*Data Types*

Logically, HBase's data model is very similar to relational databases, with data stored in tables with rows and columns. But from HBase's underlying physical storage structure (K-V), HBase is more like a `**multi-dimensional map**`.

![HBase Data Model](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220412150103261.png)

Physical storage structure saved by `store` in database

![Physical Storage Structure](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220418144932282.png)

- Row key is ordered, dictionary order, bit-wise comparison, must specify row key when inserting any data, otherwise will error;
- store is physical storage structure, needs to exist in database,
- Pay attention to timestamps when inserting data, different timestamps between windows and linux can cause various problems;
- `Timestamp`, a very important concept, is an important means for HBase to implement random CRUD operations

### 1.2 Data Model

*Data Model*

#### 1.2.1 Name Space

Namespace, similar to the database concept in relational databases, with multiple tables under each namespace. HBase has two built-in namespaces: `hbase` and `default`. `hbase` contains HBase built-in tables, and default table is the default namespace used by users.

#### 1.2.2 Region

Similar to the table concept in relational databases. The difference is that HBase only needs to declare column families when defining tables, without declaring specific columns. This means that when writing data to HBase, fields can be specified **dynamically** and **on-demand**. Therefore, compared to relational databases, HBase can easily handle field change scenarios.

#### 1.2.3 Row

Each row of data in HBase tables consists of a `RowKey` and multiple `Columns`, data is stored in **dictionary order** by RowKey, and data can only be retrieved based on RowKey during queries, so RowKey design is very important.

#### 1.2.4 Column

Each column in HBase is qualified by `Column Family(column family)` and `Column Qualifier(column qualifier)`, such as info: name, info: age. When creating tables, only column families need to be specified, while column qualifiers don't need to be pre-defined.

#### 1.2.5 Time Stamp (Key Point)

Used to identify different versions (version) of data. When each piece of data is written, if no timestamp is specified, the system automatically adds this field with the value being the time of writing to HBase.

#### 1.2.6 Cell

A unit uniquely determined by {rowkey, column Family: column Qualifier, time Stamp}. Data in cells has no type, all stored in bytecode form.

### 1.3 HBase Basic Architecture

![HBase Architecture](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220418161930916.png)

*HBase Architecture*

HBase's server architecture follows a simple master-slave server architecture, consisting of ==HRegion Server== groups and ==HBase Master== servers. HBase Master is responsible for managing all ==HRegion Servers==, while all ==RegionServers== in HBase are coordinated through ZooKeeper and handle errors that may occur during HBase server operation.

1. **Client**: Management class, Client performs RPC with ==HMaster==; Data read/write operations, Client performs RPC with ==HRegionServer==
2. **Zookeeper**: Middleware, ZooKeeper is a distributed, open-source distributed application coordination service. Here ==HMaster== can sense the health status of each ==HRegionServer==. Additionally, Zookeeper avoids HMaster single point of failure
3. **HMaster**: Each ==HRegionServer== communicates with ==HMaster==. ==HMaster=='s main task is to tell each ==HRegion Server== which ==HRegions== it needs to maintain.
   When a new HRegionServer logs into HMaster, HMaster tells it to wait for data assignment. When an HRegion crashes, HMaster marks its responsible HRegions as unassigned, then assigns them to other HRegion Servers.
   HBase has solved the HMaster single point of failure problem (SPFO), and multiple HMasters can be started in HBase, ensuring there's always a Master running through ZooKeeper. HMaster is functionally responsible for Table and Region management
4. **HRegion**: When table size exceeds the set value, HBase automatically divides the table into different regions, each containing a subset of all rows. From user perspective, each table is a collection of data distinguished by primary key. Physically, a table is split into multiple pieces, each piece being an HRegion. We distinguish each HRegion by table name + start/end primary key. An HRegion saves continuous data from a table, from start primary key to end primary key. A complete table is saved across multiple HRegions:
   - Manage user CRUD operations on Tables
   - Manage HRegionServer load balancing, adjust Region distribution
   - After Region Split, responsible for new Region assignment
   - After HRegionServer shutdown, responsible for Region migration from failed HRegionServer
5. **HRegionServer**: HRegionServer is mainly responsible for responding to user I/O requests, reading and writing data to HDFS file system, and is the core module in HBase.

*RPC:*

RPC is the abbreviation for Remote Procedure Call. SAP system RPC call principle is actually simple, somewhat similar to three-tier C/S systems, where third-party client programs call SAP internal standard or custom functions through interfaces, process returned data for display or printing.

- Master manages Region CRUD operations
- RegionServer manages data CRUD operations
- Zookeeper middleware, ZooKeeper is a distributed, open-source distributed application coordination service, an open-source implementation of Google's Chubby, and an important component of Hadoop and HBase. It's software that provides consistency services for distributed applications, including: configuration maintenance, domain name service, distributed synchronization, group services, etc.

## II. HBase Environment Configuration (Docker)

HBase installation has three modes: `standalone mode`, `pseudo-distributed mode`, and `fully distributed mode`, prerequisite being that Hadoop cluster and ZooKeeper are already installed.

![HBase Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220419154235311.png)

*HBase configuration*

*[HBase Environment Configuration_Moshang Renjian's Blog-CSDN Blog_Configure HBase Environment Variables](https://blog.csdn.net/zjy15737869372/article/details/121922588)*

*Java configuration*

If computer doesn't have Java, install it first because HBase runs on Java environment

![Java Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220420161945336.png)

*https://blog.51cto.com/zhangxueliang/2968963*

*https://segmentfault.com/a/1190000024471678*

## III. HBase Shell Operations (Key Points)

```bash
# If using Docker deployed HBase, enter container first
docker exec -it hbase /bin/bash

# Enter command to enter hbase shell
bash-4.4> hbase shell

help # Can help view related operation commands
exit # Exit shell
```

![HBase Shell Interface](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220419171322632.png)

*DDL commands for CRUD operations on namespaces and tables*

Namespace and table CRUD operations are similar, only showing table CRUD operations below

```bash
# Create table
create 'table_name', 'column_family_name' 

# Modify table
alter 'table_name', 'new_column_family'  # Add table column family, can use describe command to see if creation successful

# Delete table column family
alter 'table_name', 'delete' => 'column_family_to_delete'

# Delete existing table name, sometimes need to disable table before deletion
drop 'table_name'

# Disable table
disable 'table_name'

# Clear table data
truncate 'table_name'

list # Query created tables
describe 'table_name' # View table information, equivalent to SQL table structure
```

*DML commands for data CRUD operations*

Data CRUD operations

```bash
# Insert data, write and modify are the same way
put 'table_name', 'rowkey', 'column_family:column_name', 'value'

# Multi-version column family data storage
alter 'table_name', NAME => 'column_family', VERSION=>5  # Can set up to 5 versions for column family

# Query specific column of table, and specify number of versions to return, this will return all version data
get 'table_name', 'rowkey', {COLUMN=>'column_family:column_name', VERSION=>5}

# Delete data
deleteall 'table_name', 'rowkey'  # HBase supports deleting all column data of a row by row
delete 'table_name', 'rowkey', 'column_family:column_name'

# Query data
get 'table_name', 'rowkey'  # Get one row of data
get 'table_name', 'rowkey', 'column_family:column_name'  # Query data of one cell
scan 'table_name', {STARTROW=>'002', ENDROW=>'003'}  # Get data of specified columns for several rows
scan 'table_name', {COLUMN=>['column_family:column_name','column_family:column_name1'],STARTROW=>'002', ENDROW=>'003'}  # Get data of specified columns for several rows
```

## IV. Advanced Understanding

#### 4.1 HBase Write Process

![HBase Write Process](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220420135640406.png)

When client initiates write request, first needs to perform RPC with `Zookeeper` to get meta table server address, after finding corresponding `RegionServer`, send `put` request to write data to memory, at this point write operation is complete.

#### 4.2 Performance Design

- Fewer column families the better, two or more column families will affect performance

#### 4.3 RowKey Design Principles

1. Avoid using increasing row keys/temporal data (single region server overload)
2. Avoid excessive length of `rowkey` and `columns`
3. Using `long` type saves more space than `String` type
4. `RowKey` uniqueness

#### 4.4 Avoid Data Hotspots

- Hotspots refer to clients directly accessing one or several nodes

## V. Advanced Usage (HBase + Elasticsearch)

![HBase + Elasticsearch Architecture](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220531140659197.png)

*[ES--Secondary Index_Hanjia Xiaozhi's Blog-CSDN Blog_es secondary index](https://blog.csdn.net/qq_46893497/article/details/112420211)*

## Summary

Through this article, we mastered the core knowledge of HBase distributed NoSQL database:

1. **Basic Concepts**: HBase as a distributed, scalable massive data storage solution
2. **Data Model**: Core components like NameSpace, Region, Row, Column, TimeStamp, Cell
3. **Architecture Design**: Collaborative working mechanism of HMaster, HRegionServer, ZooKeeper
4. **Environment Configuration**: Docker deployment and Java environment configuration
5. **Shell Operations**: Practical usage of DDL and DML commands
6. **Performance Optimization**: RowKey design principles and data hotspot avoidance strategies
7. **Advanced Applications**: Integration with Elasticsearch for secondary indexing

HBase, as an important component of the big data ecosystem, has unique advantages in handling massive data storage and real-time queries. In practical applications, RowKey needs to be reasonably designed based on business requirements, column family structure optimized, to ensure system high performance and scalability.

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
