## centos7 install docker ##

### Prerequisites ###

Docker requires a 64-bit installation regardless of your CentOS version. Also, your kernel must be 3.10 at minimum, which CentOS 7 runs.

To check your current kernel version, open a terminal and use uname -r to display your kernel version:


### Install ###

#### Install with yum ####

1. Log into your machine as a user with sudo or root privileges.
2. Make sure your existing yum packages are up-to-date.

    $ sudo yum update

3. Add the yum repo.

>     $ sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
>     [dockerrepo]
>     name=Docker Repository
>     baseurl=https://yum.dockerproject.org/repo/main/centos/7/
>     enabled=1
>     gpgcheck=1
>     gpgkey=https://yum.dockerproject.org/gpg
>     EOF 

4. Install the Docker package.

    $ sudo yum install docker-engine	(使用DaoCloud包安装)

5. Start the Docker daemon.

    $ sudo service docker start

6. Verify docker is installed correctly by running a test image in a container.


> DaoCloud客服人员回复（另一种安装方法：执行一行命令）：
[https://www.daocloud.io/mirror#accelerator-doc](https://www.daocloud.io/mirror#accelerator-doc)


**Create a docker group**


**Start the docker daemon at boot**

      $ sudo chkconfig docker on



**验证Docker Client**

    $ sudo docker pull centos

**默认使用的是Docker官方源，不稳定。国内可以使用DaoCloud的Docker加速器服务，但要求Docker版本>=1.3.2。然后我们检查是否能看到镜像:**

    $ sudo docker images centos

> Docker 的安装资源文件存放在Amazon S3，国内下载速度极其缓慢。您可以通过执行下面的命令，使用 DaoCloud 镜像站点，高速安装Docker。
> 
> 卸载官网安装docker,使用DaoCloud安装.
> 
> DaoCloud选择加速器2.0-选择已有主机-操作系统类型(centos)
> 
> 1. 安装docker
> 2. 安装主机监控程序

----------

## docker 常用命令 ##


- 进入docker 容器 container 
 
1.attach

2.exec

    docker exec -it [containerId|containerName] /bin/bash

3.nsenter命令 

[http://edu.cnzz.cn/201509/969581c4.shtml](http://edu.cnzz.cn/201509/969581c4.shtml)

> 更简单的，建议大家下载.bashrc_docker，并将内容放到 .bashrc 中。
> 
> $ wget -P ~ https://github.com/yeasy/docker_practice/raw/master/_local/.bashrc_docker;
> $ echo "[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker" >~/.bashrc; source ~/.bashrc
> 这个文件中定义了很多方便使用 Docker 的命令，例如 docker-pid 可以获取某个容器的 PID；而 docker-enter 可以进入容器或直接在容器内执行命令。
> 
> $ echo $(docker-pid <container>)
> $ docker-enter <containerls

- 启动容器

docker run -t -i node:latest /bin/bash

-d 容器在后台运行

- 启动已终止容器

可以利用 docker start [containerId|containerName] 命令，直接将一个已经终止的容器启动运行。

- 重启容器

docker restart 命令会将一个运行态的容器终止，然后再重新启动它。

- 获取容器的输出信息

要获取容器的输出信息，可以通过 docker logs [containerId|containerName] 命令。

- 查看容器

    $sudo docker ps 查看正在运行的容器
    
    $sudo docker ps -a 查看所有的容器状态

- 删除容器

可以使用 docker rm 来删除一个处于终止状态的容器。如果要删除一个运行中的容器，可以添加 -f 参数。Docker 会发送 SIGKILL 信号给容器。
删除所有容器 docker rm $(docker ps -a -q)

- docker stats containerId

> 监控容器

    docker cp <containerId>:/file/path/within/container /host/path/target
    复制容器文件到宿主机

    docker inspect : 获取容器/镜像的元数据。


- docker --expose 参数

- docker --name 参数
- docker --volume 参数	（-v 等同于--volume）
- docker --publish 参数

> -P, --publish-all=false     Publish all exposed ports to random ports
> 
> -p, --publish=[]            Publish a container's port(s) to the host

- docker --detach 参数

> 如果在docker run 后面追加-d=true或者-d，则containter将会运行在后台模式(Detached mode)。

- docker --link 参数
- docker -storage_driver 
- docker -storage_driver_db
- docker -storage_driver_host
- docker -e  
> 作用是指定容器内的环境变量





## 常用镜像 ##


Influxdb：

tutum/influxdb:0.10

cadvisor：

google/cadvisor:latest

grafana：

grafana/grafana
