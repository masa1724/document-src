# ユーザー作成
adduser sgym2835vps
passwd sgym2835vps
usermod -G wheel sgym2835vps

visudo
----------------------------------
# コメントアウト解除
%wheel ALL=(ALL) ALL
----------------------------------

# 秘密鍵コピー
cp -r /root/.ssh /home/sgym2835vps/
chown sgym2835vps /home/sgym2835vps/.ssh
chown sgym2835vps /home/sgym2835vps/.ssh/authorized_keys

# ssh基本設定
vim /etc/ssh/sshd_config
----------------------------------
# パスワード認証禁止
PasswordAuthentication no
# チャレンジレスポンス認証禁止
ChallengeResponseAuthentication no
# パスワードないユーザでログイン禁止
PermitEmptyPasswords no
# rootログイン禁止
PermitRootLogin no

# SSHポートの変更
Port 10613

# SSHを許可するユーザ(ホワイトリスト)
AllowUsers hogeuser git
# SSHを拒否するユーザ(ブラックリスト)
# DenyUsers web_ap

# SSH接続を許可するグループ
# AllowGroups hogegroup
# SSH接続を拒否するグループ
# DenyGroups fugagroup

# プロトコル2にする
Protocol 2
----------------------------------
systemctl restart sshd

# firewallのport開ける
firewall-cmd --permanent --add-port=10613/tcp
firewall-cmd --reload


# 日本環境設定
localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf
localectl status

timedatectl set-timezone Asia/Tokyo
timedatectl

sudo yum -y update
sudo yum -y upgrade
