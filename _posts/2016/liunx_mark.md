title: liunx mark
date: 2016-11-09 18:50:31
tags:
	- liunx
categories:
	- IT
---
###	这是一个持续更新的文章，主要记录一些日常使用命令


####	more、less、cat查看命令
<pre>
两个都支持分页查看，但more不支持向后翻页。
所以大家都说"less is more"="少即是多"

less: j-向后 k-向前

echo 显示输入的内容

cat：来显示文件的内容，它直接显示出所有的文件内容


head：显示文件的头几行（默认10行） -n指定行数

tail:显示末尾的几行（默认10行）  -n指定行数


查看文件的完整时间信息：
ls -l
-rw-r--r-- 1 webops operators    9 Jan 11 16:11 xx

ls --full-time
-rw-r--r-- 1 webops operators    7 2017-01-11 18:07:18.000000000 +0800 xx

stat test.txt
</pre>

<!--more-->

####	find
<pre>
格式：find 查找位置 查找参数

从 '/' 开始进入根文件系统搜索文件和目录 
$find / -name file1

查找目录下php后缀文件，切文件包含"include"字符文件
$find /wwwroot/mantis -name '*.php' |xargs  grep "include"

$find / -type f -name "*.log" | xargs grep "PrinterBolt"

</pre>

	
####	查看目录下各级目录大小
<pre>
查看机器磁盘情况：
$df -h

查看具体目录 
$du -h --max-depth=1   /

前15大的文件夹
$du -xB M --max-depth=2 /var | sort -rn | head -n 15

查看目录大小
$du -sh /home/
</pre>

####	清空文件
<pre>
$: > filename
$> filename
$echo "" > filename
$echo /dev/null > filename
$echo > filename
$cat /dev/null > filename
</pre>


####	查询或者删除过期日志
<pre>
查询昨天日志
$find /opt/servicelogs/ -type f  -mtime -1;


删除20天以前日志
$find /opt/servicelogs/ -type f  -mtime +20 -exec rm -f{};
</pre>	

####	查看linux登录记录
<pre>
显示最后登录系统的N条记录
$last -6
</pre>

#### 	自动补全
<pre>
比如当你在同一个文件中第二次输入 “style” 时，
仅仅输入 “st” 然后保持在插入模式，按 Ctrl+n 键就可以看到 Vim 为你补全了单词。
很简单，但也很有用。
超过2个还会有下拉。
</pre>



####	设置信任关系
<pre>
A机器生成公钥/私钥对：
/home/zml/: ssh-keygen -t rsa -P ''

/home/zml/下生成.ssh目录，.ssh下有id_rsa和id_rsa.pub。


登录B机器：
cd /home/zml2/
mkdir .ssh
cd .ssh
scp -P 22 zml@192.168.1.111:/home/zml/.ssh/id_rsa.pub .
cat id_rsa.pub >> authorized_keys
</pre>


####	设置指令别名
<pre>
alias cdd="cd /home/web/dd/"
用cdd取代cd /home/web/dd/

查看alias，列出目前可使用别名。


如需别名永久化，需修改.bashrc

vi .bashrc

alias cdd="cd /home/web/dd/"

然后执行 source .bashrc  重新加载资源。
</pre>	

###		其他
<pre>
uptime，用来查看系统运行了多久，系统的用户，系统的负载


ls --full-time 查看列表详细时间

</pre>

###		压缩解压缩
<pre>
.tar 
打包： tar cvf testfile.tar testfile
解包： tar xvf testfile.tar

</pre>

###		修改hostname永久生效
	>hostname newName #当前有效，服务器重启会生效 
	>vi /etc/sysconfig/network #永久修改，修改HOSTNMAE
	>所以结合上面两种，就可以永久修改。
	>vi /etc/host 修改ip地址对应名称


###		nmap
	>Nmap用于在远程机器上探测网络，执行安全扫描，网络审计和搜寻开放端口。
	>nmap -v -A x.x.x.x -p  1-65535 扫描所有端口


###

	
