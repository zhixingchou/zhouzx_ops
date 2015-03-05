#!/bin/bash

yum localinstall -y http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-2.4.4-1.el6.x86_64.rpm

yum install -y zabbix-server-mysql zabbix-web-mysql

cd /usr/share/doc/zabbix-server-mysql-2.4.0/create/

mysql -uzabbix -p zabbix < schema.sql
mysql -uzabbix -p zabbix < images.sql
mysql -uzabbix -p zabbix < data.sql

cp /etc/zabbix/zabbix_server.conf{,.original}
vim /etc/zabbix/zabbix_server.conf <<EOF > /dev/null 2>&1
:%s/# DBPassword=/DBPassword=zabbix/
:wq
EOF

service start zabbix-server
service restart httpd
