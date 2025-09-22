---
title: "Elasticsearch Environment Setup and Basic Usage Guide"
description: "A comprehensive guide to Elasticsearch setup in Windows environment, covering JDK installation, ES service configuration, plugin installation, Kibana configuration, and complete CRUD operations with advanced query syntax"
keywords: ["Elasticsearch", "ES", "Search Engine", "Kibana", "ElasticSearch-head", "RESTful", "Database", "Setup Guide"]
author: "Arkin"
date: 2022-04-08T08:50:00+08:00
lastmod: 2025-01-27T18:30:00+08:00
draft: false
tags: ["Elasticsearch", "ES", "Search Engine", "Kibana", "ElasticSearch-head", "RESTful", "Database"]
categories: ["Technology"]
aliases: ["/posts/elasticsearch-setup"]
image: "img/elasticsearch-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Elasticsearch is a distributed search and analytics engine based on Lucene, widely used in full-text search, log analysis, real-time data analysis and other fields. This article provides a detailed introduction to the complete setup and usage methods of Elasticsearch in Windows environment.

## Overview

Elasticsearch is a distributed search and analytics engine based on Lucene, widely used in full-text search, log analysis, real-time data analysis and other fields. This article provides a detailed introduction to the complete setup and usage methods of Elasticsearch in Windows environment.

## Setup Requirements

Before starting to install Elasticsearch, you need to understand the following components:

- **JDK**: Because this search engine is based on Java
- **ES Server**: Core search engine
- **Nodejs**: Client tools are frontend projects based on Node.js
- **KIBANA**: Client visualization interface
- **ElasticSearch-head Plugin**: Web management interface
- **API Debugging Tools**: Because this engine's queries use RESTful-style calling conventions

### Important Notes

*Note the version correspondence between JDK and ES*

## JDK Installation

Since the ES version here is 6.8.6, the JDK version chosen is 1.8

![JDK Installation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408085021300.png)

## ES Installation

