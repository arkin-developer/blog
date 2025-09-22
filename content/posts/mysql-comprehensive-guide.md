---
title: "MySQL全面学习指南：从基础到高级应用"
description: "详细介绍MySQL数据库的完整学习路径，包括安装配置、数据操作、查询优化、索引设计、数据库规范化以及JDBC连接等核心知识点"
keywords: ["MySQL", "数据库", "SQL", "关系型数据库", "数据操作", "查询优化", "索引", "JDBC", "学习指南"]
author: "Arkin"
date: 2022-01-14T16:00:00+08:00
lastmod: 2025-01-27T19:00:00+08:00
draft: false
tags: ["MySQL", "数据库", "SQL", "关系型数据库", "数据操作", "查询优化", "索引", "JDBC"]
categories: ["技术"]
aliases: ["/posts/mysql-comprehensive-guide"]
image: "img/mysql-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> MySQL作为最流行的开源关系型数据库管理系统，是每个开发者必须掌握的核心技能。本文详细介绍MySQL从基础安装到高级应用的完整学习路径。

## 概述

MySQL作为最流行的开源关系型数据库管理系统，是每个开发者必须掌握的核心技能。本文详细介绍MySQL从基础安装到高级应用的完整学习路径。

### 学习路径概览

**只会写代码，学好数据库，基本混饭吃**

**操作系统，数据结构与算法！当一个不错的程序员**

**离散数学，数字电路，体系结构，编译原理，实战经验，高级程序员**

## 初始MySQL

### 学习数据库的原因

1. **岗位需求**：数据库技能是开发者的基本要求
2. **大数据时代**：现在的世界、大数据时代~，得数据库者得天下
3. **被迫需求**：存数据是应用开发的基本需求
4. **核心地位**：*数据库是所有软件体系中最核心的存在* DBA

### 什么是数据库

**数据库（DB，DataBase）**

概念：数据仓库，软件，安装在操作系统之上

作用：存储数据，管理数据

### DBMS数据库管理系统

**关系型数据库：（SQL）**

- MySQL，Oracle，Sql Server，DB2，SQLlite
- 通过表和表之间，行和列之间的关系进行数据的存储，学员信息表

**非关系型数据库：(NoSQL) Not Only SQL**

- Redis，MongDB
- 以对象的形式存储，通过对象的自身属性来决定

**DBMS(数据库管理系统)**

- 数据库的管理软件，科学有效的管理我们的数据。维护和获取数据；
- MySQL，数据库管理系统

### MySQL简介

MySQL是一个**关系型数据库管理系统**

- **前世**：瑞典MySQL AB公司
- **今生**：属于Oracle旗下产品
- MySQL是最好的RDBMS应用软件之一；
- 开源的数据库软件
- 体积小、速度快、总体拥有成本低、用人成本低，所有人必须会
- 中小型网站、大型网站、集群！

官网：https://www.mysql.com

**安装建议：**

1. 尽量不用exe安装，注册表问题~
2. 尽可能使用压缩包安装~

### MySQL安装

1. 官网下载压缩文件；

2. 解压后把文件添加到环境变量中；

3. 新建mysql配置文件；my.ini *直接用txt文本写配置文件会因为编码问题失败，记得用notepad++*

```sql
[mysqld]
basedir=D:\\mysoftware\mysql-5.7.36\ -- D:\\ 要用双斜杆
datadir=D:\\mysoftware\mysql-5.7.36\data\ -- 自动生成，不用手动生成
port=3306
skip-grant-tables
```

4. 启用管理员模式下的CMD

5. 安装mysql服务

6. 初始化数据库文件

7. 启动mysql，进去修改密码

8. 进入mysql通过命令行（-p后面不用加空格），sql语句一定要;

9. 注释掉ini中的跳过密码；

10. 重启mysql，连接测试，如果连接成功就说明成功了

```sql
-- 第一步，安装服务
cd /d D:\mysoftware\mysql-5.7.36\bin
mysqld -install
-- 第二步，初始化数据库文件
mysqld --initialize-insecure --user=mysql
-- 第三步，启动mysql，进去修改密码
net start mysql
mysql -u root -p
-- 修改密码
use mysql
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
exit
net stop mysql
-- 第四步，重启服务
net start mysql
mysql -u root -p123456
```

### 安装SQLyog

```sql
-- 遇到SQLyog登录不上去的问题，在命令行进入mysql执行下列语句
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456'; 
```

