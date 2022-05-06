# 介绍

idev是一个docker-compose 集合，支持apollo  elk  kafka  mongo mysql nacos  postgres redis rocketmq  xxljob，php,java的一键部署。  
专门为测试环境快速开发设计，简化本地各种环境配置部署。
我将容器环境分为应用运行环境和外部依赖两个部分。
外部依赖如redis,mysql等这些通常一个环境公用一个就好了，不需要每个应用单独起一个，这样可以简化新项目起环境的配置。  
应用运行环境专为应用定制，如php,java等，你可以拷贝应用环境到自己的应用中按需修改。  

# 已完成

- mysql 数据默认存储在`app/mysql57/data`目录
- redis 数据默认存储在`app/redis/data`目录
- postgres sql 数据默认存储在`app/postgres/data`目录
- mongodb
- apollo
- xxljob
- elk
- rocketmq
- kafka
- elasticsearch
- php

# TODO

- 按需配置启用
- 分布式部署
- 统一底层系统和软件源
- 添加调试ping 等调试工具
- jenkins
- java
- python
- golang

# 脚本

allenv 全局配置文件
initenvbyall.py 基于全局配置文件和sample.env 初始化配置
initenv.sh  基于 sample.env 初始化配置
start.sh 启动全部实例
delall.sh 删除全部实例

# 使用

由于总所周知的原因，你在国内使用docker很可能会遇到网络问题，因此我建议你在开始一切之前先设置镜像加速。
如果你遇到问题，以下链接可能可以帮助到你。  
镜像加速：[https://www.runoob.com/docker/docker-mirror-acceleration.html](https://www.runoob.com/docker/docker-mirror-acceleration.html)  

2. 安装docker-compose

```bash
ubuntu:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

macos：
下载app 安装docker 
sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

windows：
下载app 安装docker 
https://github.com/docker/compose/releases
```

2. 环境参数

```bash
为解决不同环境下host.docker.internal  兼容问题需要添加一个名为HOST_IP的环境变量
mac/weindows 下
export HOST_IP=host.docker.internal
linux下 为ip addr show docker0 对应的ip(以下命令在ubuntu 20.4有效，无效可以手动设置)
/etc/bash.bashrc 
export HOST_IP=$(ifconfig|grep -A 5 docker0|grep netmask|awk '{print $2}')
```

3. 启动  可以去各个目录下执行 docker-compose up -d，也可以使用以下脚本一键启动所有容器（除应用环境容器java，php等），建议根据自己需要修改

```bash
yuyq@DESKTOP-SBVLBT5 MINGW64 /e/WorkSpaces/DockerProjects/idev(master)
$ cd idev && chmod -R 777 ./ && sh idev.sh install
Network mongo_mongo  Creating
Network mongo_mongo  Created
Container idev-mongo  Creating
Container idev-mongo  Created
Container idev-mongo  Starting
```

# server

```bash
# phpmyadmin
http://localhost:9901/  
username: root  
password: tiger
# redis admin
http://localhost:9902/

# elk
http://127.0.0.1:5601/
user => "elastic"
password => "changeme"

# apollo
http://localhost:9170
meta:http://localhost:9180
用户名：apollo
密码：admin

# nginx php
http://localhost:801

# xxljob
http://127.0.0.1:8099/xxl-job-admin/toLogin
admin 123456
```

# 启动

```docker
docker-compose up -d  //相当于pull+build+start
docker-compose build
docker-compose pull
docker-compose start
docker-compose stop
docker-compose rm -f
docker-compose ps
```

# 常用命令

## 容器

```docker
docker stats
使用镜列出所有容器
docker ps

使用镜像 nginx:latest，以后台模式启动一个容器,将容器的 80 端口映射到主机的 80 端口,主机的目录 /data 映射到容器的 /data。
docker run -p 80:80 -v /data:/data -d nginx:latest

在容器 mynginx 中以交互模式执行容器内 /root/container.sh 脚本:
docker exec -it mynginx /bin/sh /root/container.sh

删除容器
docker rm -f db01

删除容器 nginx01, 并删除容器挂载的数据卷
docker rm -v nginx01

启动已被停止的容器mycontainer
docker start mycontainer

停止运行中的容器mycontainer
docker stop mycontainer

重启容器mycontainer
docker restart mycontainer

容器查看命令 元数据、端口、日志、top进程信息
docker inspect mysql:5.6
docker port mymysql
docker logs -f mynginx
docker top mymysql
```

## images

```docker
docker images
docker rmi -f container/ubuntu:v4

docker build -t container/ubuntu:v1 . 
docker tag ubuntu:15.10 container/ubuntu:v3
docker save -o my_ubuntu_v3.tar container/ubuntu:v3
docker load < busybox.tar.gz
docker import  my_ubuntu_v3.tar container/ubuntu:v4  

查看本地镜像container/ubuntu:v3的创建历史。
docker history container/ubuntu:v3
```

# 仓库

```
docker login -u 用户名 -p 密码
docker pull java
docker push myapache:v1
docker search  java
```

## 清理

```
删除所有已经停止的容器：
docker rm $(docker ps -a -q)
查看占用
docker system df
清理所有
docker system prune -a
```
