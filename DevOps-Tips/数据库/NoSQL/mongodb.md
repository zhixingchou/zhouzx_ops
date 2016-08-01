# mongodb #

- mongodb 安全启动：

		为了方便，也可以直接创建一个root权限的最高级用户：	
		1.db.createUser({user:"admin",pwd:"uLahngoo6k",roles:["root"]})  
		2.启动mongod 服务添加 --auth参数
			./mongod -dbpath /data/mongo/data/ -logpath /data/mongo/mongo.log -logappend -fork --auth		（120.76.223.75）
		3.再次访问其他数据库或者执行操作时，需要首先认证
		> use admin;
		switched to db admin
		> db.auth("admin","uLahngoo6k")

> [关于mongodb的启动:](https://segmentfault.com/n/1330000004356006)


- mongodb 停止服务

>   在linux下大家停止很多服务都喜欢直接kill -9 PID，但是对于MongoDB如果执行了kill -9 PID，在下次启动时可能提示错误，导致服务无法启动，这个时候可以通过执行:
>   rm -f /app/hadoop/db/mongod.lock  
>   也即删除指定数据目录下的mongod.lock文件即可。
    
    正常停止方法:
    kill  -2 PID
    或者
    mongo -host ip:port  
    先连接需要停止的服务,然后:
    use  admin  
    db.shutdownServer();  
    这样也可以正常停止服务。