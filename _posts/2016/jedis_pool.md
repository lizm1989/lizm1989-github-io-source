title: jedis 2.1版本连接池问题
date: 2016-04-22 19:50:31
tags:
	- NoSql
categories:
	- IT
---
[参考文章github](https://github.com/xetorthio/jedis/issues/186)


###	背景
Redis上线都好久，最近一段时间时不时就蹦出一些错误出来，让人很心烦。
错误如下：
<pre>
java.lang.ClassCastException: java.lang.Long cannot be cast to [B
        at redis.clients.jedis.Connection.getBinaryBulkReply(Connection.java:182)
        at redis.clients.jedis.Connection.getBulkReply(Connection.java:171)
        at redis.clients.jedis.Jedis.get(Jedis.java:67

java.lang.ClassCastException: java.lang.Long cannot be cast to [B
        at redis.clients.jedis.Connection.getBinaryBulkReply(Connection.java:182)
        at redis.clients.jedis.Connection.getBulkReply(Connection.java:171)
        at redis.clients.jedis.Jedis.get(Jedis.java:67
</pre>
<!--more-->

###	解决办法

<pre>
1、查询发现是jedis连接池的问题，果断拿个测试环境跑下看看，结果真是坑呀，具体可看文字开头参考文章。


2、果断升级jedis版本至2.7，升级jedis版本需要依赖commons-pool2-2.2包	

3、proxy_ignore_client_abort on;

备注：nginx version: nginx/1.6.2
</pre>

###	jedis2.1和jedis2.7版本差异
<pre>
jedis2.1
JedisPoolConfig poolConfig = new JedisPoolConfig();
poolConfig.setMaxActive(maxActive);
poolConfig.setMaxIdle(maxIdel);
poolConfig.setMaxWait(maxWait);


jedis2.7
JedisPoolConfig poolConfig = new JedisPoolConfig();
poolConfig.setMaxTotal(maxActive);
poolConfig.setMaxIdle(maxIdel);
poolConfig.setMaxWaitMillis(maxWait);

备注：其实开始选的jedis升级版本是2.8，后来发现2.8多出个SetFromList。
  public Set<byte[]> smembers(byte[] key)
  {
    checkIsInMultiOrPipeline();
    this.client.smembers(key);
    return SetFromList.of(this.client.getBinaryMultiBulkReply());
  }


其中2.7或2.1是这个样子的:
public Set<String> smembers(String key) {
        this.checkIsInMulti();
        this.client.smembers(key);
        List members = this.client.getMultiBulkReply();
        return members == null?null:new HashSet(members);
}

挖槽，说好返回HashSet的呢....
</pre>




###	jedis2.7 和 commons-pool2-2.2包下载
[jedis2.7](http://pan.baidu.com/s/1o7SI3DS)

[commons-pool2-2.2](http://pan.baidu.com/s/1c2ltKv2)