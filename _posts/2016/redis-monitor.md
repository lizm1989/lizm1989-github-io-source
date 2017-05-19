title: redis监控
date: 2016-03-22 14:50:31
tags:
	- NoSql

categories:
	- IT
---
[Redis性能问题排查解决手册](http://www.cnblogs.com/mushroom/p/4738170.html)

###	info 

<pre>
$redis-cli info

###还可以指定特定返回####
$redis-cli memory 
# Memory
used_memory:815008
used_memory_human:795.91K
used_memory_rss:7135232
used_memory_peak:836760
used_memory_peak_human:817.15K
used_memory_lua:36864
mem_fragmentation_ratio:8.75
mem_allocator:jemalloc-3.6.0
</pre>

<!--more-->

###	monitor
>MONITOR是一个调试命令，返回服务器处理的每一个命令，它能帮助我们了解在数据库上发生了什么操作。共有3种操作方法：
<pre>
$redis-cli -h localhost -p 6380 monitor
</pre>


###	slowlog
>定位到那些超出指定执行时间的慢命令，默认情况下命令若是执行时间超过10ms就会被记录到日志。
<pre>
127.0.0.1:6380> slowlog get
 1) 1) (integer) 111876
    2) (integer) 1458637812
    3) (integer) 11101
    4) 1) "SMEMBERS"
       2) "new_user"
</pre>
图中字段分别意思是：
*	1=日志的唯一标识符
*	2=被记录命令的执行时间点，以 UNIX 时间戳格式表示
*	3=查询执行时间，以微秒为单位。例子中命令使用54毫秒。
*	4= 执行的命令，以数组的形式排列。完整命令是config get *。

###	latency查看延迟时间
<pre>
$redis-cli --latency -p 6380
min: 0, max: 1, avg: 0.10 (102 samples)
以毫秒为单位测量Redis的响应延迟时间，楼主本机的延迟是100μs
</pre>


###	redis-benchmark
<pre>
$redis-benchmark -h 127.0.0.1 -p 6379 -t set,lpush -n 10000 -q
SET: 81967.21 requests per second
LPUSH: 59523.81 requests per second
</pre>
>以上实例中主机为 127.0.0.1，端口号为 6379，执行的命令为 set,lpush，请求数为 10000，通过 -q 参数让结果只显示每秒执行的请求数。


####	redis-stat
[reids-stat github](https://github.com/junegunn/redis-stat)

<pre>
用jar包也可以
$java -jar redis-stat-0.4.12.jar --server localhost:6379
</pre>
[redis-stat-0.4.12.jar](http://yun.baidu.com/share/link?shareid=3973446409&uk=2215382410)
















### redis批量删除
<pre>
批量删除以title为开头的key：
redis-cli keys "title*" | xargs redis-cli del

注意上面这个不会删除带有空格key，有空格可以采用如下做法：
$ redis-cli -p 6380 keys *blac* > black.txt
$ more black.txt 
black 1
black 2 2
$awk '$0="redis-cli -p 6380 del \""$0"\""' black.txt > cmd.txt
$ more cmd.txt 
redis-cli -p 6380 del "black 1"
redis-cli -p 6380 del "black 2 2"

key前后有空格哪种，程序最好trim一下。
</pre>
[空格删除可参考](http://bylijinnan.iteye.com/blog/2198465)




### redis持久化存储
<pre>
2种方式：
RDB:RDB一定时间取存储文件
AOF:AOF默认每秒去存储历史命令
官方建议都开启

RDB默认开启

AOF默认关闭，开启appendonly yes
appendfsync always //立即
appendfsync everysec  //每秒
</pre>





