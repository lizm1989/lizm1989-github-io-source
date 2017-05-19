title: 新机器安装服务
date: 2017-02-11 14:50:31
tags:
	- liunx
	- IT
categories:
	- IT
---
#	概述
本文安装jdk、memcached、redis、msqyl、nginx[openresty]、node、
hexo、git

还有一些其他命令的安装
	
<!--more-->
#	基础
   1. 本文基于阿里，以下安装
   2. 下载时参考国内镜像站：
	`
    1.	搜狐：http://mirrors.sohu.com/
	2.	网易：http://mirrors.163.com/
	3.	阿里云：http://mirrors.aliyun.com/
	`
   3. 
#	安装telnet
   1. 查询是否有telnet相关的rpm安装包：
  	
	> rpm -qa | grep telnet
   2. 
   	> yum list |grep telnet
   	<pre>
		dcap-tunnel-telnet.x86_64                   2.47.10-5.el6                epel   
		libguac-client-telnet.i686                  1:0.9.9-3.el6                epel   
		libguac-client-telnet.x86_64                1:0.9.9-3.el6                epel   
		libtelnet.i686                              0.20-2.el6                   epel   
		libtelnet.x86_64                            0.20-2.el6                   epel   
		libtelnet-devel.i686                        0.20-2.el6                   epel   
		libtelnet-devel.x86_64                      0.20-2.el6                   epel   
		libtelnet-utils.x86_64                      0.20-2.el6                   epel   
		telnet.x86_64                               1:0.17-48.el6                base   
		telnet-server.x86_64                        1:0.17-48.el6                base  
	</pre>

   3. 安装客户端
   	> yum install telnet.x86_64 
   4. 安装服务端
   	>yum install telnet-server.x86_64 
   5. 再查看安装情况
  	 <pre>
			[root@iZ2zeh4a3tctqaxi3lfmfpZ ~]# rpm -qa |grep telnet
			libtelnet-0.20-2.el6.x86_64
			libguac-client-telnet-0.9.9-3.el6.x86_64
			telnet-server-0.17-48.el6.x86_64
		</pre>

   6.	修改telnet 
   	>vi /etc/xinetd.d/telnet,将disable值赋为no
   7.	开启telent服务	
    >service xinetd restart
#	安装JDK
1.	下载jdk1.8：
     >wget http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz

	jdk历史版本：
	http://www.oracle.com/technetwork/java/javase/archive-139210.html``

2.	解压及软链接
	
    >tar -zxvf jdk-8u121-linux-x64.tar.gz
    >
    >ln -s jdk1.8.0_121 jdk

3.	添加环境变量及验证
编辑/etc/profile文件，在export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL下面添加如下代码：
	#jdk
	>vi /etc/profile
	>
	>export JAVA_HOME=/usr/local/jdk
	>
	>export PATH=$JAVA_HOME/bin:$PATH
	>
    >export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
    >
	>source /etc/profile    
    
	
#	安装memcached
1.	安装依赖

	>wget http://www.monkey.org/~provos/libevent-1.4.12-stable.tar.gz  
	>
	>tar -zxvf libevent-1.4.12-stable.tar.gz
	>
	>tar zxvf libevent-1.4.12-stable.tar.gz -C /usr/local/  
	>
	>cd libevent-1.4.12-stable/  
	>
	>./configure -prefix=/usr/libevent 
	>
	>make 
	>
	>make install

2.	下载
	
	>wget http://www.memcached.org/files/memcached-1.4.34.tar.gz
	>
	>tar -zxvf memcached-1.4.34.tar.gz
	>
	>ln -s memcached-1.4.34 memcached
	>
	>cd memcached
	>
	>./configure -prefix=/usr/libevent 
	>
	>make
	>
	>make insatll

3.	启动
	
	>/usr/local/memcached/memcached -d -m 100m -p 11211 -u root  
#	安装redis
1.	下载、解压、软链接、安装

	>wget http://download.redis.io/releases/redis-3.2.8.tar.gz
    >
    >tar -zxvf redis-3.2.8.tar.gz
    >>
    >ln -s redis-3.2.8 redis
	>make
	>mkdir redisdata #存放日志及数据文件
2.	启动及修改配置
	
	>cp /usr/local/redis/redis.conf redis_6380.conf  #配置文件拷贝
	>
	>port 6379 #修改端口
	>
	>logfile "/usr/local/redis/redisdata/redis_6380.log" #修改日志地址
	>
	>pidfile /var/run/redis_6380.pid #pid文件
	>
	>dbfilename dump_6380.rdb #rdb文件名称
	>
	>dir /usr/local/redis/redisdata/ #rdb文件地址
	>daemonize  yes #后台运行方式
	>
	>/usr/local/redis/src/redis-server /usr/local/redis/redis_6380.conf & #启动
	>
	>cp src/redis-cli /usr/local/bin/
	>
	>cp src/redis-cli /usr/local/bin/
3.	修改环境变量
<pre>
vi /etc/profile

#redis
export REDIS_HOME=/usr/local/redis
export PATH=$REDIS_HOME/src:$PATH


