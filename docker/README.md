## MixFileWebDAV服务器docker化
已经集成mixfilecli,开箱即用
```bash
docker run -d -v ./alist-mixfileweb:/alist-mixfileweb -p 1900:1900 alist-mixfileweb:1.0
```
wevdav.dat文件在./alist-mixfileweb/mixfile_webdav目录下
alist中创建新的webdav驱动,填写http://ip:端口即可,例如http://127.0.0.1:1900/ 
