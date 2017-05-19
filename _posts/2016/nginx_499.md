title: nginx 499错误
date: 2016-04-15 14:50:31
tags:
	- liunx
categories:
	- IT
---
[参考文章](http://www.lc365.net/blog/b/23997/)


###	背景
最近线上老出现nginx 499错误，2台机器，每台将近有1W+,问题是这系统跑的时间不长，就简单查了下。

<!--more-->

###	复现及日志
<pre>
复现方法比较粗暴：浏览器不断F5

127.0.0.1 - - [21/Apr/2016:14:48:16 +0800] "GET /api/test HTTP/1.1" 499 0 "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.94 Safari/537.36" -


发现499错误返回response为0。
</pre>

###	解决办法
<pre>
proxy_ignore_client_abort on;

已上线了，后续观察一段时间

备注：nginx version: nginx/1.6.2
</pre>




