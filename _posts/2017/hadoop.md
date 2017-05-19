title: hadoop安装
date: 2017-02-08
tags:
	- liunx
---
#	安装JDK,并设置环境变量
<pre>
添加jdk环境变量 vi /etc/profile
JAVA_HOME=/opt/jdk
CLASSPATH=$JAVA_HOME/lib/
PATH=$PATH:$JAVA_HOME/bin
export PATH JAVA_HOME CLASSPATH

最后source /etc/profile
</pre>
<!--more-->
#	下载及安装hadoop
<pre>
wget https://dist.apache.org/repos/dist/release/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz

用的是1.2版本


添加hadoop环境变量
HADOOP_HOME=/opt/hadoop
PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin
export PATH JAVA_HOME CLASSPATH
</pre>

#	修改hadoop配置
<pre>
1、修改/opt/haddoop/conf/hadoop-env.sh下jdk安装目录
# The java implementation to use.  Required.
export JAVA_HOME=/opt/jdk

修改/opt/haddoop/conf/hadoop-env.sh下jdk安装目录    
</pre>

	2、修改/opt/haddoop/conf/core-site.xml
    <property>  
    	<name>fs.default.name</name>  
   		<value>hdfs://localhost:9000</value>  
    </property>  
    <property>
    	<name>hadoop.tmp.dir</name>
    	<value>/home/hadoop</value>
    </property>
    <property>
     	<name>dfs.name.dir</name>
    	<value>/home/hadoop/name</value>
    </property>

	3、修改/opt/haddoop/conf/hdfs-site.xml
	 <property>
    	<name>dfs.data.dir</name>  
    	<value>/home/hadoop/data</value>  
 	 </property>
	
	4、修改/opt/haddoop/conf/mapred-site.xml
    <property>
         <name>mapred.job.tracker</name>
         <value>hdfs://localhost:9001</value>
     </property>


#	执行hadoop namenode -format 格式化
#	启动hadoop /opt/hadoop/bin/start-all.sh
<pre>
jps 查看进行进程，会看到以下进程，就说明成功启动hadoop

[root@iZ2zeh4a3tctqaxi3lfmfpZ conf]# jps
12224 JobTracker
11870 NameNode
12536 Jps
12141 SecondaryNameNode
12010 DataNode
12360 TaskTracker


</pre>

# hdfs
<pre>

</pre>