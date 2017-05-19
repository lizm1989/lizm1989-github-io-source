title: js获取微信openid
date: 2016-09-06 11:50:31
tags:
	- IT
categories:
	- IT
---
##	目前状态
	最近在做微信的一些活动，流程大致是：
	前端给页面，后台开发接口然后根据页面套业务逻辑。
	效率不高，主要有2个原因：
	1、前端页面逻辑较复杂，开发拿到后需要理解一些里面的页面逻辑，比较耗时。
	2、活动周期短、接口都很简单。
	
##	解决办法
	开发提供接口业务逻辑接口，前端直接套
    这里就涉及到要拿唯一的openid，【即js获取openid】。

<!--more-->

##	直接上代码，一看就明白

	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>测试网页获取openid</title>
		  <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
		<script src="http://static.joyme.com/js/jquery-1.9.1.min.js" language="javascript"></script>
		<link rel="stylesheet" href="https://res.wx.qq.com/open/libs/weui/0.4.3/weui.min.css" />
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script>
			
			/**
			 * 获取url中"?"符后的字符串并正则匹配
			 * 如：http://xxx.xx.xx?code=aaaa，返回aaaa
			 * @param {Object} name
			 */
			function GetQueryString(name) {
				var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
				var r = window.location.search.substr(1).match(reg);
				var context = "";
				if(r != null)
					context = r[2];
				reg = null;
				r = null;
				return context == null || context == "" || context == "undefined" ? "" : context;
			}

			$(function() {
			    //这里需要注意账号权限的问题，看是否有网页授权，本例子的权限是：服务号
				//获取微信授权code，可查看文档:微信网页开发--->微信网页授权,appid请修改成自己的
				var access_code = GetQueryString('code');

				if(access_code == null) {
					//fromurl 需要urlencode编码处理
					var fromurl = location.href;
					var url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=xxxxx&redirect_uri=' + encodeURIComponent(fromurl) + '&response_type=code&scope=snsapi_base&state=STATE%23wechat_redirect&connect_redirect=1#wechat_redirect';
					//打开微信授权页面
					location.href = url;
				} else {
					$.ajax({
						type: 'get',
						//url会拿到微信给的授权code，有授权code就可以获得用户信息，
						url: 'http://xxx.xx.com/wxinfo.do',
						data: {
							code: access_code,
							wxhref: location.href
						},
						dataType: 'jsonp',
						jsonpCallback: 'wxinfo',
						success: function(req) {
							//接口返回的数据
							console.log(req);
						}
					});
				}

			});
		</script>
	</head>

	<body>
		
	</body>


	</html>

