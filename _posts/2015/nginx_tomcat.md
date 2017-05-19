title: nginx和tomcat调优
date: 2015-12-09 15:50:31
tags:
	- SERVER
categories:
	- IT
---
## nginx和tomcat调优

###	nginx
	
	设置nginx工作进程数：根据cput的核数，如果是8核要设置成8，再高时不会提高性能的 。
	#the processes
	worker_processes  8;
	worker_cpu_affinity 00000001 00000010 00000100 00001000 00010000 00100000 01000000 10000000;


<!--more-->

<pre>
设置keep-alive的timeout，如果设置过短会有大量502，499.
 keepalive_timeout  1800;
</pre>


<pre>
设置headerbuffer，请求头部过小会出现414
client_header_buffer_size       256k;
large_client_header_buffers     32 64k;
</pre>

<pre>
设置client_max_body_size（请求体的大小）,过小会出现413
client_max_body_size            8m;
</pre>

<pre>
优化location中得proxy参数，避免499错误
proxy_connect_timeout    60s;//设置与upstream server的连接超时时间
proxy_send_timeout       60s; //这个指定设置了发送请求给upstream服务器的超时时间

//该指令设置与代理服务器的读超时时间。它决定了nginx会等待多长时间来获得请求的响应;
proxy_read_timeout       60s; 

proxy_buffer_size             256k;//缓存proxy的响应
proxy_buffers            32 64k; //缓存proxy的响应
</pre>


#### tomcat
<pre>
修改server.xml的参数：增加maxThreads, minSpareThreads, acceptCount, connectionTimeout值.会比默认值有显著提高
maxThreads：tomcat起动的最大线程数，即同时处理的任务个数，默认值为200
acceptCount：当tomcat起动的线程数达到最大时，接受排队的请求个数，默认值为100
minSpareThreads：初始化时候的线程数
enableLookups：是否反查域名，提高性能应设置false

<Connector port="48080" protocol="HTTP/1.1"
maxThreads="2000" minSpareThreads="128" acceptCount="1000" connectionTimeout="20000"
enableLookups="false"  redirectPort="48443" URIEncoding="utf-8" />

</pre>

