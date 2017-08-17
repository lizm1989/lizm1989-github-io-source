title: JAVA 将数组转List
date: 2017-08-17 18:50:31
---
###	JAVA 将数组转List 有坑需要注意
JAVA 将数组转List 有坑需要注意
<!--more-->

### 常见做法
<pre>
        int arr[] = {1, 2, 3};
        List list = Arrays.asList(arr);
        //这样做会有2个问题
        1、这里list是定长的，如果remove或者add,会报UnsupportedOperationException
        原因在于：
        Arrays.asList创建了一个ArrayList对象，
        这个ArrayList并不是java.util包下面的ArrayList，而是java.util.Arrays类中的一个内部类
        这个内部类继承AbstractList类
        AbstractList类的add和remove方法是如下：
         public void add(int index, E element) {
             throw new UnsupportedOperationException();
         }
         
         public E remove(int index) {
            throw new UnsupportedOperationException();
        }
        
        2、如果修改数组的值，list中的也会跟着变
        
</pre>


#### 建议做法
<pre>
        int arr[] = {1, 2, 3};
        
        List list2 = new ArrayList();

        Collections.addAll(list2, arr);
</pre>