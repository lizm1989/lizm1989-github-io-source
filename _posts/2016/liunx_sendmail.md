title: 利用sendmail来发送邮件
date: 2016-05-20 14:50:31
tags:
	- liunx
categories:
	- IT
---

liunx默认是不能发送邮件的，需要发送邮件要先安装一个sendmail服务，还有一种是mstmp来发。
今天咱们用sendmail来发送邮件。

<!--more-->

##	yum安装sendmail

<pre>
>yum -y install sendmail  ##这是安装

>service sendmail start  ##这是启动

>ps -ef|grep sendmail  
</pre>


##	测试一下发送

/bin/mail -s "这是标题" "3308811@qq.com" < 111.txt

111.txt文件

	111是邮件内容