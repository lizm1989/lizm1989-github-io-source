title: jdk-proxy动态代理&cglib动态代理
date: 2017-03-01 14:50:31
---
###	代理模式
代理模式要让代理类和目标类实现相同的接口，客户端通过调用代理类来调用目标类方法，代理类会将所有的方法调用分派到目标对象上反射执行，可以在分派过程中添加“前置”及“后置”。

JDK实现动态代理需要实现类通过接口定义业务方法。
<!--more-->

###	动态代理几个步骤
1.通过实现InvocationHandler定义自己的AddHandler
<pre>
package com.example.test;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class AddHandler implements InvocationHandler {

    //目标对象
    private Object target;


    public AddHandler(Object target) {
        this.target = target;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {

		//执行方法之前
        System.out.println("====>before");

		//执行目标对象方法
        Object object = method.invoke(target, args);

		//执行方法之后
        System.out.println("====>after");
        return object;
    }

    //获得代理对象
    public Object getProxy() {
		//要绑定接口(是一个缺陷，CGlib弥补了这一缺陷)  
        return Proxy.newProxyInstance(Thread.currentThread().getContextClassLoader(), target.getClass().getInterfaces(), this);
    }

}

</pre>

2.目标接口及实现
<pre>
package com.example.test;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public interface Add {
    int add(int a, int b);
}



package com.example.test;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class AddImpl implements Add {
    @Override
    public int add(int a, int b) {
        System.out.println("====>add");
        return a + b;
    }
}


</pre>

3.测试结果
<pre>
package com.example.test;


/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class AddTest {
    public static void main(String[] args) {

        //目标对象
        Add add = new AddImpl();

        //实例化自己的AddHandler
        AddHandler addHandler = new AddHandler(add);


        //生成代理对象
        Add addProxy = (Add) addHandler.getProxy();

        //调用代理对象方法
        addProxy.add(1, 2);
    }
}


//结果
====>before
====>add
====>after
</pre>


###	CGlib
CGlib采用字节码技术，原理是通过字节码为一个类创建一个子类，并在子类中采用拦截所有父类的所有方法，然后植入横切的逻辑，JDK动态代理和CGlib代理均是Spring AOP的基础。

CGLib创建的动态代理对象性能比JDK创建的动态代理对象的性能高不少，但是CGLib在创建代理对象时所花费的时间却比JDK多得多，所以对于单例的对象，因为无需频繁创建对象，用CGLib合适，反之，使用JDK方式要更为合适一些。


同时，由于CGLib由于是采用动态创建子类的方法，对于final方法，无法进行代理。



###	CGlib
<pre>
package com.example.test.cglib;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class Say {
    public void say() {
        System.out.println("say ====");
    }

    public final void finalSay(){
        System.out.println("finalSay ====");
    }
}



package com.example.test.cglib;

import org.springframework.cglib.proxy.Enhancer;
import org.springframework.cglib.proxy.MethodInterceptor;
import org.springframework.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class CglibProxy implements MethodInterceptor {

    private Enhancer enhancer = new Enhancer();

    public Object getProxy(Class clazz) {

        //设置需要创建的子类
        enhancer.setSuperclass(clazz);
        enhancer.setCallback(this);

        //通过字节码技术创建实例
        return enhancer.create();
    }

    @Override
    public Object intercept(Object object, Method method, Object[] objects, MethodProxy methodProxy) throws Throwable {
        System.out.println("statr====");

        Object result = methodProxy.invokeSuper(object, objects);
        System.out.println("end========");
        return result;
    }
}



package com.example.test.cglib;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class CglibTest {
    public static void main(String[] args) {
        CglibProxy cglibProxy = new CglibProxy();
        //通过生成子类创建代理类
        Say say = (Say) cglibProxy.getProxy(Say.class);
        say.say();
        System.out.println("================================");

        //final方法，无法进行代理。
        say.finalSay();
    }
}


//结果
statr====
say ====
end========
================================
finalSay ====
</pre>


###	手写一个代理模式
<pre>
package com.example.test.proxy;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public interface Count {
    void queyCount();
}

package com.example.test.proxy;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class CountImpl implements Count {
    @Override
    public void queyCount() {
        System.out.println("query count");
    }
}


package com.example.test.proxy;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class CountProxy implements Count {

    private Count count;

    public CountProxy(Count count) {
        this.count = count;
    }

    @Override
    public void queyCount() {
        System.out.println("start-==========");
        count.queyCount();
        System.out.printf("end=============");
    }
}



package com.example.test.proxy;

/**
 * Created by zhimingli on 2017-3-1 0001.
 */
public class CountPrxoyTest {

    public static void main(String[] args) {
        Count count = new CountImpl();

        CountProxy countProxy = new CountProxy(count);
        countProxy.queyCount();
    }
}
</pre>