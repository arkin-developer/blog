---
title: "Elasticsearch环境配置及基础使用指南"
description: "详细介绍Elasticsearch在Windows环境下的完整安装配置流程，包括JDK安装、ES服务配置、插件安装、Kibana配置，以及完整的增删改查操作和高级查询语法"
keywords: ["Elasticsearch", "ES", "搜索引擎", "Kibana", "ElasticSearch-head", "RESTful", "数据库", "配置指南"]
author: "Arkin"
date: 2022-04-08T08:50:00+08:00
lastmod: 2025-01-27T18:30:00+08:00
draft: false
tags: ["Elasticsearch", "ES", "搜索引擎", "Kibana", "ElasticSearch-head", "RESTful", "数据库"]
categories: ["技术"]
aliases: ["/posts/elasticsearch-setup"]
image: "img/elasticsearch-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Elasticsearch是一个基于Lucene的分布式搜索和分析引擎，广泛应用于全文搜索、日志分析、实时数据分析等领域。本文详细介绍在Windows环境下Elasticsearch的完整配置和使用方法。

## 概述

Elasticsearch是一个基于Lucene的分布式搜索和分析引擎，广泛应用于全文搜索、日志分析、实时数据分析等领域。本文详细介绍在Windows环境下Elasticsearch的完整配置和使用方法。

## 配置须知

在开始安装Elasticsearch之前，需要了解以下组件：

- **JDK**：因为该搜索引擎是基于Java的
- **ES服务端**：核心搜索引擎
- **Nodejs**：客户端工具是基于Node.js的前端工程
- **KIBANA**：客户端可视化界面
- **ElasticSearch-head插件**：Web管理界面
- **API调试工具**：因为该引擎的查询使用的RESTful风格的调用规范

### 重要注意事项

*注意JDK和ES的版本对应问题*

## JDK安装

因为这里ES的版本是6.8.6，选用的JDK版本是1.8

![JDK安装](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408085021300.png)

## ES安装

