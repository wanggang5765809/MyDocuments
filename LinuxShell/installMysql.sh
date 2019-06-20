mkdir -p /opt/mysql/mysql5.7.24
tar zxvf mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz -C /opt/mysql/mysql5.7.24
groupadd mysql
useradd -g mysql -d /usr/local/mysql -s /sbin/nologin -MN mysql
cd /usr/local/
ln -s /opt/mysql/mysql5.7.24/mysql-5.7.24-linux-glibc2.12-x86_64 mysql
cd
mkdir -p /data/mysql/mysql3306/{data,logs,tmp}
chown -R mysql:mysql /data
cd /usr/local/mysql/bin/
./mysqld --initialize
#指定配置文件初始化
./mysqld --initialize --user=mysql --basedir=/usr/local/software/mysql7/ --datadir=/data/mysql/mysql3307/data/
#mysql8.0初始化
./mysqld --initialize --user=mysql --lower-case-table-names=1 --basedir=/usr/local/mysql/ --datadir=/data/mysql/mysql3306/data/
./mysqld --defaults-file=/etc/my.cnf &