![SQLyog界面](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20220114160555851.png)

### 连接数据库

命令行连接！

```sql
mysql -uroot -p123456 --连接数据库

update mysql.user set authentication_string=password('123456') where user='root' and Host='localhost'; --修改用户密码
flush privileges; -- 刷新权限
----------------------------------------------
-- 所有的语句都是；结尾
show databases; -- 查看所有的数据库

mysql> use school -- 切换数据库 use 数据库名
Database changed

--
show tables; -- 查看数据库中所有的表
describe student; -- 显示数据库中所有的表的信息

create database westos; -- 创建一个数据库

exit; -- 退出连接

-- 单行注释（SQL 的注释符）
/* (SQL 多行注释符)
hello 
*/
```

**数据库xxx语言** CRUD 增删改查

- DDL 定义
- DML 操作
- DQL 查询
- DCL 控制

## 操作数据库

操作数据库>操作数据库中的表>操作数据库中表的数据

*MySQL不区分大小写*

### 操作数据库

1. **创建数据库**

```sql
CREATE DATABASE [IF NOT EXISTS] westos;
```

2. **删除数据库**

```sql
DROP DATABASE [IF EXISTS] westos;
```

3. **使用数据库**

```sql
-- tab键上面，如果你的表名或者字段名是一个特殊字符，就需要带``
USE `school`
```

4. **查看数据库**

```sql
SHOW DATABASES -- 查看所有数据库
```

**对比：SQLyog的可视化操作**

![SQLyog可视化](C:\Users\mr-lai\AppData\Roaming\Typora\typora-user-images\image-20211214220045123.png)

学习思路：

- 对照SQLyog可视化历史记录查看sql！
- 固定的语法或关键字必须强行记住！

### 数据库的列类型

#### 1）数值型

- tinyint 十分小的数据 1个字节（0~255）
- smallint 较小的数据 2个字节
- mediumint 中等大小的数据 3个字节
- **int** 标准的整数 4**个字节** （最常用）
- bigint (long) 较大的数据 8个字节
- float 浮点数 4个字节
- double 浮点数 8个字节（精度问题）
- decimal 字符串形式的浮点数 金融计算时所用

#### 2）字符串

- char 字符串固定大小 0~255
- **varchar** 可变字符串 0~65535 常用，需要定义长度
- tinytext 微型文本 2^8-1
- **text** 文本串 2^16-1 保存文本
- mediumtext 中型文本串 2^24-1 保存中等大小文本

#### 3）时间日期

java.util.Date

- date YYYY-MM-DD，日期格式
- time HH:mm:ss，时间格式
- **datetime** YYYY-MM-DD HH:mm:ss 最常用的时间格式
- timestamp 时间戳，1970.1.1到现在的毫秒数! 也较为常用
- year 年份表示

#### 4）null

- 没有值，未知
- *注意，不要用NULL进行运算，结果为NULL*

### 数据库的字段属性（重点）

**Unsigned：**

- 无符号的整型
- 声明了该列不能为负数

**zerofill：**

- 0填充的
- 不足的位数，使用0填充，int(3)，5 (005)

**自增：**

- 自动在前一条记录的基础上+1
- 通常用来设计唯一的主键~，index，必须是整数类型
- 可以自定义设计主键自增的起始值和步长

**非空（not null）：**

- 假设设置为非空，如果不对其赋值，会报错
- NULL，如果不填写值，默认就是null!

**默认：**

- 设置默认的值
- sex，默认值为男，如果不指定该值，则默认为男

**拓展：**

有一些为了长久考虑，项目中要求每一个数据都要求有拓展的属性，例如：创建时间、修改时间等等

### 创建数据库表（重点）

```sql
-- 创建一个school数据库
-- 创建学生表（列，字段） 使用SQL创建
-- 学号int 登陆密码varchar(20) 姓名， 性别 varchar(2)，出生日期（datetime ）， 家庭住址， email

-- 表的名称和字段尽量用``
-- AUTO——INCREMENT 自增
CREATE TABLE IF NOT EXISTS `student2` (
    `id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '学号',
    `name` VARCHAR(30) NOT NULL DEFAULT '匿名' COMMENT '姓名',
    `pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT '密码',
    `sex` VARCHAR(2) NOT NULL DEFAULT '女' COMMENT '性别',
    `birthday` DATETIME DEFAULT NULL COMMENT '出生日期',
    `address` VARCHAR(100) DEFAULT NULL COMMENT '家庭住址',
    `email` VARCHAR(50) DEFAULT NULL COMMENT '邮箱',
    -- 主键
    PRIMARY KEY (`id`) 
)ENGINE=INNODB DEFAULT CHARSET=utf8
```