*[Index of elasticsearch-local/6.8.6 (huaweicloud.com)](https://mirrors.huaweicloud.com/elasticsearch/6.8.6/)*

### File Configuration

Add the following at the bottom of the \elasticsearch-6.8.6\config\elasticsearch.yml file to allow any connection.

```yaml
http.cors.enabled: true 
http.cors.allow-origin: "*"
```

### Startup

Double-click elasticsearch-6.8.6\bin\elasticsearch.bat

### Access Address to Check Version

*http://localhost:9200/*

![ES Version Info](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408092257149.png)

The above content indicates successful installation

## Plugin Installation

### ElasticSearch-head

#### Install Nodejs

![Nodejs Installation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408105146433.png)

#### Install grunt

```shell
# Install grunt
npm install -g grunt-cli
# Check if installation is successful 
grunt -version
```

#### Download head plugin

*[mobz/elasticsearch-head: A web front end for an elastic search cluster (github.com)](https://github.com/mobz/elasticsearch-head)*

```shell
# After downloading, enter this directory
cd C:\mysoftware\elasticsearch-head-master

# Install this module
npm install

# Start - both commands below work
npm run start
grunt server
```

#### Startup

http://localhost:9100

![ElasticSearch-head Interface](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408111354902.png)

Displaying this interface indicates success.

### Kibana

*[Kibana 6.8.6 | Elastic](https://www.elastic.co/cn/downloads/past-releases/kibana-6-8-6)*

Install Kibana of the same version as ES

![Kibana Installation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408105434847.png)

#### Modify Configuration File

\kibana-6.8.6-windows-x86_64\config

![Kibana Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408093851043.png)

#### Startup

`\kibana-6.8.6-windows-x86_64\bin\kibana.bat`

![Kibana Startup](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408094007424.png)

[http://localhost:5601](http://localhost:5601/)

Opening this address will show

![Kibana Interface](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408094110668.png)

At this point! ES installation is complete

## Basic Usage (CRUD Operations)

### Basic Knowledge

#### Index

An index is a collection of documents with similar characteristics. For example, you can have an index for customer data, another for product catalog, and another for order data. An index is identified by a name (**must be all lowercase letters**) and we use this name when we want to index, search, update, and delete documents corresponding to this index. In a cluster, you can define any number of indexes.

#### Type

In an index, you can define one or more types. A type is a logical category/partition of your index, and its semantics are entirely up to you. Usually, you define a type for documents that have a set of identical fields. For example, let's say you run a blog platform and store all your data in an index. In this index, you can define a type for user data, another type for blog data, and of course, another type for comment data.

#### Field

Equivalent to table fields in a database, classification identifiers for document data according to different attributes

#### Mapping

Mapping is about making some restrictions on how and rules for processing data, such as data type of a field, default value, analyzer, whether it is indexed, etc. These are all things that can be set in mapping. Other processing rules for ES data are also called mapping. Following optimal rules for data processing greatly improves performance, so mapping needs to be established, and you need to think about how to establish mapping to achieve optimal performance.

#### Document

A document is a basic unit of information that can be indexed. For example, you can have a document for a customer, a document for a product, and of course, a document for an order. Documents are represented in JSON format, and JSON is an ubiquitous internet data interchange format.

In an index/type, you can store any number of documents. Note that although a document physically exists in an index, the document must be indexed/assigned an index type.

#### Near Real-Time (NRT)

Elasticsearch is a near real-time search platform. This means that from indexing a document until this document can be searched, there is a slight delay (usually within 1 second)

#### Cluster

A cluster is organized by one or more nodes together. They jointly hold all the data and provide indexing and search functions together. A cluster is identified by a unique name, which defaults to "elasticsearch". This name is important because a node can only join this cluster by specifying the cluster name.

#### Node

A node is a server in a cluster. As part of the cluster, it stores data and participates in the cluster's indexing and search functions. Similar to clusters, a node is also identified by a name. By default, this name is a random Marvel comic character name that is assigned to the node when it starts. This name is quite important for management work because in this management process, you will determine which servers in the network correspond to which nodes in the Elasticsearch cluster.

A node can join a specified cluster by configuring the cluster name. By default, each node is arranged to join a cluster called "elasticsearch", which means that if you start several nodes in your network and assume they can discover each other, they will automatically form and join an "elasticsearch" cluster.

#### Shards & Replicas

An index can store large amounts of data beyond the hardware limits of a single node. For example, an index with 1 billion documents occupies 1TB of disk space, and no single node has such large disk space; or a single node processes search requests too slowly. To solve this problem, Elasticsearch provides the ability to divide an index into multiple parts, which are called shards. When you create an index, you can specify the number of shards you want. Each shard itself is a fully functional and independent index that can be placed on any node in the cluster. Shards are important for two main reasons:

1. Allow you to horizontally split/expand your content capacity
2. Allow you to perform distributed, parallel operations on shards (potentially located on multiple nodes), thereby improving performance/throughput.

As for how a shard is distributed and how its documents are aggregated back to search requests, it is entirely managed by Elasticsearch, and for you as a user, these are transparent.

In a network/cloud environment, failures can happen at any time. When a shard/node somehow goes offline or disappears for any reason, having a failover mechanism is very useful and strongly recommended. For this purpose, Elasticsearch allows you to create one or more copies of shards, which are called replica shards, or simply replicas.

Replicas are important for two main reasons: providing high availability in case of shard/node failures. For this reason, it is very important to note that replica shards are never placed on the same node as the original/primary shard. Expanding your search volume/throughput because searches can be performed in parallel on all replicas. In summary, each index can be divided into multiple shards. An index can also be replicated 0 times (not replicated) or multiple times. Once replicated, each index has primary shards (original shards as replication sources) and replica shards (copies of primary shards). The number of shards and replicas can be specified when the index is created. After the index is created, you can dynamically change the number of replicas at any time, but you cannot change the number of shards.

By default, each index in Elasticsearch is sharded into 5 primary shards and 1 replica, which means that if you have at least two nodes in your cluster, your index will have 5 primary shards and another 5 replica shards (1 complete copy), so each index has a total of 10 shards.

### CRUD Operations

![CRUD Operations](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408111717394.png)

#### Create or Update

ES index is similar to Mysql database

**ES type is similar to Mysql table, this analogy is not exactly the same because tables are independent of each other, but types can search different types under different indexes. This keyword has now been deleted in higher versions, so you can default to using type=doc instead**

ES doc is similar to each record in Mysql table (json format)

*After ES 6.0.0, single index multiple type method is not supported because it easily causes resource waste, so maintain single index single type method for data storage*

```
# Create and update doc with specified id  
# put/post+url+index+type+id
# For example, I want to create index=grid type=changed id=0
put + http://127.0.0.1:9200/grid/type/0
```

![Create with Specified ID](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408134831754.png)

**If the specified number does not exist for this doc, it is a new addition; if it exists, it is a modification.**

```shell
# Create doc without specifying id, randomly assign id
# post+url+index+type
# For example, I want to create index=grid type=changed
post + http://127.0.0.1:9200/grid/type
```

![Create with Random ID](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408135933708.png)

#### Delete

```shell
# Delete doc with specified id
# delete+url+index+type+id
# For example, I want to delete index=grid type=changed id=2 doc
delete + http://127.0.0.1:9200/grid/changed/2
```

If this doc exists, it will be deleted; if it doesn't exist, it returns `not_found`

```shell
# Delete index 
# delete+url+index
# For example, I want to delete index=grid 
delete + http://127.0.0.1:9200/grid
```

If this index exists, it will be deleted; if it doesn't exist, it returns `error 404`

#### Search (Key Focus)

```shell
# Find corresponding doc by specified id
# get+url+index+type+id
# For example, I want to find index=grid type=changed id=1 doc
get + http://127.0.0.1:9200/grid/changed/1
```

![Search Results](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408141018808.png)

If it exists, it returns results; if it doesn't exist, it returns `"found": false`

*Advanced Query Syntax*

```json
1、// GET /index/type/_search   Query all
GET abc/article/_search

2、//match_all: Return all documents
GET stu/_search
{
    "query": {
        "match_all": {}
    }
}

3、//match: Boolean match query: Tokenize the query string and construct boolean query based on tokenization results
GET stu/_search
{
    "query": {
        "match": {
          "name":"John Kerry"
        }
    }
}
//Query terms are john and kerry,
//As long as the name field value contains any one of them, return this document

4、//match_phrase: Phrase match query
GET stu/_search
{
    "query": {
        "match_phrase": {
          "name":"John Kerry"
        }
    }
}
// As long as the name field value contains any one of john and kerry, return this document

5、//match_phrase_prefix: Phrase prefix match query
GET stu/_search
{
    "query": {
        "match_phrase_prefix": {
          "name":"John Ke"
        }
    }
}
//Last token as prefix match

6、//multi_match: Multi-field match query
GET stu/_search
{
    "query": {
        "multi_match": {
          "query": "John like cooking",
          "fields": ["name","interest"]
        }
    }
}

7、//term: Term query: Match fields according to exact words stored in inverted index
GET stu/_search
{
    "query": {
        "term":{
          "name":"john"
        }
    }
}

8、//terms: Multi-term query: Match fields according to exact words stored in inverted index for multi-term matching
GET stu/_search
{
    "query": {
        "terms":{
          "name":["john","da"]
        }
    }
}

9、//range: Range query
GET stu/_search
{
    "query": {
        "range" : {
            "yearOfBorn" : {
                "gte" : 1995,
                "lte" : 2000
            }
        }
    }
}

10、//bool: Boolean query
GET stu/_search
{
    "query": {
      "bool": {
        "must": {
            "match": { "interest": "cooking"} },
        "must_not": {
            "range": { "yearOfBorn": { "gte": 1995, "lte": 2000 }}}
      }
    }
}

11、//wildcard fuzzy query wildcard *
GET /stu/_search
{
	"size": 20,
	"from": 0,
	"query": {
		"bool": {
			"should": [{
				"wildcard": {
					"form_name": "*very*"
				}
			}]
		}
	}
}
```

#### Batch CRUD _bulk (Extension)

The key point to note for batch CRUD operations is the json format of each operation

```shell
# This is the url for batch CRUD
post + http://127.0.0.1:9200/_bulk
```

**Batch create doc json Body format** *Note that it must end with enter key to be submitted correctly*

```json
// Format must be written on the same line
{"create":{"_index":index,"_type":type,"_id":id}}
{json content}

// Example
{"create":{"_index":"def","_type":"stu","_id":"2"}}
{"id": 2,"studentNo": "BU-POPO-2014-D211", "name": "Tom","major":"Politics", "gpa": 5.8, "yearofBorn": 1745,"classOf": 2000,"interst":"drive"}
{"create":{"_index":"def","_type":"stu","_id":"3"}}
{"id": 3,"studentNo": "BU-POPO-2014-D211", "name": "Faker","major":"Politics", "gpa": 4.5, "yearofBorn": 1777,"classOf": 1999,"interst":"drive"}
```

**Batch update doc json Body format**

```json
// Format keyword changed to update
{"update":{"_index":index,"_type":type,"_id":id}}
{"doc":{json string}}
```

**Batch delete doc json Body format**

```json
// Format keyword changed to delete
{"delete":{"_index":index,"_type":type,"_id":id}}
```

*Note: The above batch CRUD operations can be executed in the same request*

### Python Operations on ES

*pip install elasticsearch*

*Note the ES version, you can check the ES version in the browser search address, then install the corresponding version in Python, for example pip install elasticsearch6*

## Key ES Concepts Understanding

*Inverted Index*

*[ES Inverted Index - Zhihu (zhihu.com)](https://zhihu.com/p/387891930)*

## Summary

Through this article, we have mastered the complete setup and usage methods of Elasticsearch:

1. **Environment Setup**: JDK installation, ES service configuration, plugin installation
2. **Basic Concepts**: Core concepts such as index, type, document, shard
3. **Basic Operations**: RESTful API calls for CRUD operations
4. **Advanced Queries**: Various query syntax and batch operations
5. **Visualization Tools**: Usage of Kibana and ElasticSearch-head

As a powerful search engine, Elasticsearch has wide applications in full-text search, log analysis, real-time data analysis and other fields. Mastering its basic setup and usage methods is of great significance for modern application development.
