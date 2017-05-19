title: nginx alias 
date: 2016-07-26 14:50:31
tags:
	- IT
categories:
	- IT
---
###	配置如下
<pre>

autoindex on;
autoindex_exact_size off;
autoindex_localtime on;
location /html {
	alias d:/html/;
}
</pre>




###	[参考](http://www.wkii.org/nginx-set-directory-alias-and-root.html)
