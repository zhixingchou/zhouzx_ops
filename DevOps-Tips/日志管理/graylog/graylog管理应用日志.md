# graylog 管理 nginx tomcat 等应用日志

## nginx

[Graylog content pack for nginx](https://github.com/Graylog2/graylog-contentpack-nginx)

# 同一宿主机的nginx docker 安装测试
	1.不在同一台宿主机的nginx，需要graylog docker暴露对应的tcp端口（docker-compose.yml添加暴露端口）
	2.安装最新nginx使用nginx.yum 源
	3.nginx.conf更改配置 （graylog server ip 为容器ip）
	[root@gylog-ngx nginx]# cat nginx.conf
	
	user  nginx;
	worker_processes  1;
	pid        /var/run/nginx.pid;
	
	
	events {
	    worker_connections  1024;
	}
	
	
	http {
	    include       /etc/nginx/mime.types;
	    default_type  application/octet-stream;
	
	     # graylog nginx
	log_format  graylog2_format  '$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for" <msec=$msec|connection=$connection|connection_requests=$connection_requests|millis=$request_time>';
	
	      # replace the hostnames with the IP or hostname of your Graylog2 server
	      access_log syslog:server=172.17.0.4:12301 graylog2_format;
	     error_log syslog:server=172.17.0.4:12302;
	
	    sendfile        on;
	    #tcp_nopush     on;
	
	    keepalive_timeout  65;
	
	    #gzip  on;
	
	    include /etc/nginx/conf.d/*.conf;
	}


	4. graylog - system - content packs - import content pack - (nginx) content_pack.json 

