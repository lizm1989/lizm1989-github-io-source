title: 查看服务器mongodb版本、32位或者64位
date: 2016-07-25 14:50:31
tags:
	- NoSql
categories:
	- IT
---
##	第一步连接mongo服务
<pre>

$ /usr/local/mongodb/bin/mongo --port 4066

</pre>


##	运行命令
<pre>
1、 use admin;
2、 db.runCommand("buildInfo")


mongos> use admin;
switched to db admin
mongos> db.runCommand("buildInfo")
{
	"version" : "3.0.2",
	"gitVersion" : "6201872043ecbbc0a4cc169b5482dcf385fc464f",
	"OpenSSLVersion" : "",
	"sysInfo" : "Linux build6.nj1.10gen.cc 2.6.32-431.3.1.el6.x86_64 #1 SMP Fri Jan 3 21:39:27 UTC 2014 x86_64 BOOST_LIB_VERSION=1_49",
	"loaderFlags" : "-fPIC -pthread -Wl,-z,now -rdynamic",
	"compilerFlags" : "-Wnon-virtual-dtor -Woverloaded-virtual -std=c++11 -fPIC -fno-strict-aliasing -ggdb -pthread -Wall -Wsign-compare -Wno-unknown-pragmas -Winvalid-pch -pipe -Werror -O3 -Wno-unused-local-typedefs -Wno-unused-function -Wno-deprecated-declarations -Wno-unused-but-set-variable -Wno-missing-braces -fno-builtin-memcmp -std=c99",
	"allocator" : "tcmalloc",
	"versionArray" : [
		3,
		0,
		2,
		0
	],
	"javascriptEngine" : "V8",
	"bits" : 64,
	"debug" : false,
	"maxBsonObjectSize" : 16777216,
	"ok" : 1
}
</pre>