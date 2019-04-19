cd /usr/local/mysql/bin/
./mysqld --defaults-file=/etc/my.cnf &

cd /usr/local/redis4.0.9/src
./redis-server /usr/local/redis4.0.9/redis.conf

# 启动 es 必须使用esuser 密码是123456
#cd /usr/local/elasticsearch5.6.8/bin
#./elasticsearch

#启动activemq
cd /usr/local/activemq5.15.3/bin/linux-x86-64
./activemq start
