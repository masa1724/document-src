
### httpd
sudo yum list httpd
sudo yum -y install httpd

# JDK
https://github.com/masa1724/document/blob/master/java/JDK-settings.adoc

# MySQL(MariaDB)
https://github.com/masa1724/document/blob/master/MySQL/MySQL-settings.ado

### Tomcat ###
```
TOMCAT_VERSION="8.5.8"
TOMCAT_URL="http://ftp.riken.jp/net/apache/tomcat/tomcat-$(echo ${TOMCAT_VERSION} | cut -c 1)/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
echo ${TOMCAT_URL}
sudo wget ${TOMCAT_URL}
sudo tar -xzvf ./apache-tomcat-${TOMCAT_VERSION}.tar.gz
sudo mv ./apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
sudo mv ./apache-tomcat-${TOMCAT_VERSION}.tar.gz /usr/local/src/
```

# tomcat用ユーザ作成
sudo useradd -s /sbin/nologin tomcat
sudo chown -R tomcat:tomcat /opt/tomcat

# ユーザ一覧確認
cat /etc/passwd

# tomcat, java設定
sudo vim /etc/profile
------------------------------------------------------------------------------
export JAVA_HOME=/usr/java/jdk1.8.0_91
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export CATALINA_HOME=/opt/tomcat
------------------------------------------------------------------------------
. /etc/profile


# tomcatのsystemdファイル作成
sudo vim /usr/lib/systemd/system/tomcat.service
--------------------------------------------------------------------
[Unit]
Description=Apache Tomcat 8
After=network.target

[Service]
Type=oneshot
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
ExecReload=/opt/tomcat/bin/shutdown.sh ; /opt/tomcat/bin/startup.sh
RemainAfterExit=yes:

[Install]
WantedBy=multi-user.target
--------------------------------------------------------------------

# httpd, tomcat, mariadb 起動・自動起動設定・確認
sudo systemctl start httpd
sudo systemctl start tomcat
sudo systemctl start mariadb

sudo systemctl enable httpd
sudo systemctl enable tomcat
sudo systemctl enable mariadb

sudo systemctl is-enabled httpd
sudo systemctl is-enabled tomcat
sudo systemctl is-enabled mariadb


# ファイアーウォールを動かした状態でtomcat のアクセスを可能にする(permanentは鯖再起動後も有効にする)
firewall-cmd --list-all
firewall-cmd --permanent --add-service=http
#firewall-cmd --permanent --remove-service=http
cat /etc/firewalld/zones/public.xml
systemctl restart firewalld
firewall-cmd --list-all


sudo vim /opt/tomcat/conf/server.xml
-----------------------------------------------------------------------
# 下記記述があるか確認
<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />

# Apache → Tomcat経由のアクセスにするため、8080番ポートを閉じる
<!--
  <Connector port="8080" protocol="HTTP/1.1"
  connectionTimeout="20000"
  redirectPort="8443" />
-->
-----------------------------------------------------------------------

# apacheと連携に必要なモジュールがあるか確認
# WebSocketと連携に必要なモジュールがあるか確認
rpm -ql httpd | grep mod_proxy.
----------------------
mod_proxy.so
mod_proxy_ajp.so
mod_proxy_wstunnel.so
----------------------

# コメントアウトされてたら外す
vim /etc/httpd/conf.modules.d/00-proxy.conf
-----------------------------------------------------------------------
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
LoadModule proxy_wstunnel_module modules/mod_proxy_wstunnel.so
-----------------------------------------------------------------------

# apache↔tomcatの連携設定
sudo mkdir /etc/httpd/conf/extra
# http://133.130.106.123/で呼び出されたときは、ajp://133.130.106.123:8009/に移しますという意味
cat << EOS > /etc/httpd/conf/extra/httpd-proxy.conf
<Location / >
  ProxyPass ajp://192.168.33.10:8009/
</Location>
EOS
cat /etc/httpd/conf/extra/httpd-proxy.conf

# httpd.conf に httpd-proxy.confを読み込ませる
echo "Include /etc/httpd/conf/extra/httpd-proxy.conf" >> /etc/httpd/conf/httpd.conf

#権限を渡す
chown apache:apache /etc/httpd/conf/extra/httpd-proxy.conf

# WebSocketに関する記述追加
sed -e "1i <Location /examples/websocket/ >" -i /etc/httpd/conf/extra/httpd-proxy.conf
sed -e "2i ProxyPass ws://192.168.33.10:8080/examples/websocket/" -i /etc/httpd/conf/extra/httpd-proxy.conf
sed -e "3i ProxyPassReverse ws://192.168.33.10:8080/examples/websocket/" -i /etc/httpd/conf/extra/httpd-proxy.conf
sed -e "4i </Location>" -i /etc/httpd/conf/extra/httpd-proxy.conf
cat /etc/httpd/conf/extra/httpd-proxy.conf


# httpd
*/etc/httpd/conf/httpd.conf*
```
; .htaccessの許可
<Directory "/var/www/html">
    AllowOverride All
</Directory>

; htmlで指定するから不要
AddDefaultCharset none
```

*/etc/httpd/conf.d/autoindex.conf*
```
; iconsディレクトリのファイル一覧を非表示
<Directory "/usr/share/httpd/icons">
    Options MultiViews
</Directory>
```

/etc/httpd/conf.modules.d/*.conf
```
まだなし
```


# tomcat,httpd再起動
sudo systemctl restart tomcat
sudo systemctl restart httpd

```
