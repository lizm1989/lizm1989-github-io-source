title: memcached安装及简单实用
date: 2016-04-29 11:09:31
tags:
	- liunx
categories:
	- IT
---
###	简单说明
最近没事想安装个memcached新版本试试，就顺便把安装的步骤也记录下来。
另外说明下memcached 1.4.23，安装成功使用没问题，但是命令stats死活就是没东西出来。
测试2次都一样结果，最后安装的是1.4.24版本。

<!--more-->

###	安装
<pre>
1、下载软件memcached和libevent
   memcached下载地址：wget http://www.memcached.org/files/memcached-1.4.24.tar.gz
   libevent下载地址：wget https://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz
2、安装libevent
   tar -zxf libevent-2.0.22-stable.tar.gz
   ./configure --prefix=/opt/local/libevent
   make
   make install
3、安装memcached
   tar -zxf memcached-1.4.23.tar.gz
   ln -s memcached-1.4.23 memcached
   ./configure --prefix=/usr/local/memcached --with-libevent=/opt/local/libevent/
   make
   make install
4、启动memcached
   /opt/local/memcached/bin/memcached -d -m 128 -u root -p 11211 -c 1024 -P /opt/local/memcached.pid

   如果需要查看日志：
/opt/local/memcached/bin/memcached -d -m 2048 -u root -p 11211 -c 1024 -P /opt/local/memcached.pid -vv >> /opt/log/memcached.log 2>&1

如果需要更详细的日志可用:  -vvv

启动参数说明：
-d 选项是启动一个守护进程。
-u root 表示启动memcached的用户为root。
-m 是分配给Memcache使用的内存数量，单位是MB，默认64MB。
-M return error on memory exhausted (rather than removing items)。
-u 是运行Memcache的用户，如果当前为root 的话，需要使用此参数指定用户。
-p 是设置Memcache的TCP监听的端口，最好是1024以上的端口。
-c 选项是最大运行的并发连接数，默认是1024。
-P 是设置保存Memcache的pid文件

5、将启动命令加入到/etc/rc.local中
</pre>

###	使用
*	set get 
<pre>
set <key> <flags> <exptime> <bytes>
exptime中0表示永久

>
set testkey 0 0 8
test1111
STORED
get testkey
VALUE testkey 0 8
test1111
END

</pre>
*	stats
<pre>
stats
STAT pid 28500
STAT uptime 7
STAT time 1461900009
STAT version 1.4.24
STAT libevent 2.0.21-stable
STAT pointer_size 64
STAT rusage_user 0.000000
STAT rusage_system 0.000999
STAT curr_connections 5
STAT total_connections 6
STAT connection_structures 6
STAT reserved_fds 20
STAT cmd_get 0
STAT cmd_set 0
STAT cmd_flush 0
STAT cmd_touch 0
STAT get_hits 0
STAT get_misses 0
STAT delete_misses 0
STAT delete_hits 0
STAT incr_misses 0
STAT incr_hits 0
STAT decr_misses 0
STAT decr_hits 0
STAT cas_misses 0
STAT cas_hits 0
STAT cas_badval 0
STAT touch_hits 0
STAT touch_misses 0
STAT auth_cmds 0
STAT auth_errors 0
STAT bytes_read 7
STAT bytes_written 0
STAT limit_maxbytes 134217728
STAT accepting_conns 1
STAT listen_disabled_num 0
STAT threads 4
STAT conn_yields 0
STAT hash_power_level 16
STAT hash_bytes 524288
STAT hash_is_expanding 0
STAT malloc_fails 0
STAT bytes 0
STAT curr_items 0
STAT total_items 0
STAT expired_unfetched 0
STAT evicted_unfetched 0
STAT evictions 0
STAT reclaimed 0
STAT crawler_reclaimed 0
STAT crawler_items_checked 0
STAT lrutail_reflocked 0
END
</pre>
