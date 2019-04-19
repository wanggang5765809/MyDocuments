tar zxvf apache-maven-3.6.0-bin.tar.gz -C /usr/local/software/
cd /usr/local/software/
mv apache-maven-3.6.0/ maven
echo "MAVEN_HOME=/usr/local/software/maven" >> /etc/profile
echo "export PATH=$MAVEN_HOME/bin:$PATH" >> /etc/profile
