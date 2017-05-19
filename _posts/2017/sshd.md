title: sshd被爆破了
date: 2017-03-14 18:50:31
---
###	sshd被爆破了
新开的服务器，看了流量图发现流量不少，不应该，因为这是新开的机器，什么都没部署，就实验了几个东西在上面，看了下日志，是sshd被爆破了。
<!--more-->
###	安全组
如果是阿里云的经典网络，建议把安全组配置，端口和IP尽量都少开。

root密码设置复杂点，勤修改密码。改下/etc/login.defs
<pre>
#密码设置最小长度
PASS_MIN_LEN 12 

#表示在口令到期前多少天开始通知用户口令即将到期
PASS_WARN_AGE 30

#密码有效期天数(指定天数后密码需要强制过期)	
PASS_MAX_DAYS 90
</pre>

###	sshd被爆破了日志
<pre>
more /var/log/secure

Mar 12 04:56:18 iZ25qy3yxgbZ sshd[20744]: Did not receive identification string from 59.110.6.177
Mar 12 08:03:54 iZ25qy3yxgbZ sshd[26567]: Accepted password for root from 118.247.16.226 port 51270 ssh2
Mar 12 08:03:54 iZ25qy3yxgbZ sshd[26567]: pam_unix(sshd:session): session opened for user root by (uid=0)
Mar 12 10:35:43 iZ25qy3yxgbZ sshd[31793]: Connection closed by 81.130.146.18
Mar 12 11:22:25 iZ25qy3yxgbZ sshd[931]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=121.196.206.64  user=root
Mar 12 11:22:27 iZ25qy3yxgbZ sshd[931]: Failed password for root from 121.196.206.64 port 4920 ssh2
Mar 12 11:22:30 iZ25qy3yxgbZ sshd[931]: Failed password for root from 121.196.206.64 port 4920 ssh2
Mar 12 11:22:32 iZ25qy3yxgbZ sshd[931]: Failed password for root from 121.196.206.64 port 4920 ssh2
Mar 12 11:22:34 iZ25qy3yxgbZ sshd[931]: Failed password for root from 121.196.206.64 port 4920 ssh2
Mar 12 11:22:36 iZ25qy3yxgbZ sshd[931]: Failed password for root from 121.196.206.64 port 4920 ssh2
Mar 12 11:22:36 iZ25qy3yxgbZ sshd[932]: fatal: Read from socket failed: Connection reset by peer
Mar 12 11:22:36 iZ25qy3yxgbZ sshd[931]: PAM 4 more authentication failures; logname= uid=0 euid=0 tty=ssh ruser= rhost=121.196.206.64  user=root
Mar 12 11:22:36 iZ25qy3yxgbZ sshd[931]: PAM service(sshd) ignoring max retries; 5 > 3
Mar 12 11:22:36 iZ25qy3yxgbZ sshd[939]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=121.196.206.64  user=root
Mar 12 11:22:38 iZ25qy3yxgbZ sshd[939]: Failed password for root from 121.196.206.64 port 2252 ssh2
Mar 12 11:22:38 iZ25qy3yxgbZ sshd[940]: fatal: Read from socket failed: Connection reset by peer
Mar 12 11:54:57 iZ25qy3yxgbZ sshd[2069]: fatal: Read from socket failed: Connection reset by peer
Mar 12 13:16:35 iZ25qy3yxgbZ sshd[5220]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=183.206.168.165  user=root
Mar 12 13:16:37 iZ25qy3yxgbZ sshd[5220]: Failed password for root from 183.206.168.165 port 64218 ssh2
Mar 12 13:16:43 iZ25qy3yxgbZ sshd[5220]: Failed password for root from 183.206.168.165 port 64218 ssh2
Mar 12 13:16:46 iZ25qy3yxgbZ sshd[5220]: Failed password for root from 183.206.168.165 port 64218 ssh2
Mar 12 13:45:37 iZ25qy3yxgbZ sshd[6468]: Accepted password for root from 118.247.16.226 port 64400 ssh2
Mar 12 13:45:37 iZ25qy3yxgbZ sshd[6468]: pam_unix(sshd:session): session opened for user root by (uid=0)
Mar 12 13:57:33 iZ25qy3yxgbZ sshd[6988]: Accepted password for root from 118.247.16.226 port 65210 ssh2
Mar 12 13:57:33 iZ25qy3yxgbZ sshd[6988]: pam_unix(sshd:session): session opened for user root by (uid=0)
Mar 12 13:57:33 iZ25qy3yxgbZ sshd[6988]: subsystem request for sftp
Mar 12 13:58:01 iZ25qy3yxgbZ sshd[6988]: subsystem request for sftp
Mar 12 13:58:01 iZ25qy3yxgbZ sshd[6988]: subsystem request for sftp
Mar 12 14:05:22 iZ25qy3yxgbZ sshd[26567]: pam_unix(sshd:session): session closed for user root
Mar 12 14:05:55 iZ25qy3yxgbZ sshd[7414]: Accepted password for root from 118.247.16.226 port 49488 ssh2
Mar 12 14:05:55 iZ25qy3yxgbZ sshd[7414]: pam_unix(sshd:session): session opened for user root by (uid=0)

</pre>


###	Denyhosts
Denyhosts 主要根据系统日志文件/var/log/secure文件分析，当发现同一IP在进行多次SSH密码尝试时就会记录IP到/etc/hosts.deny文件，从而达到自动屏蔽该IP的目的。


###	安装部署
[http://www.cnblogs.com/rwxwsblog/p/4590608.html](http://www.cnblogs.com/rwxwsblog/p/4590608.html "linux防止sshd被爆破(安装denyhosts)")