格式

```sql
CREATE TABLE [IF NOT EXISTS] `表名` （
    `字段名1` 列类型 [属性] [索引] [注释],
    `字段名2` 列类型 [属性] [索引] [注释],
    ......
    `字段名3` 列类型 [属性] [索引] [注释],
    PRIMARY KEY (`字段名`)
）[表类型][字符集设置][注释]
```

常用命令

```sql
SHOW CREATE DATABASE school -- 查看创建数据库的语句
SHOW CREATE TABLE student2 -- 查看student 数据表的定义语句
DESC student2 -- 显示表的结构
```

### 数据表的类型

```sql
-- 关于数据库引擎
/*
INNODB 默认使用
MYISAM 早些年使用
*/
```

|            | MYISAM | INNODB             |
| ---------- | ------ | ------------------ |
| 事务支持   | 不支持 | 支持               |
| 数据行锁定 | 不支持 | 支持               |
| 外键约束   | 不支持 | 支持               |
| 全文索引   | 支持   | 不支持             |
| 表空间大小 | 较小   | 较大，约为前者两倍 |

- MYISAM 节约空间，速度较快
- INNODB 安全性较高，事务的处理，多表多用户操作

*在物理空间存在的位置*

所有的数据库文件都存在data目录下，一个文件夹对应一个数据库

本质还是文件的存储

MySQL引擎在物理文件上的区别

- INNODB在数据库表中只有一个*.frm文件，以及上级目录下的ibdata1文件
- MYISAM对应文件
  - *.frm 表结构的定义文件
  - *.MYD 数据文件（data）
  - *.MYI 索引文件

*设置数据库表的字符集编码*

```
CHARSET=utf8
```

不设置，会是mysql默认的字符集编码（不支持编码）

MYSQL的默认编码是Latin1，不支持中文

在my.ini中配置默认的编码

```sql
character-set-server=utf8
```

### 修改删除表

*修改*

```sql
-- 修改表名 ALTER TABLE 旧表名 RENAME AS 新表名
ALTER TABLE teacher RENAME AS teacher1 
-- 增加表的字段 ALTER TABLE 表名 ADD 字段名 列属性
ALTER TABLE teacher1 ADD age INT(11)

-- 修改表的字段（重命名，修改约束！）
-- ALTER TABLE 表名 MODIFY 字段名 列属性[]
ALTER TABLE teacher1 MODIFY age VARCHAR(11)
-- ALTER TABLE 表名 CHANGE 旧字段名 新字段名 列属性[]
ALTER TABLE teacher1 CHANGE age age1 INT(1)

-- 删除表的字段 ALTER TABLE 表名 DROP 字段名
ALTER TABLE teacher1 DROP age1
```

*删除*

```sql
-- 删除表（如果表存在再删除）
DROP TABLE IF EXISTS teacher1
```

*所有的创建和删除操作尽量加上判断，避免报错*

注意点：

- `` 字段名，使用这个符号括起来
- 注释 -- /* */
- sql关键字不敏感，建议写小写

## MySQL数据管理

### 外键（了解即可）

*禁止使用外键和级联，一切外键必须在应用层解决*

*方式一：在创建表的时候，增加约束（麻烦，比较复杂）*

```sql
CREATE TABLE IF NOT EXISTS `student` (
    `id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '学号',
    `name` VARCHAR(30) NOT NULL DEFAULT '匿名' COMMENT '姓名',
    `pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT '密码',
    `sex` VARCHAR(2) NOT NULL DEFAULT '女' COMMENT '性别',
    `birthday` DATETIME DEFAULT NULL COMMENT '出生日期',
    `gradeid` INT(10) NOT NULL COMMENT '学生的年级',
    `address` VARCHAR(100) DEFAULT NULL COMMENT '家庭住址',
    `email` VARCHAR(50) DEFAULT NULL COMMENT '邮箱',
    -- 主键
    PRIMARY KEY (`id`) ,
    KEY `FK_gradeid` (`gradeid`),
    CONSTRAINT `FK_gradeid` FOREIGN KEY (`gradeid`) REFERENCES `grade`(`gradeid`)
)ENGINE=INNODB DEFAULT CHARSET=utf8
```

### DML语言（全部记住）

