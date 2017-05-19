title: SELECT INTO 和 INSERT INTO SELECT 两种表复制语句
date: 2015-11-17 14:50:31
tags:
	- SQL
categories:
	- IT
---
#	前言
我们在开发、测试过程中，经常会遇到需要表复制的情况，如将一个table1的数据的部分字段复制到table2中，或者将整个table1复制到table2中，这时候我们就要使用SELECT INTO 和 INSERT INTO SELECT 表复制语句了。

<!--more-->

##	INSERT INTO SELECT语句
语句形式为：
>Insert into Table2(field1,field2,...) select value1,value2,... from Table1
>
>insert into table2(a, c, d) select a,c,5 from table1

	要求目标表Table2必须存在，由于目标表Table2已经存在，
	所以我们除了插入源表Table1的字段外，还可以插入常量 

##	SELECT INTO FROM语句
语句形式为：
>SELECT vale1, value2 into Table2 from Table1

>select a,c INTO Table2 from Table1

	要求目标表Table2不存在，因为在插入时会自动创建表Table2，
	并将Table1中指定字段数据复制到Table2中