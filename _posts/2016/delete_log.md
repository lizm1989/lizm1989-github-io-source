title: 日志定时删除
date: 2016-03-24 14:50:31
tags:
	- liunx

categories:
	- IT
---
liunx每天会产生很多日志，备份等，可以让写个sh定时去删，不用担心磁盘不足等。

<pre>
删除1天以前日志。
find /usr/local/tomcat7/logs -ctime +1 -name "localhost_access_log*.txt"| xargs rm -rf

例如今天是：2016-04-24，会保留22号-24号文件

然后写到crontab里，搞定。
</pre>
<!--more-->
<pre>
下面这种写法是一样的
find /usr/local/tomcat7/logs  -mtime +10 -name "catalina*.log" -exec rm -rf {} \;
</pre>