**数据库意义：**数据存储，数据管理

DML语言：数据操作语言

- insert
- update
- delete

### 添加(INSERT INTO)

```sql
-- 插入语句（添加）
-- insert into 表名（[字段名1，字段名2，字段名3]）values('值1')，('值2')，('值3'), (...)
INSERT INTO `grade`(`gradename`) VALUES('大四')

-- 由于主键自增我们可以省略（如果不写表的字段，他就会一一匹配）
-- 写插入语句，我们要保证数据和字段一一对应！
INSERT INTO `student`(`name`) VALUES('张三')
INSERT INTO `student`(`name`,`pwd`,`sex`) VALUES('张三','aaaaaaa','男')

-- 插入多个字段
INSERT INTO `student`(`name`,`pwd`,`sex`) 
VALUES('张三','aaaaaaa','男'),('王五','aaaaaaa','男')
```

语法：`insert into 表名（[字段名1，字段名2，字段名3]）values('值1')，('值2')，('值3'), (...)`

注意事项：

1. 字段和字段之间使用英文逗号隔开；
2. 字段是可以省略的，但是后面的值必须要一一对应，不能漏填字段；
3. 可以同时插入多条数据，values后面的值，需要使用，隔开即可。

### 修改（UPDATE）

*update 修改谁 （条件） set 原来的值*

```sql
-- 修改学员名字，带了条件
UPDATE `student` SET `name`='狂神'  WHERE id = 1; 

-- 不指定条件的情况下，会改动整张表！慎用。
UPDATE `student` SET `name`='长江七号'; 

-- 修改多个属性，逗号隔开
UPDATE `student` SET `name`='狂神', `email`='123184u31@qq.com' WHERE id=1;

-- 通过多个条件定位数据，无上限
UPDATE `student` SET `name` = '长江七号' WHERE `name`='狂神44' AND sex='女';

-- 语法：
-- UPDATE 表名 set colnum_name=value where [条件]
```

条件： where 子句 运算符 查询某个范围内的数据

操作符会返回 布尔值

| 操作符            | 含义                    | 举例  | 返回  |
| ----------------- | ----------------------- | ----- | ----- |
| =                 | 等于                    | 5=6   | false |
| <> 或 !=          | 不等于                  | 5<>6  | false |
| >                 | 大于                    |       |       |
| <                 | 小于                    |       |       |
| >=                | 大于等于                |       |       |
| <=                | 小于等于                |       |       |
| BETWEEN... and... | 在某个范围内            | [2,5] |       |
| AND               | && 两者成立才成立       |       |       |
| OR                | \|\| 两者有一个成立即可 |       |       |

语法：`UPDATE 表名 set colnum_name=value where [条件]`

注意：

1. colnum_name 是数据库的列，尽量带上``；
2. 条件，筛选的条件，如果没有指定，则会修改所有的值
3. value，是一个具体的值，也可以是一个变量（通过引用变量可以完成多样化的修改）
4. 多个设置的属性之间，使用英文逗号隔开

### 删除（DELETE）

*TRUNCATE 命令*

```sql
-- 清空 student 表

```

*delete 和 truncase 区别*

- 相同点：都能删除表的内容，并不会把表的结构也删除
- 不同：
  - truncase 重新设置自增列，计数器会归零
  - truncase 不会影响事务

```sql
-- 测试delete 和 truncate 区别
CREATE TABLE `test` (
    `id` INT(4) NOT NULL AUTO_INCREMENT,
    `coll` VARCHAR(20) NOT NULL,
    PRIMARY KEY(`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8

INSERT INTO `test`(`coll`) VALUE('1'),('2'),('3')

DELETE FROM `test` -- 不会影响自增

TRUNCATE TABLE `text` -- 自增会归零
```

了解即可：`DELETE删除的问题`，重启数据库，现象

- InnoDB 自增列会从1开始（存在内存中，断电即失）
- MyISAM 继续从上一个自增量开始（存在文件中的，不会因为断电丢失）

## DQL查询数据（最重要的部分）

### DQL（Data Query Language）数据查询语言

- 所有的查询操作都用它 Select
- 简单的查询，复杂的查询它都能做~
- *数据库中最核心的语言，最重要的语句*
- 使用频率最高的语句

*SELECT语法*

SELECT 语句必须满足以下的顺序

```sql
SELECT [ALL | DISTINCT]
{* | table.* | [table.field1[as alias1][,table.fields[as alias2]][,....]]}
FROM table_name [as table_alias]
	[left | right | inner join table_name2]    -- 联合查询
	[WHERE ...]  -- 指定结果需满足的条件
	[GROUP BY ...]  -- 指定结果按照哪几个字段来分组
	[HAVING]  -- 过滤分组的记录必须满足的次要条件
	[ORDER BY ...] -- 指定查询记录按一个或多个条件排序
	[LIMIT {[offset, ]row_count | row_countOFFSET offset}];
	-- 指定查询的记录从那条至那条
