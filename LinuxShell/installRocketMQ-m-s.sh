#===================第一步 nameserver=========================
unzip rocketmq-all-4.4.0-source-release.zip -d /usr/local/software/
cd /usr/local/software
mv rocketmq-all-4.4.0/ rocketmq
#使用maven编译
cd cd rocketmq/
mvn -Prelease-all -DskipTests clean install -U

#进入到mq内部
cd distribution/target/apache-rocketmq
#启动nameServer，使用虚拟机启动的时候要修改内存，因为nameServer默认是4g或者8g内存,修改/usr/local/software/rocketmq/distribution/target/apache-rocketmq/bin目录下的runserver.sh文件
#原来的java内存配置是 JAVA_OPT="${JAVA_OPT} -server -Xms4g -Xmx4g -Xmn2g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"
#修改为JAVA_OPT="${JAVA_OPT} -server -Xms256m -Xmx256m -Xmn256m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"
#因为虚拟机内存是2g的，可以改为512或者256

#修改完成之后，启动nameserver 在 /usr/local/software/rocketmq/distribution/target/apache-rocketmq/bin下
sh mqnamesrv 
# 出现以下就说明nameserver启动成功
#ation size of 262080k will be used.
#The Name Server boot success. serializeType=JSON
#成功之后说明机器配置可以，然后使用守护进程启动
nohup sh mqnamesrv &

#====================第二步  broker =========================
#在/usr/local/software/rocketmq/distribution/target/apache-rocketmq/conf 目录下有配置文件
#进入2m-2s-async目录查看，双主双从异步刷盘，其中有四个文件，搭建主从只需要一堆ms即可。
#修改broker-a.properties配置文件
#具体修改的内容查看笔记
#修改broker-a-s.properties配置文件
#具体修改的内容查看笔记
#配置文件也有备份

#启动broker，使用指定配置文件的方式启动
#指定配置文件启动 在 /usr/local/software/rocketmq/distribution/target/apache-rocketmq目录下

#主节点
sh bin/mqbroker -c ./conf/2m-2s-async/broker-a.properties &
#守护进程
nohup sh bin/mqbroker -c ./conf/2m-2s-async/broker-a.properties &


#从节点
sh bin/mqbroker -c ./conf/2m-2s-async/broker-a-s.properties &
#守护进程
nohup sh bin/mqbroker -c ./conf/2m-2s-async/broker-a-s.properties &


#验证启动是不是成功
#rockmq 官网 http://rocketmq.apache.org/docs/quick-start/




