#!/bin/bash
echo "==============start============"

ps -fe|grep nginx |grep -v grep
if [ $? -ne 0 ]
then
echo "start process nginx"
/usr/local/openresty/nginx/sbin/nginx
else
echo "nginx runing....."
fi
#/usr/local/redis-3.0.5/src/redis-server /etc/redis-6380.conf

#/usr/local/openresty/nginx/sbin/nginx

#/usr/local/tomcat7/bin/startup.sh

echo "==============end==============="
