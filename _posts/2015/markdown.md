title: markdown学习
date: 2015-11-17 14:50:31
tags:
	- markdown
categories:
	- 工具
---
#	设置标题
#	一级标题
#	一级标题
##	二级标题
###	三级标题
####	四级标题
标题是每篇文章都需要也是最常用的格式，在 Markdown 中，如果一段文字被定义为标题，只要在这段文字前加 【#】 号即可，【#】号个数决定标题的级别，最多支持6个。

<!--more-->
<pre>
#	一级标题
#	一级标题
##	二级标题
###	三级标题
####	四级标题
</pre>
#	斜体

*斜体*


在想要变斜体的文字两旁各加一个【*】号。
<pre>
*斜体*
</pre>
#	加粗

**粗体**

在想要加粗体的文字两旁各加两个【*】号。

如果想要粗体和斜体并存，就两旁加三个【*】号

***粗体斜体***
<pre>
**粗体**

***粗体斜体***
</pre>
#	引用

>下面这句话就是引用

开头加一个大于号「>」即可。
<pre>
>下面这句话就是引用
</pre>


>第一个引用
>>第二个引用套用
>>>第三个引用套用

<pre>
>第一个引用
>>第二个引用套用
>>>第三个引用套用
</pre>

#	列表

列表分有序和无序。

无序列表只需要在列表项加一个【-】或【*】或【+】。
有序列表，一个数字加一个英文句号【.】就可以搞定。


**来列举列表的使用**

-	每周工作5天
-	每天工作8小时
-	每小时60分钟
	1.	1分钟60秒
	2.	每秒可以做什么
	3.	。。。。。
-	这是需要做什么呢。


<pre>
**来列举列表的使用**

-	每周工作5天
-	每天工作8小时
-	每小时60分钟
	1.	1分钟60秒
	2.	每秒可以做什么
	3.	。。。。。
-	这是需要做什么呢。
</pre>




#	图片与链接
链接为[Joyme](http://www.joyme.com)
图片![Joyme](http://tp2.sinaimg.cn/1776372941/180/1283589496/1)

<pre>
链接为[Joyme](http://www.joyme.com)
图片![Joyme](http://tp2.sinaimg.cn/1776372941/180/1283589496/1)
</pre>



#	代码框
>使用 tab 键即可缩进。

	String str="this is string";


