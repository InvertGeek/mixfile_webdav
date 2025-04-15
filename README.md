## MixFileWebDAV服务器 (已过时,mixfile已原生支持webdav)
# 注意: 需要先安装mixfile: https://github.com/InvertGeek/MixFile
可挂载到Alist中 \
安装nodejs,输入npm i 安装依赖 \
node app.js启动服务 \
config.js中配置mixfile服务器地址和webdav端口 \
alist中创建新的webdav驱动,填写http://ip:端口即可,例如http://127.0.0.1:1900/ \
文件直链响应头x-mix-code为文件分享码 \
文件目录结构和文件分享码储存在webdav.dat文件中 \
mixfile只负责上传下载和解析分享码,即使更换mixfile服务器节点，数据也不会丢失 
## MixFileWebDAV服务器docker化
已经集成mixfilecli,开箱即用
### 使用仓库镜像启动服务
```bash
#启动docker
docker run -d -v ./alist-mixfileweb:/alist-mixfileweb -p 1900:1900   --name  alist-mixfileweb jellyhai/alist-mixfileweb:1.0
```
wevdav.dat文件在./alist-mixfileweb/mixfile_webdav目录下
alist中创建新的webdav驱动,填写http://ip:端口即可,例如http://127.0.0.1:1900/ 
注意：alist和alist-mixfileweb可以互相ping通


### 自行构建docker镜像启动服务
```bash
#构建docker镜像
下载本项目,cd 到docker目录下
docker build -t alist-mixfileweb:1.0 .
#启动docker
docker run -d -v ./alist-mixfileweb:/alist-mixfileweb -p 1900:1900   --name  alist-mixfileweb alist-mixfileweb:1.0
```
