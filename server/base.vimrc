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
set listchars=trail:-,extends:?
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


alias la="ls -a"
alias ll="ls -l"
alias ltr="ls -ltr"
alias v="vim"
alias cdmaria="cd /etc/my.cnf.d"
alias cdhttpd="cd /etc/httpd/conf/httpd.conf"
alias cdphp="cd /etc/php.d"
alias vihttpd="sudo vim /etc/httpd/con"
alias viphp="sudo vim /etc/php.ini"