```

### 指定查询字段

```sql
-- 查询全部的学生
SELECT * FROM student

-- 查询指定字段
SELECT `StudnetNo`,`StudentName` FROM student

-- 别名，给结果起一个名字 AS 可以给字段起别名，也可以给表起别名
SELECT `StudentNo` AS 学号, `StudentName` AS 学生姓名 FROM student AS s

-- 函数 Concat(a,b)
SELECT CONCAT('姓名：',StudentName) As 新名字 FROM student
```

语法：`SELECT 字段，...FROM 表`

*有的时候，列名称不是很好键名知意，这个时候我们可以用别名，AS关键字*

*去重 distinct 关键字*

作用：去除SELECT 查询出来的结果中重复的数据，重复的数据只显示一条

```sql
-- 查询一下有哪些同学参加了考试，成绩
SELECT * FROM result -- 查询全部的考试成绩
SELECT `StudentNo` FROM result -- 查询由哪些同学参加了考试
SELECT DISTINCT `StudentNo` FROM result -- 发现重复数据，去重
```

*数据库的列（表达式） select 关键字的其它应用*

```sql
SELECT VERSION()  -- 查询系统版本（函数）
SELECT 100*3-1 AS 计算结果 -- 用来计算（表达式）
SELECT @@auto_increment_increment -- 查询自增的步长（变量）

-- 学员考试成绩 + 1分查看
SELECT `StudentNo`, `StudentResult` + 1 AS '提分后' FROM result
```

*数据库中的表达式：文本值，列，Null，函数，计算表达式，系统变量*

SELECT `表达式` FROM 表

### where 条件子句

作用：检索数据中`符合条件`的值

*逻辑运算符*

| 运算符     | 语法              | 描述                         |
| ---------- | ----------------- | ---------------------------- |
| and &&     | a and b  a&&b     | 逻辑与，两个都为真，结果为真 |
| or    \|\| | a or b     a\|\|b | 逻辑或，其中为真，结果为真   |
| not  !     | not a      !a     | 逻辑非，真为假，假为真       |

*尽量使用英文字母*

```sql
====================================== where ===================================================
-- 查询考试成绩在95~100分之间
SELECT studentNo, `StudentResult` FROM result
WHERE StudentResult>=95 AND StudentResult<=100

-- 模糊查询（区间）
SELECT studentNo, `StudentResult` FROM result
WHERE StudentResult BETWEEN 95 AND 100

-- 除了1000号学生之外的学生的成绩
SELECT studentNo, `StudentResult` FROM result
WHERE studentNo != 1000

-- != not
SELECT studentNo, `StudentResult` FROM result
WHERE NOT studentNo = 1000
```

*模糊查询：比较运算符（重点）*

| 运算符      | 语法               | 描述                                        |
| ----------- | ------------------ | ------------------------------------------- |
| IS NULL     | a is null          | 如果操作运算符为NULL，结果为真              |
| IS NOT NULL | a is not null      | 如果操作运算符为NOT NULL ，结果为真         |
| BETWEEN     | a between b and c  | 若a在b和c之间则结果为真                     |
| **LIKE**    | a like b           | SQL匹配，如果a匹配b，结果为真               |
| **IN**      | a in (a1,a2,a3...) | 假设a在a1,或则a2...其中的某一个值，结果为真 |

```sql
-- 模糊查询
-- 查询姓刘的同学
-- ===================== like(%和_是搭配like使用) ===================== 
-- like 结合 %（代表0到任意字符）   _（一个字符）
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE '刘%'

-- 查询姓刘的同学，名字后面只有一个字的
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE '刘_'

-- 查询姓刘的同学，名字后面只有两个字的
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE '刘__'

-- 查询名字中间有嘉字的同学  %嘉%
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE '%嘉%'

-- ===================== in（后面要具体的值） =====================
-- 查询1001，1002，1003号学员
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE StudentNo IN (1001,1002,1003)

