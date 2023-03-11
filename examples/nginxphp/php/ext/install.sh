#!/usr/bin/env bash

echo  "
deb http://mirrors.ustc.edu.cn/debian/ buster main non-free contrib
deb-src http://mirrors.ustc.edu.cn/debian/ buster main non-free contrib
deb http://mirrors.ustc.edu.cn/debian-security buster/updates main
deb-src http://mirrors.ustc.edu.cn/debian-security buster/updates main
deb http://mirrors.ustc.edu.cn/debian/ buster-updates main non-free contrib
deb-src http://mirrors.ustc.edu.cn/debian/ buster-updates main non-free contrib
deb http://mirrors.ustc.edu.cn/debian/ buster-backports main non-free contrib
deb-src http://mirrors.ustc.edu.cn/debian/ buster-backports main non-free contrib
" > /etc/apt/sources.list
apt-get update -y


