title: 内网穿透神器
date: 2016-09-30 14:50:31
tags:
	- IT
categories:
	- IT
---
#	概要
``` bash
相信做Web开发的同学们，经常会遇到需要将本地部署的Web应用能够让公网环境直接访问到的情况，
例如微信应用调试、支付宝接口调试等。
这个时候，一个叫ngrok的神器可能会帮到你，但国内建议用【qydev】来替代。
它提供了一个能够在公网安全访问内网Web主机的工具，
能捕获所有HTTP请求的内容，也支持TCP端口映射，支持Linux、Windows、Mac OS X 等平台。
```

#	使用方法步骤
使用qydev来做实验，已微信调试为例【XP为例】
<!--more-->
*	下载qydev,命令行进入目录

*	敲入命令： ngrok -config=ngrok.cfg -subdomain x 80 //(xx 是你自定义的域名前缀)
![图片](http://ww2.sinaimg.cn/mw690/69e14ccdjw1f8ahyka537j20k90e6wgv.jpg)

*	支持http、https，还有本地可以监控后台查看请求过来的数据呀，测试起来真是太方便了,亲测有效。
![图片](http://ww3.sinaimg.cn/mw690/69e14ccdjw1f8ahz0gz1lj211s0rtn3a.jpg)	


# 本文参考
``` bash
国外不太稳定：https://ngrok.com/
参考ngrok,国内，稳定【推荐使用】：http://qydev.com/
博客参考：http://www.cnblogs.com/maoniu602/p/5524476.html
```