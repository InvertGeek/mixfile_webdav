#指明制作当前镜像将基于的基础镜像
FROM node:current-alpine3.21
#指定所制作镜像的维护者和联系方式
#指定容器运行时的默认工作目录(没有会自动创建)，不指定则会使用FROM基础镜像指定的默认工作目录
WORKDIR /alist-mixfileweb
#从镜像构建上下文目录里添加需要的文件到容器镜像的指定目录(这里使用了与WORKDIR相同的目录，但不是必须这样)，添加分ADD和COPY两种，ADD会复制并解压(这里添加的文件将影响镜像的大小，多文件COPY目的目录要以/结尾)
#更换安装过程中的工具包下载源(否则下载后面的工具会非常的慢)
RUN echo http://mirrors.aliyun.com/alpine/v3.21/main/ > /etc/apk/repositories && echo http://mirrors.aliyun.com/alpine/v3.21/community/ >> /etc/apk/repositories && apk update
#安装必要工具、下载alpine-pkgs.sgerrand公钥、安装必要的依赖
RUN apk --no-cache add ca-certificates wget && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \ 
&& apk --no-cache add openjdk21 \
&& apk --no-cache add supervisor \
&& mkdir /etc/supervisor.d/ \
&& mkdir /alist-mixfileweb/mixfilecli \
&& cd /alist-mixfileweb/mixfilecli && wget -q -O mixfile-cli.jar https://github.com/InvertGeek/mixfilecli/releases/download/1.6.5/mixfile-cli-1.6.5.jar \
&& cd /alist-mixfileweb/ && wget -q -O mixfile_webdav.zip https://codeload.github.com/InvertGeek/mixfile_webdav/zip/refs/heads/master && unzip mixfile_webdav && mv mixfile_webdav-master mixfile_webdav\
&& cd /alist-mixfileweb/mixfile_webdav && npm i
COPY ./supervisor.d/* /etc/supervisor.d/
#清理缓存和容器镜像里不再要的包，保留JDK解压目录即可(没指定明确路径的都是相对于容器运行时的默认工作目录)
RUN rm -rf /var/cache/apk/*
RUN rm -rf /alist-mixfileweb/mixfile_webdav.zip
#设置时区(和普通操作系统一样需要对齐服务器时区，跑在上面的应用拿到的时间才不会乱)
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
#配置环境变量
#ENV JAVA_HOME=/java/jdk-24
#ENV CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
#ENV PATH=$PATH:$JAVA_HOME/bin
RUN  mv /alist-mixfileweb /alist-mixfileweb.bak
COPY ./start.sh /start.sh
#指定容器启动时需要执行的命令(需要的话就把注释#去掉)
CMD ["/bin/sh","-c","/start.sh"]