title: 常用JS
date: 2015-12-09 14:50:31
tags:
	- JS
categories:
	- IT
---
##	JS判断是否是微信客户端打开网页
<pre>
function is_weixn(){
    var ua = navigator.userAgent.toLowerCase();
    if(ua.match(/MicroMessenger/i)=="micromessenger") {
        return true;
    } else {
        return false;
    }
}
</pre>

<!--more-->

##	ajax跨域请求
<pre>
在Controller里面与客户端约定好一个callback的命名。如下面的return中querycallback。


//java 
return "querycallback([" + binder.toJson(resultObjectMsg) + "])";

//js
function queryScoreByAvg(param) {
    $.ajax({
        url: "xxxx",
        type: "post",
        async: false,
        data: "param=" + param,
        dataType: "jsonp",
        jsonpCallback: "querycallback",
        success: function (req) {
            //body
        },
        error: function () {
            alert("error message");
            return;
        }
    });
}

这个querycallback的命名在一个页面中，不能有两个相同的callback命名。否则两个接口返回值会错乱

</pre>