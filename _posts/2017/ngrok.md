title: ngrok搭建
date: 2017-03-09 18:50:31
---
之前开发微信及第三方支付的时候，都是用国内免费的ngrok服务，如http://www.qydev.org/,
但这个服务由于经常受攻击不太稳定，于是打算自己在服务上搭一个。

<!--more-->

###	ngrok介绍
ngrok 服务可以分配给你一个域名让你本地的web项目提供给外网访问，特别适合向别人展示你本机的web demo 以及调试一些远程的API (比如微信公众号，企业号的开发) 。

###	安装ngrok

#### 安装git
这个不多介绍了，请大家自己搜索。

#### 安装go

	地址：http://www.golangtc.com/download

	版本：http://www.golangtc.com/static/go/1.4.2/go1.4.2.linux-amd64.tar.gz	
<pre>
在/usr/local 解压go安装包
>tar -zxvf go1.4.2.linux-amd64.tar.gz
修改go环境变量
>vi /etc/profile

NGROK_DOMAIN="ngrok.javanull.cn"
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

>source /etc/profile
</pre>

#### 下载ngrok
>cd /home 
>git clone https://github.com/inconshreveable/ngrok.git

修改地址
>vi  /home/ngrok/src/ngrok/log/logger.go

import 有个引用改成： github.com/keepeye/log4go
 
#### 生成证书

<pre>

>cd /home/ngrok

>openssl genrsa -out rootCA.key 2048
>openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
>openssl genrsa -out server.key 2048
>openssl req -new -key server.key -subj "/CN=$NGROK_DOMAIN" -out server.csr
>openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 5000

>cp rootCA.pem assets/client/tls/ngrokroot.crt
>cp server.crt assets/server/tls/snakeoil.crt
>cp server.key assets/server/tls/snakeoil.key

</pre>


#### 交叉编译生成windows客户端

<pre>
>cd /home/ngrok
>GOOS=linux GOARCH=amd64   #32位系统，这里 GOARCH=386  
>make release-server release-client #生成服务端与客户端

>cd  /usr/local/go/src/
>GOOS=windows GOARCH=amd64 CGO_ENABLED=0 ./make.bash  

>cd  /home/ngrok/
>GOOS=windows GOARCH=amd64 make release-server release-client

</pre>

编译之后在/home/ngrok/bin/windows_amd64 目录下有服务端和客户端


#### ngrokd服务启动与使用

<pre>
服务端启动
>/home/ngrok/bin/ngrokd -domain="$NGROK_DOMAIN" -httpAddr=":9000" -httpsAddr=:4430 &

windows使用，找到目录：

ngrok -config=ngrok.cfg -subdomain xxx 8080  
</pre>

#### 安装过程一些错误解决办法

panic: listen tcp :80: bind: address already in use

以上原因是nginx占用了80端口，所以ngrok启动的时候改下端口，如：

/home/ngrok/bin/ngrokd -domain="$NGROK_DOMAIN" -httpAddr=":9000" -httpsAddr=:4430 &

这样改了之后，访问ngrok就需要加端口，可以通过nginx来解决：

<pre>
server {
        listen       80;
        server_name     ~^(?<subdomain>\w+)\.ngrok\.xx\.cn$;
        proxy_set_header "Host" $host:9000;
        location / {         
          proxy_pass_header Server;
          proxy_redirect off;
          proxy_pass http://127.0.0.1:9000;
        }
        access_log logs/ngrok.xx.cn.log main; 
    }

</pre>

###	参考
http://www.qydev.org/