-- 查询在北京的学生
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE `Address` IN ('安徽','河南洛阳')

-- =============== null/ not null =============
-- 查询地址为空的学生
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE address='' OR address IS NULL

-- 查询有出生日期的同学，不为空
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE `BornDate` IS NOT NULL

-- -- 查询没有出生日期的同学，为空
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE `BornDate` IS NULL
```

### 联表查询

*join*

![联表查询图1](C:\Users\mr-lai\AppData\Roaming\Typora\typora-user-images\image-20211229212013818.png)

![联表查询图2](C:\Users\mr-lai\Desktop\v2-d5384ac83ab3670990312b1f3ed570bb_r.jpg)

```sql
-- ===================== 联表查询 ==========================
-- 查询参加了考试的同学（学号，姓名，科目编号，分数）
SELECT * FROM student 
SELECT * FROM result

/* 思路
1. 分析需求，分析查询的字段来自那些表，（连接查询）
2. 确定使用哪种连接查询？ 7种
3. 确定交叉点（这两个表中那个数据是相同的）
4. 判断条件：学生表中的studentNo = 成绩表中的studentNo
*/
-- 涉及到多张表的查询时，分拆为多个两张表的处理，一步步完成需求
SELECT s.studentNo,studentName,SubjectName,`StudentResult`
FROM student s
RIGHT JOIN result r
ON r.studentNo = s.studentNo
INNER JOIN `subject` sub
ON r.SubjectNo = sub.SubjectNo 

--  ==================== JOIN ON ======================
-- INNER JOIN
SELECT s.studentNo,studentName,SubjectNo,StudentResult
FROM student AS s
INNER JOIN result AS r
ON s.studentNo = r.studentNo

-- RIGHT JOIN
SELECT s.studentNo,studentName,SubjectNo,StudentResult
FROM student s
RIGHT JOIN result r
ON s.studentNo = r.studentNo

-- LEFT JOIN
SELECT s.studentNo,studentName,SubjectNo,StudentResult
FROM student s
LEFT JOIN result r
ON s.studentNo = r.studentNo

-- 查询缺考的同学
SELECT s.studentNo,studentName,SubjectNo,StudentResult
FROM student s
LEFT JOIN result r
ON s.studentNo = r.studentNo
WHERE StudentResult IS NULL
--  ==================== JOIN ON ======================
```

| 操作       | 描述                                   |
| ---------- | -------------------------------------- |
| INNER JOIN | 如果表中至少有一个匹配，就返回行       |
| LEFT JOIN  | 从左表中返回所有的值，即使右表没有匹配 |
| RIGHT JOIN | 从右表中返回所有的值，即使左表没有匹配 |

*自连接*

自己的表和自己的表连接，**核心：一张表拆为两张一样的表即可。**

父类

| categoryid | categoryName |
| ---------- | ------------ |
| 2          | 信息技术     |
| 3          | 软件开发     |
| 5          | 美术设计     |

子类

| pid  | categoryid | categoryName |
| ---- | ---------- | ------------ |
| 3    | 4          | 数据库       |
| 2    | 8          | 办公信息     |
| 3    | 6          | web开发      |
| 5    | 7          | 美术设计     |

操作：查询父类对应的子类关系

| 父类     | 子类     |
| -------- | -------- |
| 信息技术 | 办公信息 |
| 软件开发 | 数据库   |
| 软件开发 | web开发  |
| 美术设计 | ps设计   |

```sql
-- 查询父子信息
SELECT a.`categoryName` AS '父栏目', b.`categoryName` AS '子栏目'
FROM `category` AS a, `category` AS b
WHERE a.`categoryid` = b.`pid`
```

### 分页和排序

*排序*

```sql
-- 排序：升序 ASC, 降序 DESC
-- ORDER BY 通过那个字段排序，怎么排
-- 查询的结果根据 成绩降序 排序
SELECT s.`StudentNo`, `StudentName`, `SubjectName`, `StudentResult`
FROM student s
INNER JOIN `result` r
ON s.`StudentNo` = r.`StudentNo`
INNER JOIN `subject` sub
ON r.`SubjectNo` = sub.`SubjectNo`
WHERE subjectName = '数据库结构-1'
ORDER BY `StudentResult` ASC 
```

*分页*

*为什么？*缓解数据库压力，美观，瀑布流

```sql
-- 分页，每页只显示五条数据
-- 语法：limit 起始值，一页的数量
-- 网页应用 
-- LIMIT 0,5  1~5
SELECT s.`StudentNo`, `StudentName`, `SubjectName`, `StudentResult`
FROM student s
INNER JOIN `result` r
ON s.StudnetNo = r.StudentNo
INNER JOIN `subject` sub
ON r.`SubjectNo` = sub.`SubjectNo`
WHERE subjectName = '数据库结构-1'
ORDER BY StudentResult ASC
LIMIT 0,5
```

**语法：**`limit(查询下标，pageSize(页面大小))`

### 子查询

where (这个值是计算出来的)

本质：`在where语句中嵌套`

```sql
-- ============================= where ================================
-- 1、查询数据库结构-1的所有考试结果（学号、科目编号、成绩），降序排列
-- 方式一： 使用连接查询
SELECT `StudentNo`,r.`SubjectName`,`StudentResult`
FROM `result` r
INNER JOIN `subject` sub
ON r.StudentNo = sub.StudentNo
WHERE SubjectName = '数据库结构-1'
ORDER BY StudentResult DESC

