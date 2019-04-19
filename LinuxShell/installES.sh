#解压
tar zxvf elasticsearch-6.2.2.tar.gz -C /usr/local/software/
#创建es用户
useradd esuser
passwd esuser
#密码es123456
#修改es目录权限
chown -R esuser:esuser elasticsearch-6.2.2/
#切换用户esuser 进行启动
su esuser
#启动
cd /usr/local/software/elasticsearch-6.2.2/bin
./elasticsearch

#验证
#再开一个session，输入curl ip:9200 ,然后会看到一段信息，有版本信息等

