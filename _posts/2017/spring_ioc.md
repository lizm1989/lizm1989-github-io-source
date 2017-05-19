title: Spring IOC
date: 2017-03-01 14:50:31
---
###	Spring IOC控制反转
控制反转：一般程序需要多个对象协同来完成，通常都需要new，这样耦合度就比较高。
而IOC思想是：Spring来实现这些相互依赖对象的创建、协调工作。
对象关注业务。

spring来负责控制对象的生命周期和对象间的关系
<!--more-->

###	反转
所有的类都会在spring容器中登记，告诉spring你是个什么东西，你需要什么东西。

然后spring会在系统运行到适当的时候，把你要的东西主动给你，同时也把你交给其他需要你的东西。

所有的类的创建、销毁都由 spring来控制，也就是说控制对象生存周期的不再是引用它的对象，而是spring。

对于某个具体的对象而言，以前是它控制其他对象，现在是所有对象都被spring控制，所以这叫控制反转。	


参考1：[http://blog.csdn.net/it_man/article/details/4402245](http://blog.csdn.net/it_man/article/details/4402245 "参考1")

参考2：[http://www.cnblogs.com/ITtangtang/p/3978349.html]("参考2")
