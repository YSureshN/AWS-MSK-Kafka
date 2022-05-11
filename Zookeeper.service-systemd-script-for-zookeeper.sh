from - http://davidssysadminnotes.blogspot.com/2016/01/installing-apache-kafka-and-zookeeper.html
[smack1]# vi /etc/systemd/system/kafka-zookeeper.service
[Unit]
Description=Apache Zookeeper server (Kafka)
Documentation=http://zookeeper.apache.org
Requires=network.target remote-fs.target 
After=network.target remote-fs.target

[Service]
Type=simple
User=kafka
Group=kafka
ExecStart=/opt/kafka-latest/bin/zookeeper-server-start.sh /opt/kafka-latest/config/zookeeper.properties
ExecStop=/opt/kafka-latest/bin/zookeeper-server-stop.sh

[Install]
WantedBy=multi-user.target

[Unit]
Description=Apache Zookeeper
After=network.target

[Service]
Type=forking
User=zookeeper
Group=zookeeper
SyslogIdentifier=zookeeper
Restart=always
RestartSec=0s
ExecStart=/usr/bin/zookeeper-server start
ExecStop=/usr/bin/zookeeper-server stop
ExecReload=/usr/bin/zookeeper-server restart

[Install]
WantedBy=multi-user.target


[Unit]
Description=Zookeeper Server
Documentation=https://zookeeper.apache.org
Requires=network.target remote-fs.target syslog.target
After=network.target remote-fs.target syslog.target
ConditionPathExists=/etc/zookeeper/zookeeper.properties
ConditionPathExists=/opt/isv/kafka

[Service]
Type=simple
PIDFile=/var/run/kafka.pid
User=kafka
Group=kafka
WorkingDirectory=/opt/isv/var/kafka
EnvironmentFile=/etc/sysconfig/zookeeper
ExecStart=
ExecStop=
Restart=on-failure
SyslogIdentifier=zookeeper

[Install]
WantedBy=multi-user.target
