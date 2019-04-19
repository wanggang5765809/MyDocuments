下载wget
yum install wget -y
echo 备份当前的yum源
mv /etc/yum.repos.d /etc/yum.repos.d.backup4comex
echo 新建空的yum源设置目录
mkdir /etc/yum.repos.d
echo 下载阿里云的yum源配置
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

#
yum clean all
yum makecache