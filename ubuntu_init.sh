#!/bin/bash
# author:reber0ask@qq.com
# ubuntu-16.04.7-desktop-amd64.iso


setHistory(){
    echo -e "\033[32m==> link history file to /dev/null \033[0m"
    rm .bash_history
    ln -s /dev/null .bash_history
    ln -s /dev/null .viminfo
    ln -s /dev/null .python_history
    ln -s /dev/null .mysql_history
    ln -s /dev/null .psql_history
    ln -s /dev/null .rediscli_history 
}

changeSoruces(){
    echo -e "\033[32m==> change sources.list \033[0m"
    sudo sh -c "cp /etc/apt/sources.list /etc/apt/sources.list.bak"
    sources="deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
# 源码
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
# 测试版源
deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
# 测试版源码
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
# Canonical 合作伙伴和附加
deb http://archive.canonical.com/ubuntu/ xenial partner
#deb http://extras.ubuntu.com/ubuntu/ xenial main"
    sudo sh -c "echo \"$sources\" > /etc/apt/sources.list"

    sudo rm /var/lib/apt/lists/lock
    sudo apt update
    # sudo apt -y upgrade
}

installSoftware(){
    cd /tmp/temp

    echo -e "\033[32m==> install gcc/curl/git/zsh \033[0m"
    sudo apt -y install gcc
    sudo apt -y install curl
    sudo apt -y install git
    sudo apt -y install zsh
    sudo apt -y install libbz2-dev libc6-dev libdb-dev libexpat1-dev libffi-dev libgdbm-dev liblzma-dev libncurses5-dev libpcap-dev libreadline-dev libsqlite3-dev libssl-dev tk-dev xz-utils zlib1g-dev

    echo -e "\033[32m==> install ohmyzsh \033[0m"
    echo y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo -e "alias c='clear'" >> ~/.zshrc

    echo -e "\033[32m==> install vim/tmux/nmap \033[0m"
    sudo apt -y purge vim-common
    sudo apt -y install vim
    sudo apt -y install tmux
    sudo apt -y install nmap

    echo -e "\033[32m==> install masscan \033[0m"
    git clone https://github.com/robertdavidgraham/masscan
    cd masscan
    sudo sh -c "make && make install"
}

setIDE(){
    cd /tmp/temp

    echo -e "\033[32m==> install Python3 \033[0m"
    mkdir /opt/Python-3.9.1
    curl -o Python-3.9.1.tgz https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
    tar zxvf Python-3.9.1.tgz
    cd Python-3.9.1
    ./configure --prefix=/opt/Python-3.9.1 --with-ssl
    sudo sh -c "make && make install"
    mv /usr/bin/python3 /usr/bin/python3.bak
    ln -s /opt/Python-3.9.1/bin/python3 /usr/bin/python3
    ln -s /opt/Python-3.9.1/bin/pip3 /usr/bin/pip3

    echo -e "\033[32m==> install JDK \033[0m"
    curl -o jdk-8u281-linux-x64.tar.gz https://media.githubusercontent.com/media/reber0/Resources/master/jdk-8u281-linux-x64.tar.gz
    tar -zxvf jdk-8u281-linux-x64.tar.gz -C /opt
    echo -e "export JAVA_HOME=/opt/jdk1.8.0_281" >> ~/.zshrc
    echo -e 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.zshrc
    echo -e 'export CLASSPATH=.:$JAVA_HOME/lib' >> ~/.zshrc
}

setWeb(){
    cd /tmp/temp

    echo -e "\033[32m==> install AMP \033[0m"
    sudo apt -y install apache2
    sudo sh -c "echo \"mysql-server-5.5 mysql-server/root_password password root\" | debconf-set-selections"
    sudo sh -c "echo \"mysql-server-5.5 mysql-server/root_password_again password root\" | debconf-set-selections"
    sudo apt -y install mysql-server
    sudo apt -y install php php-gd php-mysql libapache2-mod-php

    echo -e "install Nginx"
    sudo apt -y install libpcre3 libpcre3-dev openssl libssl-dev
    curl -o nginx-1.18.0.tar.gz http://nginx.org/download/nginx-1.18.0.tar.gz
    tar -zxvf nginx-1.18.0.tar.gz
    cd nginx-1.18.0
    ./configure --prefix=/opt/nginx-1.18.0 --with-http_ssl_module
    sudo sh -c "make && make install"
}

clear(){
    cd /tmp
    rm -rf ./temp

    chsh -s $(which zsh)
    zsh
    source ~/.zshrc
    cd
}

mkdir /tmp/temp
setHistory
changeSoruces
installSoftware
setIDE
setWeb
clear
