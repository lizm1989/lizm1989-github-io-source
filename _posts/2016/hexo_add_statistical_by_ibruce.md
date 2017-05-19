title: hexo添加访问次数
date: 2016-03-11 14:50:31
tags:
	- IT
categories:
	- IT
---
想着为博客添加一个访客计数统计。

好，以下是正式内容：
1.	使用[不蒜子](http://busuanzi.ibruce.info/)，计数2行搞定。
2.	修改源文件:
<!--more-->
<pre>
/themes/yilia/layout/_partial/footer.ejs


      
</pre>

	  <script async src="//dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
        <span id="busuanzi_container_site_pv">本站总访问量<span id="busuanzi_value_site_pv"></span>次</span>
        <div class="footer-right">
                <a href="http://hexo.io/" target="_blank">Hexo</a>  Theme <a href="https://github.com/litten/hexo-theme-yilia" target="_blank">Yilia</a> by Litten
        </div>
3.	对，就是这么简单。重新发布下即可。
