#Prometheus+Grafana

## EXPORTERS - 收集
[https://github.com/prometheus?page=1](https://github.com/prometheus?page=1)



## Grafana（Data Sources:Prometheus） - 展示
[https://grafana.net/dashboards](https://grafana.net/dashboards)



## company test deploy prometheus monitor docker container

### Prometheus + Container-Exporter 

> 参考 [使用 Prometheus 监控 Docker 容器](https://segmentfault.com/a/1190000002527178) 
> 
> docker run -p 8080:8080 -v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter
>
>端口8080错误，github使用端口：-p 9104:9104 


### Prometheus + cAdvisor	不推荐 -- 测试 ##

	1.宿主机时间同步
	2.cadvisor IP
![](http://i.imgur.com/oDdr34o.png)

	3.Docker容器和宿主机时间同步

----------

