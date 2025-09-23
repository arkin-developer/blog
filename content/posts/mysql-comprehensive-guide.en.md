---
title: "MySQL Comprehensive Learning Guide: From Basics to Advanced Applications"
description: "A detailed introduction to the complete MySQL learning path, including installation configuration, data operations, query optimization, index design, database normalization, and JDBC connections"
keywords: ["MySQL", "Database", "SQL", "Relational Database", "Data Operations", "Query Optimization", "Index", "JDBC", "Learning Guide"]
author: "Arkin"
date: 2022-01-14T16:00:00+08:00
lastmod: 2022-01-14T16:00:00+08:00
draft: false
tags: ["MySQL", "Database", "SQL", "Relational Database", "Data Operations", "Query Optimization", "Index", "JDBC"]
categories: ["Technology"]
aliases: ["/posts/mysql-comprehensive-guide"]
image: "img/mysql-tutorial.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> MySQL, as the most popular open-source relational database management system, is a core skill that every developer must master. This article provides a detailed introduction to the complete learning path of MySQL from basic installation to advanced applications.

## Overview

MySQL, as the most popular open-source relational database management system, is a core skill that every developer must master. This article provides a detailed introduction to the complete learning path of MySQL from basic installation to advanced applications.

### Learning Path Overview

*If you can only write code, learn databases well, and basically make a living*

*Operating systems, data structures and algorithms! Be a good programmer*

*Discrete mathematics, digital circuits, system architecture, compilation principles, practical experience, advanced programmer*

## Introduction to MySQL

### Reasons for Learning Databases

1. **Job Requirements**: Database skills are basic requirements for developers
2. **Big Data Era**: Current world, big data era~, those who master databases rule the world
3. **Forced Requirements**: Storing data is a basic need for application development
4. **Core Position**: *Database is the most core existence in all software systems* DBA

### What is a Database

**Database (DB, DataBase)**

Concept: Data warehouse, software, installed on operating system

Function: Store data, manage data

### DBMS Database Management System

**Relational Database: (SQL)**

- MySQL, Oracle, Sql Server, DB2, SQLlite
- Store data through relationships between tables, rows and columns, student information table

**Non-Relational Database: (NoSQL) Not Only SQL**

- Redis, MongoDB
- Store in object form, determined by object's own properties

**DBMS (Database Management System)**

- Database management software that scientifically and effectively manages our data. Maintain and retrieve data;
- MySQL, database management system

### MySQL Introduction

MySQL is a **relational database management system**

- **Past**: Swedish MySQL AB company
- **Present**: Owned by Oracle
- MySQL is one of the best RDBMS application software;
- Open source database software
- Small size, fast speed, low total cost of ownership, low human cost, everyone must know
- Small and medium websites, large websites, clusters!

Official website: https://www.mysql.com

**Installation Recommendations:**

1. Try not to use exe installation, registry problems~
2. Use compressed package installation whenever possible~

### MySQL Installation

1. Download compressed file from official website;

2. Add file to environment variables after extraction;

3. Create new mysql configuration file; my.ini *Writing configuration file directly with txt text will fail due to encoding issues, remember to use notepad++*

```sql
[mysqld]
basedir=D:\\mysoftware\mysql-5.7.36\ -- D:\\ must use double backslashes
datadir=D:\\mysoftware\mysql-5.7.36\data\ -- Auto-generated, no need to manually create
port=3306
skip-grant-tables
```

4. Enable CMD in administrator mode

5. Install mysql service

6. Initialize database files

7. Start mysql, enter to modify password

8. Enter mysql through command line (-p followed by no space), sql statements must end with;

9. Comment out skip password in ini;

10. Restart mysql, connection test, if connection successful then success

```sql
-- Step 1, install service
cd /d D:\mysoftware\mysql-5.7.36\bin
mysqld -install
-- Step 2, initialize database files
mysqld --initialize-insecure --user=mysql
-- Step 3, start mysql, enter to modify password
net start mysql
mysql -u root -p
-- Modify password
use mysql
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
exit
net stop mysql
-- Step 4, restart service
net start mysql
mysql -u root -p123456
```

### Install SQLyog

