title: nginx_error_invalid_PID_number
date: 2017-03-12 18:50:31
---
###	nginx重启报错
nginx: [error] invalid PID number "" in "/usr/local/openresty/nginx/logs/nginx.pid"

<!--more-->

###	找到nginx的pid，然后重启
<pre>
PID记得要是master

>echo PID > /usr/local/openresty/nginx/logs/nginx.pid

>nginx -s reload
></pre>





