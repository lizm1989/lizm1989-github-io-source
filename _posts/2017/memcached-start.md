title: memcached启动脚本
date: 2017-02-17 18:50:31
---
#	常规启动
	>/usr/local/memcached/memcached -d -m 100m -p 11211 -u root  
	
#	配置脚本启动
<pre>
安装路径：/usr/local/memcached 
把memcached脚本文件放在 /etc/rc.d/init.d/ 目录下,脚本在最下面
</pre>

<!--more-->
<pre>
增加服务并开机启动
# touch /etc/rc.d/init.d/memcached
# chmod +x /etc/rc.d/init.d/memcached
# chkconfig --add memcached
# chkconfig --level 345 memcached on
# chkconfig --list memcached
</pre>

<pre>
#!/bin/bash
# memcached  - This shell script takes care of starting and stopping memcached.
#
# chkconfig: - 90 10
# description: Memcache provides fast memory based storage.
# processname: memcached


memcached_path="/usr/local/memcached/memcached"
memcached_pid="/var/run/memcached.pid"
memcached_memory="100"


# Source function library.
. /etc/rc.d/init.d/functions


[ -x $memcached_path ] || exit 0


RETVAL=0
prog="memcached"


# Start daemons.
start() {
	if [ -e $memcached_pid -a ! -z $memcached_pid ];then
		echo $prog" already running...."
		exit 1
	fi


	echo -n $"Starting $prog "
	# Single instance for all caches
	$memcached_path -m $memcached_memory -l 0.0.0.0 -p 11211 -u root -d -P $memcached_pid
	RETVAL=$?
	[ $RETVAL -eq 0 ] && {
		touch /var/lock/subsys/$prog
		success $"$prog"
	}
	echo
	return $RETVAL
}




# Stop daemons.
stop() {
	echo -n $"Stopping $prog "
	killproc -d 10 $memcached_path
	echo
	[ $RETVAL = 0 ] && rm -f $memcached_pid /var/lock/subsys/$prog


	RETVAL=$?
	return $RETVAL
}


# See how we were called.
case "$1" in
		start)
			start
			;;
		stop)
			stop
			;;
		status)
			status $prog
			RETVAL=$?
			;;
		restart)
			stop
			start
			;;
		*)
			echo $"Usage: $0 {start|stop|status|restart}"
			exit 1
esac
exit $RETVAL
</pre>



