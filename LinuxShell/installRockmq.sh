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

#nameserver启动之后启动 Broker，在启动的时候还会发现内存不足，修改修改/usr/local/software/rocketmq/distribution/target/apache-rocketmq/bin目录下的runbroker.sh文件的 JAVA_OPT="${JAVA_OPT} -server -Xms8g -Xmx8g -Xmn4g" ，改为JAVA_OPT="${JAVA_OPT} -server -Xms512m -Xmx512m -Xmn256m"
sh mqbroker -n localhost:9876
#启动成功标识：The broker[centos702, 192.168.180.185:10911] boot success. serializeType=JSON and name server is localhost:9876

#守护进程启动
nohup sh mqbroker -n localhost:9876 &

#验证启动是不是成功
#rockmq 官网 http://rocketmq.apache.org/docs/quick-start/




