## ☆☆WEBサーバーに必要なソフトいれよう☆☆

####・php7
```
# epel のyum用リポジトリ追加
sudo yum install epel-release

# remi のyum用リポジトリ追加
sudo rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# remi リポジトリの更新
sudo yum --enablerepo=remi update remi-release
sudo yum --enablerepo=remi-php70 update php\*

# remi パッケージ一覧表示
sudo yum --enablerepo=remi-php70,epel list | grep remi-php70
sudo yum --enablerepo=remi-php70,epel install -y php php-cli php-common php-mbstring php-fpm php-gd php-gmp php-mbstring php-mcrypt php-opcache php-pdo php-xml php-pear php-devel php-mysqlnd

# バージョン確認
php -v
```

####・その他
sudo yum -y install gcc


## ☆☆デーモン起動・自動起動設定☆☆
```
# 起動
sudo systemctl start httpd
sudo systemctl start mariadb.service

# 起動確認
sudo systemctl status httpd
sudo systemctl status mariadb.service

# 自動起動設定
sudo systemctl enable httpd
sudo systemctl enable mariadb.service

# 自動起動設定されているか確認
sudo systemctl is-enabled httpd
sudo systemctl is-enabled mariadb.service
```

## ☆☆ファイアーウォール設定☆☆
```
# 設定状態確認
firewall-cmd --list-all
sudo firewall-cmd --permanent --remove-service=ftp


:::::::::::::
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --remove-port=22/tcp

:::::::::::::



# http, httpsを許可
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --zone=public --add-service=https

# デフォルトで許可されている dhcpv6 を拒否
sudo firewall-cmd --zone=public --remove-service=dhcpv6-client
sudo firewall-cmd --permanent --zone=public --remove-service=dhcpv6-client

#　デーモン再起動
sudo systemctl restart firewalld

# 反映確認
cat /etc/firewalld/zones/public.xml
firewall-cmd --list-all
```

## ☆☆設定ファイル編集☆☆
設定ファイルいじる際は必ずbkを作成する!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!<br>
そうすれば後でdiff確認で編集した部分がわかる!!!!!!!!!!!!!!!!!!!!!!!!
```
例)
sudo cp -p /etc/httpd/conf/httpd.conf{,.bk}
~~~~~~~~~~~~ 編集 ~~~~~~~~~~~~
sudo diff /etc/httpd/conf/httpd.conf{,.bk}
```


####php7
*/etc/php.ini*
```
; ディレクトリ名のみでアクセスできるファイル名を追加
DirectoryIndex index.html index.php

; タイムゾーン指定
date.timezone = "Asia/Tokyo"

; PHP情報をレスポンスヘッダに含めない
expose_php = Off

;エラーログ出力先
error_log = /var/log/php_errors.log

・ファイルアップロードに関連するやつ(必要になったら変える)
memory_limit, max_execution_time, post_max_size, upload_max_filesize
```
