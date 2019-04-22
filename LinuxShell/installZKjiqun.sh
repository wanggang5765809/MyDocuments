# 修改/etc/hosts文件，添加以下内容
192.168.180.184 server4
192.168.180.185 server5
192.168.180.182 server2
192.168.180.181 server1
192.168.180.183 server3

#创建data目录，在data目录下创建myid文件
#修改datadir 参数的值



#在zoo.cfg添加集群配置
#jiqun config
server.1=server2:2888:3888
server.2=server4:2888:3888
server.3=server5:2888:3888

#根据server.1/2/3在data目录下myid输入数字1/2/3，和server.1/2/3一定要一一对应

关闭防火墙
删除cmd脚本
给sh脚本赋权限
启动zk，三台机器依次启动
sh zkServer.sh start

验证是否成功
sh zkServer.sh status    
# 这个可以验证一下选举算法