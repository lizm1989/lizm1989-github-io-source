title: 开通https
date: 2016-05-03 14:50:31
tags:
	- liunx
categories:
	- IT
---
目前越来越多的互联网起来都开始采用https,因为不管是公钥还是私钥都会涉及到泄露的问题。
https结合了加密和性能，总之，https是目前最完善的方案。

所以今天打算亲自试用一下。

<!--more-->


## 首先nginx要支持ssl
nginx需支持ssl,要不然会出现以下错误
<pre>
unknown directive "ssl"
</pre>


安装nginx
<pre>
wget http://nginx.org/download/nginx-0.8.52.tar.gz

tar zxvf nginx-0.8.52.tar.gz

cd nginx-0.8.52

./configure --prefix=/usr/local/nginx-0.8.52 --with-http_stub_status_module --with-http_ssl_module  --with-http_realip_module

make

make install
</pre>


配置nginx
<pre>
server {
        listen       443;
        server_name  localhost;

        ssl                  on;//重点
        ssl_certificate      /usr/local/nginx-0.8.52/1_top100.red_bundle.crt;//重点
        ssl_certificate_key  /usr/local/nginx-0.8.52/2_top100.red.key;//重点

        ssl_session_timeout  5m;


        location / {
            root   html;
            index  index.html index.htm;
        }
    }


配置部分关注重点三行即可
</pre>


## 全站都默认用https
nginx方式将全站http都默认跳转到https，配置如下：
<pre>
server {  
    listen  192.168.1.111:80;  
    server_name test.com;  
      
    rewrite ^(.*)$  https://$host$1 permanent;  
}  
</pre>

如果不将http rewrite到https，以下代码默认是会提交到http的
<pre>
  	< form method="post" action="${ctx}/login">
  		用户名：< input type="text"  name="userName" value=""><br>
  		密码：< input type="password"  name="password" value=""><br/>
  		< input type="submit" value="登录"/>
  	</form>
</pre>


## 最后看访问结果：

![看看](http://ww1.sinaimg.cn/mw690/69e14ccdjw1f3j4678iggj211s04wjss.jpg)





## 申请证书
我用的是wosign.com，之前也申请过startssl。


## 开启https注意事项
Mixed Content，当一个HTTPS页面中包含HTTP内容时，即使主页面是经过SSL加密受HTTPS协议保护，但其中的HTTP内容可以被攻击者阅读或更改；这种HTTPS页面包含HTTP内容的情况，就被称为“混合内容”。

不用浏览器有不同处理规则。




