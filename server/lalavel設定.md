## ☆☆Composer インストール☆☆
```
# composerのインストーラーを取得し、php で実行
sudo curl -sS https://getcomposer.org/installer | php

# composerコマンドを通す
sudo mv composer.phar /usr/local/bin/composer

# composerコマンドが通っていることを確認
which composer

# update
#composer update
#composer self-update
```

.
## ☆☆Laravel インストール☆☆
```
# laravelのインストーラー取得
composer global require "laravel/installer"

# laravelのパスを通す
sudo vim /etc/profile
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
export PATH=$PATH:$HOME/.composer/vendor/bin
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
. /etc/profile

# pear 及び pear依存モジュール
sudo yum install --enablerepo=remi,remi-php70 php-pear php-devel

# pearのバージョン確認(1.10.0以降であること)
pear -V

# pecl依存モジュール
sudo yum -y install zlib-devel gcc

# zip拡張インストール
sudo pecl install zip

# zip関数を使用できるようにする
sudo vim /etc/php.ini
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
extension=zip.so
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐

# インストール先ディレクトリ作成し、移動
cd /var/www/html/

laravel new app01root

# project blog を作成
sudo chmod 777 /var/www/html
composer create-project laravel/laravel app01root --prefer-dist
```

## ☆☆基本設定☆☆
```
vim config/app.php
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
'timezone' => 'Asia/Tokyo',
'locale' => 'ja',
‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐
```


## ☆☆基本知識☆☆
**前提**
カレントディレクトリ： /var/www/html/appRoot

・Model関連
app/

・View関連
resource/views

・Controller関連
app/Http/Controllers

・Database関連
database/
