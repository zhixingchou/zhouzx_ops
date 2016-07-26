# Prometheus + Container-Exporter #

> 参考 [使用 Prometheus 监控 Docker 容器](https://segmentfault.com/a/1190000002527178) 
> 
> docker run -p 8080:8080 -v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter
>
>端口8080错误，github使用端口：-p 9104:9104 


## Prometheus + cAdvisor	不推荐 -- 测试 ##

	1.宿主机时间同步
	2.cadvisor IP
![](http://i.imgur.com/oDdr34o.png)

	3.Docker容器和宿主机时间同步

----------


- 通过一个Docker Compose配置文件就能建立全功能的Prometheus监控环境