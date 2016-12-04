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
# パスワードないユーザでログイン禁止
PermitEmptyPasswords no
# パスワード認証禁止
PasswordAuthentication no
# rootログイン禁止
PermitRootLogin no
Port 10613
----------------------------------
systemctl restart sshd

# firewallのport開ける
firewall-cmd --permanent --add-port=10613/tcp
firewall-cmd --reload

# .vimrc
cat << EOS >> $HOME/.vimrc
set encoding=utf8
set fileencodings=utf-8,euc-jp,iso-2022-jp,ucs-2le,ucs-2,euc-jp,cp932
set fileformats=unix,dos,mac

set noswapfile
set nowritebackup
set nobackup

set number
set ruler
set title
set nostartofline
set matchpairs& matchpairs+=<:>
set showmatch
set matchtime=3
set nowrap
set textwidth=0
set autoindent
set tabstop=2
set listchars=trail:-,extends:≫
set shiftround
set showcmd
set laststatus=2
set cursorline
set statusline+=[%F]
set statusline+=[%{&fileformat}]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline+=%y

set infercase
set ignorecase
set smartcase
set incsearch
set hlsearch
set history=100
set wrapscan

inoremap jk <Esc>
nnoremap j gj
nnoremap k gk
vnoremap h $v
nnoremap gs :<C-u>%s///g<Left><Left><Left>
EOS


# aliases
cat << EOS >> $HOME/.bashrc
alias la="ls -a"
alias ll="ls -l"
alias ltr="ls -ltr"
alias v="vim"
alias cdmaria="cd /etc/my.cnf.d"
alias cdhttpd="cd /etc/httpd/conf/httpd.conf"
alias cdphp="cd /etc/php.d"
alias vihttpd="sudo vim /etc/httpd/con"
alias viphp="sudo vim /etc/php.ini"
EOS


# 日本環境設定
localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf
localectl status

timedatectl set-timezone Asia/Tokyo
timedatectl

sudo yum -y update
sudo yum -y upgrade