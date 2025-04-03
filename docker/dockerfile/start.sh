#!/bin/sh
if [ "$(ls -A /alist-mixfileweb)" ];then
    supervisord -n
else
    mv /alist-mixfileweb.bak/* /alist-mixfileweb/
	supervisord -n
fi