```sql
-- If SQLyog login fails, execute following statements in mysql command line
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456'; 
```

![SQLyog Interface](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20220114160555851.png)

### Connect to Database

Command line connection!

```sql
mysql -uroot -p123456 --Connect to database

update mysql.user set authentication_string=password('123456') where user='root' and Host='localhost'; --Modify user password
flush privileges; -- Refresh permissions
----------------------------------------------
-- All statements end with ;
show databases; -- View all databases

mysql> use school -- Switch database use database name
Database changed

--
show tables; -- View all tables in database
describe student; -- Display information of all tables in database

create database westos; -- Create a database

exit; -- Exit connection

-- Single line comment (SQL comment symbol)
/* (SQL multi-line comment symbol)
hello 
*/
```

**Database xxx Language** CRUD Add Delete Update Query

- DDL Definition
- DML Manipulation
- DQL Query
- DCL Control

## Database Operations

Database operations > Table operations in database > Data operations in database tables

*MySQL is case insensitive*

### Database Operations

1. **Create Database**

```sql
CREATE DATABASE [IF NOT EXISTS] westos;
```

2. **Delete Database**

```sql
DROP DATABASE [IF EXISTS] westos;
```

3. **Use Database**

```sql
-- Above tab key, if your table name or field name is a special character, use ``
USE `school`
```

4. **View Database**

```sql
SHOW DATABASES -- View all databases
```

**Comparison: SQLyog Visual Operations**

![SQLyog Visualization](C:\Users\mr-lai\AppData\Roaming\Typora\typora-user-images\image-20211214220045123.png)

Learning approach:

- Compare SQLyog visual history to view SQL!
- Fixed syntax or keywords must be memorized!

### Database Column Types

#### 1) Numeric

- tinyint Very small data 1 byte (0~255)
- smallint Smaller data 2 bytes
- mediumint Medium-sized data 3 bytes
- **int** Standard integer 4** bytes** (most commonly used)
- bigint (long) Larger data 8 bytes
- float Floating point 4 bytes
- double Floating point 8 bytes (precision issues)
- decimal String-form floating point Used in financial calculations

#### 2) String

- char Fixed-size string 0~255
- **varchar** Variable string 0~65535 Commonly used, need to define length
- tinytext Micro text 2^8-1
- **text** Text string 2^16-1 Store text
- mediumtext Medium text string 2^24-1 Store medium-sized text

#### 3) Date Time

java.util.Date

- date YYYY-MM-DD, date format
- time HH:mm:ss, time format
- **datetime** YYYY-MM-DD HH:mm:ss Most commonly used time format
- timestamp Timestamp, milliseconds from 1970.1.1 to now! Also commonly used
- year Year representation

#### 4) null

- No value, unknown
- *Note, don't use NULL for calculations, result is NULL*

### Database Field Properties (Key Points)

**Unsigned:**

- Unsigned integer
- Declares that this column cannot be negative

**zerofill:**

- Zero-filled
- Insufficient digits, fill with 0, int(3), 5 (005)

**Auto-increment:**

- Automatically +1 based on previous record
- Usually used to design unique primary key~, index, must be integer type
- Can customize auto-increment start value and step size

**Not null:**

- If set to not null, will error if not assigned
- NULL, if no value filled, default is null!

**Default:**

- Set default value
- sex, default value male, if not specified, default to male

**Extension:**

For long-term consideration, some projects require every data to have extended attributes, such as: creation time, modification time, etc.

### Create Database Table (Key Points)

```sql
-- Create a school database
-- Create student table (columns, fields) using SQL
-- Student number int, login password varchar(20), name, gender varchar(2), birth date (datetime), home address, email

-- Table names and fields should use ``
-- AUTO_INCREMENT auto-increment
CREATE TABLE IF NOT EXISTS `student2` (
    `id` INT(4) NOT NULL AUTO_INCREMENT COMMENT 'Student Number',
    `name` VARCHAR(30) NOT NULL DEFAULT 'Anonymous' COMMENT 'Name',
    `pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT 'Password',
    `sex` VARCHAR(2) NOT NULL DEFAULT 'Female' COMMENT 'Gender',
    `birthday` DATETIME DEFAULT NULL COMMENT 'Birth Date',
    `address` VARCHAR(100) DEFAULT NULL COMMENT 'Home Address',
    `email` VARCHAR(50) DEFAULT NULL COMMENT 'Email',
    -- Primary key
    PRIMARY KEY (`id`) 
)ENGINE=INNODB DEFAULT CHARSET=utf8
```

Format

```sql
CREATE TABLE [IF NOT EXISTS] `table_name` （
    `field_name1` column_type [attributes] [index] [comment],
    `field_name2` column_type [attributes] [index] [comment],
    ......
    `field_name3` column_type [attributes] [index] [comment],
    PRIMARY KEY (`field_name`)