*[Index of elasticsearch-local/6.8.6 (huaweicloud.com)](https://mirrors.huaweicloud.com/elasticsearch/6.8.6/)*

### 文件配置

在\elasticsearch-6.8.6\config\elasticsearch.yml文件最下面添加，表示可以任意连接。

```yaml
http.cors.enabled: true 
http.cors.allow-origin: "*"
```

### 启动

双击点击elasticsearch-6.8.6\bin\elasticsearch.bat

### 访问地址查看版本

*http://localhost:9200/*

![ES版本信息](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408092257149.png)

出现以上字眼表示安装成功

## 插件安装

### ElasticSearch-head

#### 安装Nodejs

![Nodejs安装](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408105146433.png)

#### 安装grunt

```shell
# 安装grunt
npm install -g grunt-cli
# 查看是否安装成功 
grunt -version
```

#### 下载head插件

*[mobz/elasticsearch-head: A web front end for an elastic search cluster (github.com)](https://github.com/mobz/elasticsearch-head)*

```shell
# 下载后进入该目录
cd C:\mysoftware\elasticsearch-head-master

# 安装该模块
npm install

# 启动下面两句都可以
npm run start
grunt server
```

#### 启动

http://localhost:9100

![ElasticSearch-head界面](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408111354902.png)

显示出此界面即为成功。

### Kibana

*[Kibana 6.8.6 | Elastic](https://www.elastic.co/cn/downloads/past-releases/kibana-6-8-6)*

安装与ES相同版本的Kibana

![Kibana安装](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408105434847.png)

#### 修改配置文件

\kibana-6.8.6-windows-x86_64\config

![Kibana配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408093851043.png)

#### 启动

`\kibana-6.8.6-windows-x86_64\bin\kibana.bat`

![Kibana启动](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408094007424.png)

[http://localhost:5601](http://localhost:5601/)

打开此地址就能看到

![Kibana界面](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408094110668.png)

至此！ES安装完成

## 简单使用（增删改查）

### 简单知识储备

#### 索引 index

一个索引就是一个拥有几分相似特征的文档的集合。比如说，你可以有一个客户数据的索引，另一个产品目录的索引，还有一个订单数据的索引。一个索引由一个名称来表示（**必须全部都是小写字母**）并且当我们要对对应于这个索引中的文档进行索引、搜索、更新和删除的时候，都要使用到这个名字。在一个集群中，可以定义任意多的索引。

#### 类型 type

在一个索引中，你可以定义一种或多种类型。一个类型是你的索引的一个逻辑分类/分区，其语义完全由你来定。通常，会为具有一组相同字段的文档定义一个类型。比如说，我们假设你运营一个博客平台并且将你所有的数据存储到一个索引中。在这个索引中，你可以为用户数据定义一个类型，为博客数据定义另一种类型，当然，也可以为评论数据定义另一种类型。

#### 字段 Field

相当于是数据表的字段，对文档数据根据不同属性进行的分类标识

#### 映射 mapping

mapping是处理数据的方式和规则方面做一些限制，如某个字段的数据类型、默认值、分析器、是否被索引等等，这些都是映射里面可以设置的，其他就是处理ES里面数据的一些使用规则设置也叫映射，按着最优规则处理数据对性能提高很大，因此才需要建立映射，并且需要思考如何建立映射才能对性能达到最优。

#### 文档 document

一个文档是一个可被索引的基础信息单元。比如，你可以拥有某一个客户的文档，某一个产品的一个文档，当然，也可以拥有某个订单的一个文档。文档以JSON格式来表示，而JSON是一个到处存在的互联网数据交互格式。

在一个index/type里面，你可以存储任意多的文档。注意，尽管一个文档，物理上存在于一个索引之中，文档必须被所索引/赋予一个索引的type。

#### 接近实时NRT

Elasticsearch是一个接近实时的搜索平台。这意味着，从索引一个文档直到这个文档能够被搜索到有一个轻微的延迟（通常实在1秒内）

#### 集群 cluster

一个集群就是由一个或多个节点组织在一起，他们共同持有整个的数据，并一起提供索引和搜索功能。一个集群由一个唯一的名字标识，这个名字默认就是"elasticsearch"。这个名字是重要的，因为一个节点只能通过指定某个集群的名字，来加入这个集群。

#### 节点 node

一个节点是集群中的一个服务器，作为集群的一部分，它存储数据，参与集群的索引和搜索功能。和集群类似，一个节点也是由一个名字来标识的，默认情况下，这个名字是一个随机的漫威漫画角色的名字，这个名字会在启动的时候赋予节点。这个名字对于管理工作来说挺重要的，因为在这个管理过程中，你会去确定网络中的那些服务器对应Elasticsearch集群中的那些节点。

一个节点可以通过配置集群名称的方式来加入一个指定的集群。默认情况下，每个节点都会被安排加入到一个叫"elasticsearch"的集群中，这意味着，如果你在你的网络中启动了若干个节点，并假定他们能够相互发现彼此，他们将会自动地形成并加入到一个"elasticsearch"的集群中。

#### 分片和复制 shards & replicas

一个索引可以存储超出单个节点硬件限制的大量数据。比如，一个具有10亿文档的索引占据1TB的磁盘空间，而任一节点都没有这样大的磁盘空间；或者单个节点处理搜索请求，响应太慢。为了解决这个问题，Elasticsearch提供了将索引划分成多份的能力，这些份就叫分片。当你创建一个索引的时候，你可以指定你想要的分片的数量。每个分片本身也是一个功能完善并且独立的索引，这个索引可以被放置到集群中的任何节点上。分片很重要，主要有两个原因：

1. 允许你水平分割/扩展你的内容容量
2. 允许你在分片（潜在的，位于多个节点上）之上进行分布式的、并行的操作，进而提高性能/吞吐量。

至于一个分片怎样分布，它的文档怎样聚合回搜索请求，是完全由Elasticsearch管理的，对于作为用户的你来说，这些都是透明的。

在一个网络/云的环境中，失败随时都可能发生，在某个分片/节点不知怎么的就处于离线状态，或者由于任何原因消失了，这种情况下，有一个故障转移机制是非常有用并且是强烈推荐的。为此目的，Elasticsearch允许你创建分片的一份或多份拷贝，这些拷贝叫做复制分片，或者直接叫复制。

复制之所以重要，有两个主要原因：在分片/节点失败的情况下，提供了高可用性。因为这个原因，注意到复制分片从不与原/主要（original/primary）分片置于同一节点上是非常重要的。扩展你的搜索量/吞吐量，因为搜索可以在所有的复制上并行。总之，每个索引可以被分成多个分片。一个索引也可以被复制0次（就是没有被复制）或多次。一旦复制了，每个索引就有了主分片（作为复制源的原来的分片）和复制分片（主分片的拷贝）之别。分片和复制的数量可以在索引创建的时候指定。在索引创建之后，你可以在任何时候动态地改变复制的数量，但是你时候不能改变分片的数量。

默认情况下，Elasticsearch中的每个索引被分片5个主分片和1个复制，这意味着，如果你的集群中至少有两个节点，你的索引将会有5个主分片和另外5个复制分片（1个完全拷贝），这样的话每个索引总共就有10个分片。

### 增删改查

![增删改查操作](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408111717394.png)

#### 增加或修改

ES的index类似于Mysql的database

**ES的type类似于Mysql的table，这个比喻不完全一样，因为table是相互独立的，但是type却可以搜索不同index下的type现已在高版本删除此关键字，因此可以默认使用type=doc来代替**

ES的doc类似于Mysql的table里的每一条记录（json的格式）

*在ES6.0.0之后不支持单index多type的方式，因为这容易造成资源浪费，因此保持单index单type的方式存储数据*

```
# 指定id创建和修改doc  
# put/post+url+index+type+id
# 例如我要创建index=grid type=changed id=0
put + http://127.0.0.1:9200/grid/type/0
```

![指定ID创建](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408134831754.png)

**如果指定的编号不存在该doc即为新增，如果存在了即为修改。**

```shell
# 不指定id创建doc，随机分配id
# post+url+index+type
# 例如我要创建index=grid type=changed
post + http://127.0.0.1:9200/grid/type
```

![随机ID创建](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408135933708.png)

#### 删除

```shell
# 删除指定id的doc
# delete+url+index+type+id
# 例如我要删除index=grid type=changed id=2的doc
delete + http://127.0.0.1:9200/grid/changed/2
```

存在此doc就会删除，不存在返回`not_found`

```shell
# 删除index 
# delete+url+index
# 例如我要删除index=grid 
delete + http://127.0.0.1:9200/grid
```

存在此index就会删除，不存在返回`error 404`

#### 查找（重点）

```shell
# 通过指定的id查找对应的doc
# get+url+index+type+id
# 例如我要找到index=grid type=changed id=1的doc
get + http://127.0.0.1:9200/grid/changed/1
```

![查找结果](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20220408141018808.png)

存在即返回结果，不存在返回`"found": false`

*高级查询语句*

```json
1、// GET /索引/类型/_search   查询所有
GET abc/article/_search

2、//match_all：返回所有文档
GET stu/_search
{
    "query": {
        "match_all": {}
    }
}

3、//match：布尔匹配查询：对查询字符串进行分词，根据分词结果构造布尔查询
GET stu/_search
{
    "query": {
        "match": {
          "name":"John Kerry"
        }
    }
}
//查询词为john和kerry，
//只要name字段值中包含有其中任意一个，那么返回该文档

4、//match_phrase：短语匹配查询
GET stu/_search
{
    "query": {
        "match_phrase": {
          "name":"John Kerry"
        }
    }
}
// 只要name字段值中包含john和kerry其中任意一个，那么返回该文档

5、//match_phrase_prefix：短语前缀匹配查询
GET stu/_search
{
    "query": {
        "match_phrase_prefix": {
          "name":"John Ke"
        }
    }
}
//最后一个分词作为前缀匹配

6、//multi_match：多字段匹配查询
GET stu/_search
{
    "query": {
        "multi_match": {
          "query": "John like cooking",
          "fields": ["name","interest"]
        }
    }
}

7、//term：词条查询：按照存储在倒排索引中的确切字词，对字段进行匹配
GET stu/_search
{
    "query": {
        "term":{
          "name":"john"
        }
    }
}

8、//terms：多词条查询：按照存储在倒排索引中的确切字词，对字段进行多词条匹配
GET stu/_search
{
    "query": {
        "terms":{
          "name":["john","da"]
        }
    }
}

9、//range：范围查询
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

10、//bool：布尔查询
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

11、//wildcard 模糊查询 通配符*
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

#### 批量增删改 _bulk（拓展）

批量增删改查需要注意的重点是增删改查各个操作的json格式即可

```shell
# 这是批量增删改查的url
post + http://127.0.0.1:9200/_bulk
```

**批量创建doc的json Body格式** *注意一定要用回车键结尾才能被正确提交*

```json
// 格式  必须写在同一行
{"create":{"_index":索引，"_type":类型，"_id":编号}}
{json 内容}

// 示例
{"create":{"_index":"def","_type":"stu","_id":"2"}}
{"id": 2,"studentNo": "BU-POPO-2014-D211", "name": "Tom","major":"Politics", "gpa": 5.8, "yearofBorn": 1745,"classOf": 2000,"interst":"drive"}
{"create":{"_index":"def","_type":"stu","_id":"3"}}
{"id": 3,"studentNo": "BU-POPO-2014-D211", "name": "Faker","major":"Politics", "gpa": 4.5, "yearofBorn": 1777,"classOf": 1999,"interst":"drive"}
```

**批量修改doc的json Body格式**

```json
// 格式 关键字改为update
{"update":{"_index":索引，"_type":类型，"_id":编号}}
{"doc"：{json串}}
```

**批量删除doc的json Body格式**

```json
// 格式 关键字改为delete
{"delete":{"_index":索引，"_type":类型，"_id":编号}}
```

*注意：以上增删改的批量是可以放在同一次请求中执行的*

### Python操作ES

*pip install elasticsearch*

*注意ES的版本，在浏览器搜索地址可以查看ES的版本，然后Python安装相应的版本，例如pip install elasticsearch6*

## ES关键思想理解

*倒排索引*

*[es倒序排序 - 知乎 (zhihu.com)](https://zhihu.com/p/387891930)*

## 总结

通过本文的学习，我们掌握了Elasticsearch的完整配置和使用方法：

1. **环境配置**：JDK安装、ES服务配置、插件安装
2. **基础概念**：索引、类型、文档、分片等核心概念
3. **基本操作**：增删改查的RESTful API调用
4. **高级查询**：各种查询语法和批量操作
5. **可视化工具**：Kibana和ElasticSearch-head的使用

Elasticsearch作为强大的搜索引擎，在全文搜索、日志分析、实时数据分析等领域有着广泛的应用，掌握其基础配置和使用方法对于现代应用开发具有重要意义。
