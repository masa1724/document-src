**Mariadb**
*/etc/my.cnf.d/client.conf*
```
[client]
default-character-set=utf8
```

*/etc/my.cnf.d/server.conf*
```
[mysqld]
character-set-server = utf8
```

# 各種文字コード設定の確認
show global variables like '%char%';

# ログイン
mysql -u root -p
# DB appl01DB　作成
create database appl01DB;
# DB一覧表示
show databases;

# ユーザ master@133.130.106.123 を作成し、パスワードを付加
CREATE USER db01master@133.130.106.123 IDENTIFIED BY 'Kokouya723$';
CREATE USER db01owner@localhost IDENTIFIED BY 'Kokouya723$';

# DB appl01DB に対する全権限与える
grant all on appl01DB.* to db01master@133.130.106.123;
grant all on appl01DB.* to db01owner@localhost;

# ユーザ一覧表示
select user,host,Password from mysql.user;

# 使用するDBを選択
use appl01DB;

# table user_info 作成
create table user_info(id int,name varchar(50));

# table一覧表示
show tables;

# 使用例
insert into test values(1111,'master');
insert into test values(9999,'sgym');
select * from user_info;


# バックアップ
・特定のデータベースを指定してファイルに吐き出す
mysqldump -u root -p ${db_name} > dump.sql

# リストア
・リストア先のデータベースとリストア対象のファイルを指定する
mysql -u root -p ${db_name} < dump.sql