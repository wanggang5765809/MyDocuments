下载wget
yum install wget -y
echo 备份当前的yum源
mv /etc/yum.repos.d /etc/yum.repos.d.backup4comex
echo 新建空的yum源设置目录
mkdir /etc/yum.repos.d
echo 下载阿里云的yum源配置
centos7
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

centos6
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo

#
yum clean all
yum makecache


验证一下
yum repolist  all

列出来的base，extras，updates 是enabled的即可，base，extras，updates表示使用的是网络yum源