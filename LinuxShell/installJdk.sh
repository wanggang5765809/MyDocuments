cd /usr/local
mkdir software
#在jdk文件所在的位置解压，解压到/usr/local/software目录下
tar zxvf jdk-8u201-linux-x64.tar.gz -C /usr/local/software/
cd /usr/local/software/
#修改文件夹名字，这步可选
mv jdk1.8.0_021 jdk8
#修改环境变量
echo "export JAVA_HOME=/usr/local/software/jdk8" >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile
echo "export PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile
