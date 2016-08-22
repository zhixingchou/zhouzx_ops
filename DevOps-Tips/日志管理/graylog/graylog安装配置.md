# graylog 安装配置 #

    宿主机 OS:CentOS7 64
    docker graylog server OS:Debian GNU/Linux 8


## use docker install graylog 

[graylog 官网 docker 安装](http://docs.graylog.org/en/2.0/pages/installation/docker.html)

- Persist log data

	    mkdir -p /graylog/config
	    cd /graylog/config
	    wget https://raw.githubusercontent.com/Graylog2/graylog2-images/2.0/docker/config/graylog.conf
	    wget https://raw.githubusercontent.com/Graylog2/graylog2-images/2.0/docker/config/log4j2.xml


- docker-compose install graylog

The docker-compose.yml file looks like this:

> 1.挂载- /etc/localtime:/etc/localtime 容器同步宿主机时间
> 
> 2.修改GRAYLOG_REST_TRANSPORT_URI 地址为宿主机IP


	some-mongo:
	  image: "mongo:3.3.9"
	  volumes:
	    - /graylog/data/mongo:/data/db
	    - /etc/localtime:/etc/localtime
	some-elasticsearch:
	  image: "elasticsearch:2"
	  command: "elasticsearch -Des.cluster.name='graylog'"
	  volumes:
	    - /graylog/data/elasticsearch:/usr/share/elasticsearch/data
	    - /etc/localtime:/etc/localtime
	graylog:
	  image: graylog2/server
	  volumes:
	    - /graylog/data/journal:/usr/share/graylog/data/journal
	    - /graylog/config:/usr/share/graylog/data/config
	    - /etc/localtime:/etc/localtime
	  environment:
	    GRAYLOG_PASSWORD_SECRET: somepasswordpepper
	    GRAYLOG_ROOT_PASSWORD_SHA2: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
	    GRAYLOG_REST_TRANSPORT_URI: http://192.168.1.200:12900
	
	  links:
	    - some-mongo:mongo
	    - some-elasticsearch:elasticsearch
	  ports:
	    - "9000:9000"
	    - "12900:12900"
	    - "12201/udp:12201/udp"
	    - "1514/udp:1514/udp"



1.docker-compose安装环境,安装pip

    install pip

2.安装docker-comopse

	pip install -U docker-compose


3.启动docker-compose

	docker-compose up
	docker-compose up -d 启动容器后台运行

[Docker Compose常用命令](http://dockone.io/article/834)



## Graylog Collector Sidecar

- 原理图

![](http://i.imgur.com/LQojAHo.png)

安装nxlog

1.centos 环境

	sudo yum localinstall nxlog-ce-2.9.1716-1_rhel7.x86_64.rpm
	sudo systemctl disable nxlog
	sudo usermod -a -G root nxlog

2.ubuntu 环境

    dpkg-deb -f nxlog-ce_2.9.1716_ubuntu_1604_amd64.deb Depends
    apt-get -f -y install
    
    $ sudo /etc/init.d/nxlog stop
    $ sudo update-rc.d -f nxlog remove
    $ sudo gpasswd -a nxlog adm

3.Windows 


安装collector-sidecar

1.centos 环境

	sudo rpm -ivh collector-sidecar-0.0.9-1.x86_64.rpm
    $ sudo graylog-collector-sidecar -service install
    $ sudo service collector-sidecar start

2.ubuntu 环境
    dpkg -i collector-sidecar_0.0.7-1_amd64.deb
    
    To register and enable a system service use the -service option:
    $ sudo graylog-collector-sidecar -service install
    $ sudo service collector-sidecar start


3.Windows 


nxlog.conf、collector_sidecar.yml 配置

1.nxlog.conf

![](http://i.imgur.com/7RylUN7.png)

    路径为要监控日志文件路径
    graylog server ip (114.55.175.104)
    端口可以不用修改


2.collector_sidecar.yml

![](http://i.imgur.com/2s8fOST.png)

    还要修改server_url ：http://graylog server ip:12900
	node_id: graylog-collector-sidecar 有多个collect要修改不同名称



graylog web 配置

    http://graylog server ip:9000
    system/collectors-collectors-manager coonfigures-create coonfigures

![](http://i.imgur.com/F0hSbEy.png)


![](http://i.imgur.com/GDIh18P.png)

![](http://i.imgur.com/9ldKLUu.jpg)

![](http://i.imgur.com/xGGRimL.png)

![](http://i.imgur.com/NpIVxOF.png)


Collector xx Configuration - NXLog 配置


Configure NXLog Outputs

![](http://i.imgur.com/qFM5rVc.png)


Configure NXLog Inputs

![](http://i.imgur.com/3uSULa7.png)


日志客户端启动collector-sidecar

/etc/init.d/collector-sidecar start

查看进程

![](http://i.imgur.com/GDijTaS.png)

graylog web查看Collectors 是否运行正常

![](http://i.imgur.com/3arUDzt.png)

![](http://i.imgur.com/kiOIXNj.png)



graylog web 设置 日志接收

![](http://i.imgur.com/h0UgQBt.png)

![](http://i.imgur.com/FEvOSVr.png)

![](http://i.imgur.com/JIIG259.png)

    1.设置外网IP启动失败
    2.开始不能接收日志，重启compose不行，重新给日志文件写入内容






----------
# graylog web 查询 #

![](http://i.imgur.com/4h70EH7.png)




---------
# graylog dashboards



-----------
# graylog streams 报警

- 设置邮箱

	    root_email = "zhixing0912@gmail.com"
	    transport_email_enabled = true
	    transport_email_hostname = smtp.gmail.com 
	    transport_email_port = 465 
	    transport_email_use_auth = true
	    transport_email_use_tls = true
	    #transport_email_use_ssl = true
	    transport_email_auth_username = zhixing0912
	    transport_email_auth_password = xxxx
	    transport_email_subject_prefix = [graylog2]
	    transport_email_from_email = zhixing0912@gmail.com


----------
# 故障 #

- graylog admin用户web页面时区设置（默认root_timezone = UTC）

	    admin帐号的时区
	    /usr/share/graylog/data/config/graylog.conf
		重启graylog server



- ubuntu docker install ssh ; windows xshell 可以登录,centos ssh / apple os 不能登录？

- centos7 docker install **collector-sidecar-0.0.8-1.x86_64.rpm** 版本 ，graylog web collector unknown

     1.error one ?

		graylog_1             | 2016-08-14 07:20:23,966 WARN : org.graylog2.shared.rest.resources.ProxiedResource - Unable to call http://192.168.1.200:12900/system/inputstates on node <bdd5f2d7-ade2-46f0-a7b0-60dae0368bf9>, caught exception: No route to host (class java.net.NoRouteToHostException)
		graylog_1             | 2016-08-14 07:20:24,319 WARN : org.graylog2.shared.rest.resources.ProxiedResource - Unable to call http://192.168.1.200:12900/system/metrics/multiple on node <bdd5f2d7-ade2-46f0-a7b0-60dae0368bf9>, caught exception: connect timed out (class java.net.SocketTimeoutException)

	2.error two
	
		collector unknown

	3.error three

		memory user too mush
		2G-4G free 1G buffer 1G
		[CentOS7清理yum缓存和释放内存方法](http://www.centoscn.com/CentOS/Intermediate/2016/0108/6629.html)