）[table_type][character_set][comment]
```

Common commands

```sql
SHOW CREATE DATABASE school -- View database creation statement
SHOW CREATE TABLE student2 -- View student data table definition statement
DESC student2 -- Display table structure
```

### Data Table Types

```sql
-- About database engine
/*
INNODB Default use
MYISAM Used in earlier years
*/
```

|            | MYISAM | INNODB             |
| ---------- | ------ | ------------------ |
| Transaction Support   | Not supported | Supported               |
| Row Locking | Not supported | Supported               |
| Foreign Key Constraint   | Not supported | Supported               |
| Full-text Index   | Supported   | Not supported             |
| Table Space Size | Smaller   | Larger, about twice the former |

- MYISAM Save space, faster speed
- INNODB Higher security, transaction processing, multi-table multi-user operations

*Physical storage location*

All database files exist in data directory, one folder corresponds to one database

Essence is still file storage

MySQL engine differences in physical files

- INNODB only has one *.frm file in database table, and ibdata1 file in parent directory
- MYISAM corresponding files
  - *.frm Table structure definition file
  - *.MYD Data file (data)
  - *.MYI Index file

*Set database table character set encoding*

```
CHARSET=utf8
```

If not set, will use mysql default character set encoding (doesn't support encoding)

MYSQL default encoding is Latin1, doesn't support Chinese

Configure default encoding in my.ini

```sql
character-set-server=utf8
```

### Modify Delete Table

*Modify*

```sql
-- Modify table name ALTER TABLE old_table_name RENAME AS new_table_name
ALTER TABLE teacher RENAME AS teacher1 
-- Add table field ALTER TABLE table_name ADD field_name column_attributes
ALTER TABLE teacher1 ADD age INT(11)

-- Modify table field (rename, modify constraints!)
-- ALTER TABLE table_name MODIFY field_name column_attributes[]
ALTER TABLE teacher1 MODIFY age VARCHAR(11)
-- ALTER TABLE table_name CHANGE old_field_name new_field_name column_attributes[]
ALTER TABLE teacher1 CHANGE age age1 INT(1)

