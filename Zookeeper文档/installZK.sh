#zk需要java环境
#创建zookeeper账号
useradd zookeeper
#密码 密码也是zookeeper
passwd zookeeper 
#解压 移动到指定文件夹
tar zxvf zookeeper-3.4.12.tar.gz -C /usr/local/software/
cd /usr/local/software/
#改名
mv zookeeper-3.4.12/ zookeeper
#修改配置文件
cd zookeeper/conf
#切换到conf目录下，会有zoo_sample.cfg 文件
#第一步 修改配置文件的名字
mv zoo_sample.cfg zoo.cfg
#第二步 创建数据文件夹 最后的data文件夹是创建的
/usr/local/software/zookeeper/data
#第三步 修改配置文件，只修改Datadir 目录即可
#修改为 dataDir=/usr/local/software/zookeeper/data

#修改zookeeper 文件夹所属用户
chown -R zookeeper:zookeeper zookeeper/


#启动zookeeper
#切换成zookeeper用户再zookeeper的bin目录下
./zkServer.sh start 