source /etc/profile
</pre>	


#	安装mysql
1.	下载

	>wget http://mirrors.sohu.com/mysql/MySQL-5.7/mysql-5.7.16-linux-glibc2.5-x86_64.tar.gz

2.	解压及软链接

	>tar -zxvf mysql-5.7.16-linux-glibc2.5-x86_64.tar.gz
	>
	>ln -s mysql-5.7.16-linux-glibc2.5-x86_64 mysql

3.	 创建mysql用户和组
	
	>groupadd mysql
	>
	>useradd -g mysql mysql
	
4.	进入mysql
	
	>cd /usr/local/mysql
	>
	>mkdir /usr/local/mysql/data3306
	>
	>mkdir /usr/local/mysql/data3306/data
	>
	>拷贝配置文件
	>
	>cp /usr/local/mysql/support-files/my-default.cnf /usr/local/mysql/data3306/my_3306.cnf
	>
	>vi /usr/local/mysql/data/mysql3306/my.cnf
	>   basedir = /usr/local/mysql
	>   datadir = /usr/local/mysql/data3306/data
	>   port = 3306
	>   
	>   [mysqld]
	>   skip-name-resolve
	>   explicit_defaults_for_timestamp=true
	

5.	初始化mysql，最后有密码显示
	
	>bin/mysqld --defaults-file=/usr/local/mysql/data3306/my_3306.cnf --initialize
6.	修改初始密码
	
	>./bin/mysqladmin -uroot -p password
	
7.	启动mysql
	
	>bin/mysqld --defaults-file=/usr/local/mysql/data3306/my_3306.cnf --user=mysql
8.	添加到环境变量
	
    >export PATH=$PATH:/usr/local/mysql/bin/

#	安装nginx
1. 我用的是openresty,下载/usr/local:
   
    >wget https://openresty.org/download/openresty-1.11.2.2.tar.gz

2. 解压
	
    >tar -zxvf openresty-1.11.2.2.tar.gz
    >
    >ln -s openresty-1.11.2.2 openresty
3. 安装依赖
	
	>yum install readline-devel pcre-devel openssl-devel gcc

4.	安装及启动
	
	>./configure --prefix=/usr/local/openresty/nginx
	>
	>make
	> 
	>sudo make install
	>
	>/usr/local/openresty/nginx/nginx/sbin/nginx
	
#	安装git
 	安装依赖
	>sudo yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker
	>wget https://github.com/git/git/archive/v2.3.0.zip
	>unzip v2.3.0.zip
	>cd git-2.3.0
	>make prefix=/usr/local/git all
	>sudo make prefix=/usr/local/git install
	>vi /etc/profile
	>export PATH=/usr/local/git/bin:$PATH
	>source /etc/profile
	
	设置git
	>git config --global user.name "lizm1989"
	>git config --global user.email "lizm1989@163.com"
	>ssh-keygen -t rsa -C "lizm1989@163.com"

	可参考文章：http://www.cnblogs.com/zhcncn/p/4030078.html

#	安装nodejs
	>wget https://nodejs.org/download/release/v5.0.0/node-v5.0.0-linux-x64.tar.gz
	>tar -zxvf node-v5.0.0-linux-x64.tar.gz 
	>cd node-v5.0.0-linux-x64
	>ln -s /usr/local/node-v5.0.0-linux-x64/bin/node /usr/local/bin/node
  	>ln -s /usr/local/node-v5.0.0-linux-x64/bin/npm /usr/local/bin/npm 

#	安装hexo
	>sudo npm install -g hexo
	>hexo init
	>主题：https://github.com/litten/hexo-theme-yilia
	>参考：http://www.jianshu.com/p/465830080ea9

#	gcc升级，下载目录：http://ftp.gnu.org/gnu/gcc/
	1. 下载gcc高级版本，以升级4.9.5为例。
		> gcc -v
		> wget http://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2
        > tar -jxvf gcc-4.9.4.tar.bz2
	2.	下载编译所需依赖库
	    > cd gcc-4.9.4
	    > ./contrib/download_prerequisites
	    > cd ..
	3.	编译目录
		> mkdir gcc-build-4.9.4
		> cd gcc-build-4.9.4
		> ../gcc-4.9.4/configure --enable-checking=release --enable-languages=c,c++ --disable-multilib
	4.	编译及安装
		> make -j4 
		> make install

	5.	参考：http://www.mudbest.com/centos%E5%8D%87%E7%BA%A7gcc4-4-7%E5%8D%87%E7%BA%A7gcc4-8%E6%89%8B%E8%AE%B0/
	


#	安装updatedb
<pre>
>udpatedb
-bash: udpatedb: command not found
>yum install mlocate
>udpatedb
>locate sz #搜索sz
</pre>

#	安装sz、rz
	1.	>yum list | grep lrzsz
	2.	>yum install lrzsz
#	更新yum 
	1.	>yum update
	2.	>yum list |grep lrzsz

#	搭建ngrok
	http://www.sunnyos.com/article-show-48.html
	http://www.tuicool.com/articles/ZraURrq


