# docker monitor	tool -- cAdvisor #

- Cadvisor只能进行单主机的Docker容器监控
- Cadvisor数据是存储在内存中的实时数据，无法保留历史数据


----------


参考 [Docker部署(Influxdb+cadvisor+grafana)-centos7](http://www.pangxie.space/docker/456)

参考另一个链接 [http://90docker.com/?p=176](http://90docker.com/?p=176) （**grafana添加data sources报错，关闭宿主机防火墙；之后启动容器报错？**）

    cadvisor只是能监控到实时的信息而不能保存，所以我们要使用influxdb将这些实时监控到的信
	息存放起来，以备以后需要。
	而grafana这个就是将influxdb存放的信息以图表的形式，非常清晰，完美地展现出来。

    cAdvisor可以通过storage_driver参数将数据存到influxdb。

----------

> [三个流行的监控方案：cAdvisor、“cAdvisor + InfluxDB + Grafana”以及Prometheus](http://www.infoq.com/cn/news/2015/12/dockercon-docker-monitoring)
> Christner在演讲的最后比较了上述三种容器监控方式，即cAdvisor、“cAdvisor + InfluxDB + Grafana”和Prometheus。
> 
> 

> 1. 尽管cAdvisor最易用，但它在扩展性和告警方面有局限性。
> 
> 2. 组合使用“cAdvisor + InfluxDB + Grafana”能够提供很好的可扩展性，并且提供了客户端库，但是内置不支持告警功能。
>  
> 3. Prometheus可能扩展起来不那么容易，但是它支持告警并提供了针对多种语言的客户端库。