-- 方式二： 使用子查询where（）
SELECT `StudentNo`, `SubjectNo`, `StudentResult`
FROM `result`
WHERE StudentNo = (
	SELECT SubjectNo FROM `subject` 
    WHERE SubjectName = '数据库结构-1'
)

-- 查询所有数据库结构-1 的学生学号
SELECT SubjectNo FROM `subject` WHERE SubjectName = '数据库结构-1'

-- 分数不少于80分的学生的学号和姓名
SELECT DISTINCT s.`StudentNo`, `StudentName`
FROM student s
INNER JOIN result r
ON r.StudentNo = s.StudentNo
WHERE `StudentResult` >= 80

-- 在这个基础上增加一个科目，高等数学-2 查询
SELECT DISTINCT s.`StudentNo`, `StudentName`
FROM student s
INNER JOIN result r
ON r.StudentNo = s.StudentNo
WHERE `StudentResult` >= 80 AND `SubjectNo` = (
	SELECT SubjectNo FROM `subject` 
    WHERE `SubjectName` = '高等数学-2'
)

-- 查询课程为高等数学-2 且分数不少于80分的同学的学号和姓名
SELECT StudentNo, StudentName
FROM student s
INNER JOIN result r
ON s.StudentNo = r.StudentNo
INNER JOIN `subject` sub
ON r.`SubjectNo` = sub.`SubjectNo`
WHERE `SubjectResult` >= 80 AND `SubjectNo` = (
	SELECT SubjectNo FROM `subject`
    WHERE `SubjectName` = '高等数学-2'
)

-- 再改造，嵌套用法
SELECT StudentNo, StudentName FROM  student WHERE StudentNo IN (
	SELECT StudentNo FROM result WHERE StudentResult>80 AND SubjectNo = (
    	SELECT SubjectNo FROM `subject` WHERE `SubjectName` = '高等数学-2'
    )
)
```

## 索引

### 什么是索引

当表中有大量记录时，对表查询，如果是全表搜索，是将所有记录一一取出，和查询条件对比，然后返回满足条件的记录，这样消耗大量数据库系统时间，并造成大量磁盘I/O。 第二种就是在表中建立索引，然后在索引中找到符合查询条件的索引值，最后通过保存在索引中的ROWID 快速找到表中对应的记录。

索引是为了加速对表中的数据行的检索而创建的一种分散的存储结构。索引页面中的行都有逻辑指针。

### 索引的优缺点

**优点：**

1. 大大加快数据的检索速度
2. 创建唯一性索引，保证数据库中的每一行数据的唯一性。
3. 加速表与表之间的连接
4. 在使用分组和排序进行检索时，可以显著的减少查询的时间。

**缺点：**

1. 索引占物理空间，
2. 当对表中的数据进行增加，删除和修改的时候，索引也要动态的维护，降低了数据的维护速度。

### 索引类型

**单列索引**、**唯一索引**、**主键索引** 和 **聚集索引**

1. 普通索引：没有唯一性的限制，允许为空。可以直接创建create index name on tablename

修改表的时候 alert table tablename add index name ; 创建表的时候 create table tablename( ..index name col)

2. 唯一索引：unique index 没有任何两行具有相同索引值。

3. 主键索引：数据库中的一列或者列组合的值 唯一标识表中的每一行，该列为表的主键。一个表只能有一个主键，不允许为空，一般在建表的时候同事创建。

### 创建索引的三种方式

```sql
# indexName 索引名称  tableName 表名  columnName 列名称   length  限制长度
CREATE INDEX indexName ON tableName (columnName(length));

