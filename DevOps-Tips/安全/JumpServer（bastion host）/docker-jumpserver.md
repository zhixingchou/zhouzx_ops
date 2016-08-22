jumpserver


- （docker 宿主机启动docker服务使用docker组用户）
- docker 容器时间同步宿主机
- docke 控制容器的磁盘大小（默认是10G，修改--storage-opt dm.basesize=15G）
- 设置容器hostname -- [不能通过修改hosts文件改变hostname，hostname命令也不可用](http://www.jianshu.com/p/8575b43bcafd)
- 制作jumpserver docker镜像

    	熟悉dockerfile

> - jumpserver（安装过程中要求输入数据库密码），在centos7 docker容器安装，导出为jumpserver docker 镜像
   
1.容器导出镜像等命令：  
 [http://www.jianshu.com/p/8575b43bcafd](http://www.jianshu.com/p/8575b43bcafd)

2.jumpserver 需要连接mysql数据库 （mysql 设置单独docker）
![](http://i.imgur.com/aCltyHF.png)

3.**centos7 docker 启动mysql报错 Failed to get D-Bus connection: Operation not permitted**
- jumpserver docker 安装使用已经安装mysql （jumpserver群管理员建议）
![](http://i.imgur.com/UJuTyB4.png)

		给所有访问主机授权
    	grant all on jumpserver.* to 'jumpserver'@'%' identified by 'mysql234';
		flush privileges;


4.（--link mysql）


- jumpserver docker 添加其他docker资产需要开启sshd服务

![](http://i.imgur.com/UGt5CBm.jpg)

> 1.[启动sshd时，报“Could not load host key”错](http://blog.chinaunix.net/uid-26168435-id-5732463.html)    
> [docker centos7 安装ssh](http://blog.csdn.net/waixin/article/details/50212079)
> 
> 1.1. ubuntu 安装ssh：    

[docker ubuntu镜像安装ssh免登录](http://my.oschina.net/wanyuxiang000/blog/673035) 
 
    /etc/ssh/sshd_config
    #PermitRootLogin without-password#找到这里，把它注释
    PermitRootLogin yes  #改为yes  然后重启ssh

>  **1.2. （jumpserver web 连接docker 用户）sshd_config 不需要修改 UsePAM yes**


>2.docker 容器没有安装sudo 命令，不能推送系统用户



5.添加docker容器资产web ssh执行命令报错

    FAILED: not a valid EC private key file


6.docker 服务重启，docker容器ip会改变


----------
- 运行docker容器命令

	    同步时间
	    docker run -it --name jumpser -d -v /etc/localtime:/etc/localtime:ro  centos
	    设置容器主机名 -h 
	    docker run -h dk-jpser -it --name jumpserone -d  -v /etc/localtime:/etc/localtime:ro  centos
		jpser-noport是安装jumpserver没有映射端口镜像
		docker run -h dk-jpser-8000 -it --name jpser-8000 -p 8000:8000 -d  -v /etc/localtime:/etc/localtime:ro  jpser-noport
		完整运行jumpserver服务docker容器命令：
		docker run -it -h dk-jpser --name jumpserone -p 8000:8000 -d  -v /etc/localtime:/etc/localtime:ro  centos
		挂载目录/tmp/dk-jumpserver
		docker run -it -h dk-jpser --name jpser -p 8000:8000 -d  -v /etc/localtime:/etc/localtime:ro -v /tmp/dk-jumpserver  centos
		映射ssh 22端口，使用xshell等windows客户端登录堡垒机
		docker run -it -h dk-jpser --name jpser -p 8000:8000 -p 2200:22 -d  -v /etc/localtime:/etc/localtime:ro -v /tmp/dk-jumpserver  centos


- docker动态映射运行的container端口

docker run 或者 dockerfile没有指定端口映射，动态映射端口[docker动态映射运行的container端口](http://yaxin-cn.github.io/Docker/expose-port-of-running-docker-container.html)