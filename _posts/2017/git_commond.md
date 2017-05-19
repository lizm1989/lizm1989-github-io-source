title: git命令
date: 2017-03-07 14:50:31
---
###	总结自己使用的git命令
git使用了，但不记录每次都要help或者搜索，总是不太方便，所以就写下来方便自己日常使用

<!--more-->

###	其他
<pre>
显示当前分支的版本历史
>git log


</pre>


###	新建本地仓库
<pre>
本地文件夹目录中执行，初始化
>git init
或者直接 >git init [name]

下载一个远程项目并创建在文件夹jsoup中，jsoup文件非必须，不填就是项目名字
>git clone https://github.com/lizm1989/jsoup-learning.git jsoup

指定分支，因为默认是master分支
>git clone -b [branch-name] htpp://xxx
</pre>


###	配置
<pre>
显示配置
>git config --list

设置提交用户信息
>git config --global user.name "[name]"

>git config --global user.email "[email]"
</pre>


###	文件操作
<pre>
添加一个文件到暂存去
>git add 111.txt 
>git add aa 【目录也可以】

删除暂存区
>git rm --cached 111.txt
>git rm --cached -r aa【目录加-r】

查看当前状态
>git status

添加所有文件
>git add -A

提交暂存区到仓库
>git commit -m "commit"

部分文件
>git commit aa.txt bb.txt -m "commit"


提交本地分支
>git push origin master
</pre>


###	分支
<pre>
查看本地分支
>git branch

查看远程分支
>git branch -r

查看所有分支
>git branch -a

新建分支，但留在当前选择的分支
>git branch [branch-name]

新建分支，并切换到新建分支
>git checkout -b [branch-name]

切换分支
>git checkout [branch-name]

合并指定分支到当前分支
>git merge [branch-name]

删除分支
>git branch -d [branch-name]

删除远程分支
>git push origin :[branch-name]


</pre>


###	标签
<pre>
标签查看
>git tag

标签过滤	
>git tag -l 'v1.4.2.*'

创建标签
>git tag -a "v1.0" -m "commit"

推送标签
>git tag push origin v1.0

如果要一次推送所有本地新增的标签上去，可以使用 --tags
</pre>

###	同步
<pre>
取回远程仓库，并与本地分支合并
>git pull origin master

上传本地指定分支到远程仓库
>git push origin master


强行推送当前分支到远程仓库，包括有冲突
>git push origin master --force



</pre>