-- Delete table field ALTER TABLE table_name DROP field_name
ALTER TABLE teacher1 DROP age1
```

*Delete*

```sql
-- Delete table (delete if table exists)
DROP TABLE IF EXISTS teacher1
```

*All creation and deletion operations should add judgment to avoid errors*

Notes:

- `` field names, use this symbol to wrap
- Comments -- /* */
- SQL keywords are case insensitive, recommend lowercase

## MySQL Data Management

### Foreign Keys (Understanding Only)

*Prohibit using foreign keys and cascades, all foreign keys must be resolved at application layer*

*Method 1: Add constraints when creating table (troublesome, complex)*

```sql
CREATE TABLE IF NOT EXISTS `student` (
    `id` INT(4) NOT NULL AUTO_INCREMENT COMMENT 'Student Number',
    `name` VARCHAR(30) NOT NULL DEFAULT 'Anonymous' COMMENT 'Name',
    `pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT 'Password',
    `sex` VARCHAR(2) NOT NULL DEFAULT 'Female' COMMENT 'Gender',
    `birthday` DATETIME DEFAULT NULL COMMENT 'Birth Date',
    `gradeid` INT(10) NOT NULL COMMENT 'Student Grade',
    `address` VARCHAR(100) DEFAULT NULL COMMENT 'Home Address',
    `email` VARCHAR(50) DEFAULT NULL COMMENT 'Email',
    -- Primary key
    PRIMARY KEY (`id`) ,
    KEY `FK_gradeid` (`gradeid`),
    CONSTRAINT `FK_gradeid` FOREIGN KEY (`gradeid`) REFERENCES `grade`(`gradeid`)
)ENGINE=INNODB DEFAULT CHARSET=utf8
```

### DML Language (Must Remember All)

**Database Meaning:** Data storage, data management

DML Language: Data Manipulation Language

- insert
- update
- delete

### Add (INSERT INTO)

```sql
-- Insert statement (add)
-- insert into table_name（[field_name1，field_name2，field_name3]）values('value1')，('value2')，('value3'), (...)
INSERT INTO `grade`(`gradename`) VALUES('Senior Year')

-- Since primary key auto-increment we can omit (if not writing table fields, it will match one by one)
-- When writing insert statements, we must ensure data and fields correspond one by one!
INSERT INTO `student`(`name`) VALUES('Zhang San')
INSERT INTO `student`(`name`,`pwd`,`sex`) VALUES('Zhang San','aaaaaaa','Male')

-- Insert multiple fields
INSERT INTO `student`(`name`,`pwd`,`sex`) 
VALUES('Zhang San','aaaaaaa','Male'),('Wang Wu','aaaaaaa','Male')
```

Syntax: `insert into table_name（[field_name1，field_name2，field_name3]）values('value1')，('value2')，('value3'), (...)`

Notes:

1. Use English commas between fields;
2. Fields can be omitted, but subsequent values must correspond one by one, cannot miss fields;
3. Can insert multiple data simultaneously, values after values need comma separation.

### Modify (UPDATE)

*update modify who (condition) set original value*

```sql
-- Modify student name, with condition
UPDATE `student` SET `name`='Kuang Shen'  WHERE id = 1; 

-- Without specifying condition, will modify entire table! Use with caution.
UPDATE `student` SET `name`='Chang Jiang Qi Hao'; 

-- Modify multiple attributes, separate with commas
UPDATE `student` SET `name`='Kuang Shen', `email`='123184u31@qq.com' WHERE id=1;

-- Locate data through multiple conditions, no limit
UPDATE `student` SET `name` = 'Chang Jiang Qi Hao' WHERE `name`='Kuang Shen44' AND sex='Female';

-- Syntax:
-- UPDATE table_name set colnum_name=value where [condition]
```

Condition: where clause operator query data within certain range

Operators return boolean values

| Operator            | Meaning                    | Example  | Return  |
| ----------------- | ----------------------- | ----- | ----- |
| =                 | Equal                    | 5=6   | false |
| <> or !=          | Not equal                  | 5<>6  | false |
| >                 | Greater than                    |       |       |
| <                 | Less than                    |       |       |
| >=                | Greater than or equal                |       |       |
| <=                | Less than or equal                |       |       |
| BETWEEN... and... | Within certain range            | [2,5] |       |
| AND               | && Both must be true       |       |       |
| OR                | \|\| One must be true |       |       |

Syntax: `UPDATE table_name set colnum_name=value where [condition]`

Notes:

1. colnum_name is database column, try to use ``;
2. Condition, filter condition, if not specified, will modify all values
3. value is a specific value, can also be a variable (diverse modifications through variable references)
4. Multiple attribute settings, separate with English commas

### Delete (DELETE)

*TRUNCATE command*

```sql
-- Clear student table

```

*delete and truncate differences*

- Same: Both can delete table content, won't delete table structure
- Different:
  - truncate resets auto-increment column, counter resets to zero
  - truncate doesn't affect transactions

```sql
-- Test delete and truncate differences
CREATE TABLE `test` (
    `id` INT(4) NOT NULL AUTO_INCREMENT,
    `coll` VARCHAR(20) NOT NULL,
    PRIMARY KEY(`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8

INSERT INTO `test`(`coll`) VALUE('1'),('2'),('3')

DELETE FROM `test` -- Won't affect auto-increment

TRUNCATE TABLE `text` -- Auto-increment will reset to zero
```

Understanding only: `DELETE deletion problem`, restart database, phenomenon

- InnoDB auto-increment column starts from 1 (stored in memory, lost on power failure)
- MyISAM continues from previous auto-increment value (stored in file, won't be lost due to power failure)

## DQL Query Data (Most Important Part)

### DQL (Data Query Language) Data Query Language

- All query operations use Select
- Simple queries, complex queries it can do~
- *Core language of database, most important statement*
- Most frequently used statement

*SELECT Syntax*

SELECT statement must satisfy the following order

```sql
SELECT [ALL | DISTINCT]
{* | table.* | [table.field1[as alias1][,table.fields[as alias2]][,....]]}
FROM table_name [as table_alias]
	[left | right | inner join table_name2]    -- Union query
	[WHERE ...]  -- Specify conditions that results must satisfy
	[GROUP BY ...]  -- Specify which fields to group results by
	[HAVING]  -- Filter grouped records must satisfy secondary conditions
	[ORDER BY ...] -- Specify query records sorted by one or more conditions
	[LIMIT {[offset, ]row_count | row_countOFFSET offset}];
	-- Specify query records from which to which
```

### Specify Query Fields

```sql
-- Query all students
SELECT * FROM student

-- Query specified fields
SELECT `StudentNo`,`StudentName` FROM student

-- Alias, give result a name AS can alias fields, can also alias tables
SELECT `StudentNo` AS Student Number, `StudentName` AS Student Name FROM student AS s

-- Function Concat(a,b)
SELECT CONCAT('Name:',StudentName) As New Name FROM student
```

Syntax: `SELECT field,...FROM table`

*Sometimes column names are not very meaningful, we can use aliases, AS keyword*

*Deduplication distinct keyword*

Function: Remove duplicate data from SELECT query results, duplicate data only shows one

```sql
-- Query which students took exams, scores
SELECT * FROM result -- Query all exam scores
SELECT `StudentNo` FROM result -- Query which students took exams
SELECT DISTINCT `StudentNo` FROM result -- Found duplicate data, deduplicate
```

*Database columns (expressions) other applications of select keyword*

```sql
SELECT VERSION()  -- Query system version (function)
SELECT 100*3-1 AS Calculation Result -- Used for calculation (expression)
SELECT @@auto_increment_increment -- Query auto-increment step size (variable)

-- Student exam scores + 1 point view
SELECT `StudentNo`, `StudentResult` + 1 AS 'Score After Bonus' FROM result
```

*Database expressions: text values, columns, Null, functions, calculation expressions, system variables*

SELECT `expression` FROM table

### where condition clause

Function: Retrieve data that `satisfies conditions`

*Logical operators*

| Operator     | Syntax              | Description                         |
| ---------- | ----------------- | ---------------------------- |
| and &&     | a and b  a&&b     | Logical AND, both true, result true |
| or    \|\| | a or b     a\|\|b | Logical OR, one true, result true   |
| not  !     | not a      !a     | Logical NOT, true becomes false, false becomes true       |

*Try to use English letters*

```sql
====================================== where ===================================================
-- Query exam scores between 95~100
SELECT studentNo, `StudentResult` FROM result
WHERE StudentResult>=95 AND StudentResult<=100

-- Fuzzy query (range)
SELECT studentNo, `StudentResult` FROM result
WHERE StudentResult BETWEEN 95 AND 100

-- Scores of students except student 1000
SELECT studentNo, `StudentResult` FROM result
WHERE studentNo != 1000

-- != not
SELECT studentNo, `StudentResult` FROM result
WHERE NOT studentNo = 1000
```

*Fuzzy query: comparison operators (key points)*

| Operator      | Syntax               | Description                                        |
| ----------- | ------------------ | ------------------------------------------- |
| IS NULL     | a is null          | If operand is NULL, result is true              |
| IS NOT NULL | a is not null      | If operand is NOT NULL, result is true         |
| BETWEEN     | a between b and c  | If a is between b and c, result is true                     |
| **LIKE**    | a like b           | SQL matching, if a matches b, result is true               |
| **IN**      | a in (a1,a2,a3...) | If a is one of a1, or a2... values, result is true |

```sql
-- Fuzzy query
-- Query students surnamed Liu
-- ===================== like(% and _ are used with like) ===================== 
-- like combined with % (represents 0 to any characters)   _ (one character)
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE 'Liu%'

-- Query students surnamed Liu with only one character after name
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE 'Liu_'

-- Query students surnamed Liu with only two characters after name
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE 'Liu__'

-- Query students with 'Jia' in the middle of name  %Jia%
SELECT `StudentNo`,`StudentName` FROM `Student`
WHERE StudentName LIKE '%Jia%'

-- ===================== in (must be specific values) =====================
-- Query students 1001, 1002, 1003
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE StudentNo IN (1001,1002,1003)

-- Query students in Beijing
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE `Address` IN ('Anhui','Henan Luoyang')

-- =============== null/ not null =============
-- Query students with empty address
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE address='' OR address IS NULL

-- Query students with birth date, not empty
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE `BornDate` IS NOT NULL

-- Query students without birth date, empty
SELECT `StudentNo`, `StudentName` FROM `student`
WHERE `BornDate` IS NULL
```

### Join Query

*join*

![Join Query Chart 1](C:\Users\mr-lai\AppData\Roaming\Typora\typora-user-images\image-20211229212013818.png)

![Join Query Chart 2](C:\Users\mr-lai\Desktop\v2-d5384ac83ab3670990312b1f3ed570bb_r.jpg)

```sql
-- ===================== Join Query ==========================
-- Query students who took exams (student number, name, subject number, score)
SELECT * FROM student 
SELECT * FROM result

/* Approach
1. Analyze requirements, analyze query fields from which tables, (join query)
2. Determine which join query to use? 7 types
3. Determine intersection point (which data is the same in these two tables)
4. Judgment condition: studentNo in student table = studentNo in score table
*/
-- When involving multi-table queries, split into multiple two-table processing, complete requirements step by step
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

-- Query students who missed exams
SELECT s.studentNo,studentName,SubjectNo,StudentResult
FROM student s
LEFT JOIN result r
ON s.studentNo = r.studentNo
WHERE StudentResult IS NULL
--  ==================== JOIN ON ======================
```

| Operation       | Description                                   |
| ---------- | -------------------------------------- |
| INNER JOIN | If at least one match in tables, return row       |
| LEFT JOIN  | Return all values from left table, even if right table has no match |
| RIGHT JOIN | Return all values from right table, even if left table has no match |

*Self join*

Connect table with itself, **core: split one table into two identical tables.**

Parent category

| categoryid | categoryName |
| ---------- | ------------ |
| 2          | Information Technology     |
| 3          | Software Development     |
| 5          | Art Design     |

Child category

| pid  | categoryid | categoryName |
| ---- | ---------- | ------------ |
| 3    | 4          | Database       |
| 2    | 8          | Office Information     |
| 3    | 6          | web development      |
| 5    | 7          | Art Design     |

Operation: Query parent-child category relationships

| Parent     | Child     |
| -------- | -------- |
| Information Technology | Office Information |
| Software Development | Database   |
| Software Development | web development  |
| Art Design | ps design   |

```sql
-- Query parent-child information
SELECT a.`categoryName` AS 'Parent Column', b.`categoryName` AS 'Child Column'
FROM `category` AS a, `category` AS b
WHERE a.`categoryid` = b.`pid`
```

### Pagination and Sorting

*Sorting*

```sql
-- Sorting: ascending ASC, descending DESC
-- ORDER BY which field to sort by, how to sort
-- Query results sorted by score descending
SELECT s.`StudentNo`, `StudentName`, `SubjectName`, `StudentResult`
FROM student s
INNER JOIN `result` r
ON s.`StudentNo` = r.`StudentNo`
INNER JOIN `subject` sub
ON r.`SubjectNo` = sub.`SubjectNo`
WHERE subjectName = 'Database Structure-1'
ORDER BY `StudentResult` ASC 
```

*Pagination*

*Why?* Reduce database pressure, aesthetics, waterfall flow

```sql
-- Pagination, display only 5 records per page
-- Syntax: limit start value, number per page
-- Web application 
-- LIMIT 0,5  1~5
SELECT s.`StudentNo`, `StudentName`, `SubjectName`, `StudentResult`
FROM student s
INNER JOIN `result` r
ON s.StudnetNo = r.StudentNo
INNER JOIN `subject` sub
ON r.`SubjectNo` = sub.`SubjectNo`
WHERE subjectName = 'Database Structure-1'
ORDER BY StudentResult ASC
LIMIT 0,5
```

**Syntax:** `limit(query index, pageSize(page size))`

### Subquery

where (this value is calculated)

Essence: `nested in where statement`

```sql
-- ============================= where ================================
-- 1. Query all exam results for Database Structure-1 (student number, subject number, score), descending order
-- Method 1: Use join query
SELECT `StudentNo`,r.`SubjectName`,`StudentResult`
FROM `result` r
INNER JOIN `subject` sub
ON r.StudentNo = sub.StudentNo
WHERE SubjectName = 'Database Structure-1'
ORDER BY StudentResult DESC

-- Method 2: Use subquery where()
SELECT `StudentNo`, `SubjectNo`, `StudentResult`
FROM `result`
WHERE StudentNo = (
	SELECT SubjectNo FROM `subject` 
    WHERE SubjectName = 'Database Structure-1'
)

-- Query all student numbers for Database Structure-1
SELECT SubjectNo FROM `subject` WHERE SubjectName = 'Database Structure-1'

-- Students with scores not less than 80 points, student number and name
SELECT DISTINCT s.`StudentNo`, `StudentName`
FROM student s
INNER JOIN result r
ON r.StudentNo = s.StudentNo
WHERE `StudentResult` >= 80

-- Add another subject on this basis, Advanced Mathematics-2 query
SELECT DISTINCT s.`StudentNo`, `StudentName`
FROM student s
INNER JOIN result r
ON r.StudentNo = s.StudentNo
WHERE `StudentResult` >= 80 AND `SubjectNo` = (
	SELECT SubjectNo FROM `subject` 
    WHERE `SubjectName` = 'Advanced Mathematics-2'
)

-- Query students with Advanced Mathematics-2 course and scores not less than 80 points, student number and name
SELECT StudentNo, StudentName
FROM student s
INNER JOIN result r
ON s.StudentNo = r.StudentNo
INNER JOIN `subject` sub
ON r.`SubjectNo` = sub.`SubjectNo`
WHERE `SubjectResult` >= 80 AND `SubjectNo` = (
	SELECT SubjectNo FROM `subject`
    WHERE `SubjectName` = 'Advanced Mathematics-2'
)

-- Refactor, nested usage
SELECT StudentNo, StudentName FROM  student WHERE StudentNo IN (
	SELECT StudentNo FROM result WHERE StudentResult>80 AND SubjectNo = (
    	SELECT SubjectNo FROM `subject` WHERE `SubjectName` = 'Advanced Mathematics-2'
    )
)
```

## Index

### What is an Index

When there are large amounts of records in a table, querying the table, if it's a full table search, all records are retrieved one by one, compared with query conditions, then records satisfying conditions are returned, consuming large amounts of database system time and causing large amounts of disk I/O. The second method is to establish indexes in the table, then find index values matching query conditions in the index, finally quickly find corresponding records in the table through ROWID saved in the index.

Index is a distributed storage structure created to accelerate retrieval of data rows in tables. Rows in index pages have logical pointers.

### Index Advantages and Disadvantages

**Advantages:**

1. Greatly speed up data retrieval
2. Create unique index, ensure uniqueness of each row of data in database
3. Speed up connections between tables
4. When using grouping and sorting for retrieval, can significantly reduce query time

**Disadvantages:**

1. Indexes occupy physical space
2. When adding, deleting, and modifying data in tables, indexes also need dynamic maintenance, reducing data maintenance speed

### Index Types

**Single Column Index**, **Unique Index**, **Primary Key Index** and **Clustered Index**

1. Ordinary index: No uniqueness restriction, allows null. Can create directly create index name on tablename

When modifying table alert table tablename add index name; When creating table create table tablename( ..index name col)

2. Unique index: unique index No two rows have same index value

3. Primary key index: One or more columns in database uniquely identify each row in table, this column is table's primary key. A table can only have one primary key, not allowed to be null, usually created when building table

### Three Ways to Create Index

```sql
# indexName index name  tableName table name  columnName column name   length  limit length
CREATE INDEX indexName ON tableName (columnName(length));

ALTER TABLE tableName ADD INDEX indexName(columnName);

# Create when building table
CREATE TABLE tableName(  
  id INT NOT NULL,   
  columnName  columnType,
  INDEX [indexName] (columnName(length))  
);
```

When using database sometimes need to check how much memory **data** occupies in current table, how much memory **index** occupies:

```sql
select * from `information_schema`.`TABLES` where `TABLE_NAME` = 'tableName';
```

This SQL can query current database instance **target table** information. In this problem we need to focus on fields `DATA_LENGTH` and `INDEX_LENGTH`. Here is the data size and index size we want to see, unit is byte.

## Standardize Database Design

### Why Design is Needed

*When database becomes complex, we need to design database*

Poor database design:

- Data redundancy, waste space
- Database insertion and deletion become troublesome, abnormal [shield using physical foreign keys]
- Poor program performance

Good database design:

- Save memory space
- Ensure database integrity
- Convenient for system development

**In software development, about database design:**

- Analyze requirements: Analyze business and database requirements to be processed
- Outline design: Design relationship E-R diagram

**Database design steps: (personal)**

- Collect information, analyze requirements
  - User table (user login logout, user personal information, write blog, create category)
  - Category table (article category, who created)
  - Article table (article information)
  - Friend link table (friend link information)
  - Custom table (system information, certain key words, or some value fields) key:value
  - Comment table
  - Say table (express mood.. id.. content...)
- Identify entities (refine requirements to)
  - user(id, username, password, sex, age, sign, open_id, avatar)
  - ...
- Identify relationships between entities
  - Write blog: user --> blog
  - Create category: user --> category
  - Follow: user --> user
  - Friend link: links
  - Comment: user-user-blog

### Three Normal Forms

Why need data normalization?

- Information repetition
- Update anomalies
- Insertion anomalies
  - Cannot display information normally
- Deletion anomalies
  - Lose valid information

*Three normal forms (understanding)*

**First Normal Form (1NF)**: Requires each column of database table to be indivisible atomic data items

Atomicity: Ensure each column cannot be further divided

**Second Normal Form (2NF)**: Need to ensure each column in database table is related to primary key, not just part of primary key (mainly for composite primary keys)

Prerequisite: Satisfy first normal form

Each table represents only one thing

**Third Normal Form (3NF)**: Third normal form needs to ensure each column data in data table is directly related to primary key, not indirectly related

Prerequisite: Satisfy second normal form

Third normal form needs to ensure each column data in data table is directly related to primary key, not indirectly related

(Standardize database design)

Normalization and performance issues

Associated query tables should not exceed three tables

- Consider commercial needs and goals, (cost, user experience!) database performance is more important
- When considering normalization and performance issues, need to appropriately consider normalization
- Intentionally add some redundant fields to certain tables (change from multi-table query to single-table query)
- Intentionally add some calculated columns (reduce from large data volume to small data volume query: index)

## JDBC (Key Points)

### Database Driver

Driver: Sound card, graphics card, database

Program operates database through data driver

### JDBC

SUN company to simplify developer (unified database) operations, provided a (JAVA database operations) specification, commonly called JDBC, implementation of these specifications is done by specific vendors, divide functionality, developers learn JDBC operations, vendors implement JDBC database operations (drivers).

java.sql

javax.sql

## Summary

Through this article, we mastered the complete knowledge system of MySQL database:

1. **Basic Concepts**: Database, DBMS, relational and non-relational databases
2. **Installation Configuration**: MySQL installation, SQLyog configuration, connection testing
3. **Data Operations**: DDL, DML, DQL, DCL four languages
4. **Query Optimization**: Join queries, subqueries, index design
5. **Database Design**: Three normal forms, normalization design principles
6. **JDBC Connection**: Bridge between Java programs and databases

MySQL, as a core component of enterprise applications, mastering its complete knowledge system is of great significance for modern software development. In actual development, database structure needs to be reasonably designed according to business requirements, query performance optimized, and data security and integrity ensured.

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
