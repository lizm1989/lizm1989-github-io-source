title: guava
date: 2017-02-16 14:50:31
---
###	概述
 guava由谷歌提供的工具类，代码简洁、高效。

 开发中偶尔使用可以提高生产力，节约时间。

<!--more-->

###	string

####	将list集合转换特定规则字符串
<pre>
List<String> list = new ArrayList<String>();
list.add("张三");
list.add("李四");
list.add("王五");
String result = Joiner.on("-").join(list);
//result     张三-李四-王五
</pre>

####	把map集合转换为特定规则的字符串
<pre>
Map<String,Integer> map=new HashMap<String,Integer>();
map.put("张三",19);
map.put("李四",20);
map.put("王五",21);

String result = Joiner.on(",").withKeyValueSeparator("=").join(map);
System.out.println("result=>"+result);

result=>李四=20,张三=19,王五=21
</pre>
