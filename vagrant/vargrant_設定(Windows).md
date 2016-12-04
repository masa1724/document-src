
# 下記ソフトのインストール
**virtualbox**
https://www.virtualbox.org/
**vagrant**
https://www.vagrantup.com/downloads.html
**teraterm**
https://osdn.jp/projects/ttssh2/


# centos7.0のboxを追加
>>
vagrant box add centos7.0 https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.1.0/centos-7.0-x86_64.box
vagrant box list

**その他boxはここ見る**
http://www.vagrantbox.es/


# HOMEに仮想マシン用のディレクトリ作成
>>
mkdir %USERPROFILE%\vagrantbox
mkdir %USERPROFILE%\vagrantbox\centos7.0
cd %USERPROFILE%\vagrantbox\centos7.0


# Vagrantfile作成
>>
vagrant init centos7.0


# 下記のipで接続できるようにする。(下記3行目をコメントアウトする)
>>
vim Vagrantfile

**ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー**
 # Create a private network, which allows host-only access to the machine
 # using a specific IP.
config.vm.network "private_network", ip: "192.168.33.10"
**ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー**


# 仮想マシン起動
>>
vagrant up


# teratermで仮想マシンへ接続
ip     : 192.168.33.10
user   : vagrant
passwd : vagrant


==================================================================
> ** vagrantコマンド **
#起動
vagrant up
#停止
vagrant halt
#再起動
vagrant reload
#一時停止
vagrant suspend
#一時停止から起動
vagrant resume
#仮想マシンにログイン
vagrant ssh
#状態確認
vagrant status
#仮想マシンを破棄
vagrant destroy