ALTER TABLE tableName ADD INDEX indexName(columnName);

# 建表时创建
CREATE TABLE tableName(  
  id INT NOT NULL,   
  columnName  columnType,
  INDEX [indexName] (columnName(length))  
);
```

我们在使用数据库的时候有时候需要看一下当前表中**数据占用了多少内存**，**索引占用了多少内存**：

```sql
select * from `information_schema`.`TABLES` where `TABLE_NAME` = 'tableName';
```

这句sql可以查询出来当前数据库实例**目标表**的信息。在这个问题中我们需要关注的字段是`DATA_LENGTH`和`INDEX_LENGTH`。这里就是我们想要看的数据大小和索引大小，单位是byte。

## 规范数据库设计

### 为什么需要设计

*当数据库比较复杂的时候，我们就需要设计数据库*

糟糕的数据库设计：

- 数据冗余，浪费空间
- 数据库插入和删除都会麻烦、异常【屏蔽使用物理外键】
- 程序的性能差

良好的数据库设计：

- 节省内存空间
- 保证数据库的完整性
- 方便我们开发系统

**软件开发中，关于数据库的设计：**

- 分析需求：分析业务和需要处理的数据库的需求
- 概要设计：设计关系E-R图

**设计数据库的步骤：（个人）**

- 收集信息，分析需求
  - 用户表（用户登录注销，用户的个人信息，写博客，创建分类）
  - 分类表（文章分类，谁创建的）
  - 文章表（文章的信息）
  - 友链表（友链信息）
  - 自定义表（系统信息，某个关键的字，或者一些值字段） key:value
  - 评论表
  - 说说表（发表心情.. id.. content...）
- 标识实体（把需求细化到）
  - user(id, username, password, sex, age, sign, open_id, avatar)
  - ...
- 标识实体之间的关系
  - 写博客：user --> blog
  - 创建分类：user --> category
  - 关注：user --> user
  - 友链：links
  - 评论：user-user-blog

### 三大范式

为啥需要数据规范化？

- 信息重复
- 更新异常
- 插入异常
  - 无法正常显示信息
- 删除异常
  - 丢失有效信息

*三大范式（了解）*

**第一范式（1NF）**：要求数据库表的每一列都是不可分割的原子数据项

原子性：保证每一列不可再分

**第二范式（2NF）**：需要确保数据库表中的每一列都和主键相关，而不能只与主键的某一部分相关（主要针对联合主键而言）

前提：满足第一范式

每张表只表示一件事

**第三范式（3NF）**：第三范式需确保数据表中的每一列数据都和主键直接相关，而不能间接相关

前提：满足第二范式

第三范式需要确保数据表中的每一列数据都和主键直接相关，而不能间接相关

（规范数据库的设计）

规范性和性能问题

关联查询的表不得超过三张表

- 考虑商业化的需求和目标，（成本，用户体验！）数据库的性能更加重要
- 在规范性能的问题的时候，需要适当的考虑一下规范性
- 故意给某些表增加一些冗余字段（从多表查询变为单表查询）
- 故意增加一些计算列（从大数据量降低为小数据量查询：索引）

## JDBC(重点)

### 数据库驱动

驱动：声卡，显卡，数据库

程序通过数据驱动操作数据库

### JDBC

SUN公司为了简化开发人员（对数据库的统一）操作，提供了一个（JAVA操作数据库）的规范，俗称JDBC，这些规范的实现由具体的厂商去做，把功能分工，开发人员学习操作JDBC，厂商实现JDBC对数据库的操作（驱动）。

java.sql

javax.sql

## 总结

通过本文的学习，我们掌握了MySQL数据库的完整知识体系：

1. **基础概念**：数据库、DBMS、关系型与非关系型数据库
2. **安装配置**：MySQL安装、SQLyog配置、连接测试
3. **数据操作**：DDL、DML、DQL、DCL四大语言
4. **查询优化**：联表查询、子查询、索引设计
5. **数据库设计**：三大范式、规范化设计原则
6. **JDBC连接**：Java程序与数据库的桥梁

MySQL作为企业级应用的核心组件，掌握其完整知识体系对于现代软件开发具有重要意义。在实际开发中，需要根据业务需求合理设计数据库结构，优化查询性能，确保数据的安全性和完整性。
