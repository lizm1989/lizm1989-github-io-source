#!/bin/bash
find /usr/local/tomcat7/logs  -mtime +5 -name "*.log" -exec rm -rf {} \;
