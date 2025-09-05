#!/usr/bin/env bash

# 获取当前脚本所在目录
CURRENT_DIR=$(
  cd "$(dirname "$0")"
  pwd
)

COMMON_NAME="idev"
# 设置基础路径，如果未定义则使用默认值
IDEV_BASE=${IDEV_BASE:-/opt/idev}

# 基础路径及日志文件
IDEV_INSTALL_ENV="$IDEV_BASE/.env"  # 安装配置文件
IDEV_INSTALL_ENV_EXAMPLE="$IDEV_BASE/.env.example"  # 安装配置文件示例
IDEV_INSTALL_LOG="$IDEV_BASE/install.log"  # 安装日志文件路径
IDEV_INSTALL_LOCK_FILE="$IDEV_BASE/install.lock"  # 安装锁文件路径
IDEV_OFFLINE_PATH="offline"  # 离线安装路径
IDEV_COMPOSE_FILES_PATH="$IDEV_BASE/compose_files"
IDEVCTL_BIN_PATH=/usr/local/bin/idevctl
IDEVRC_PATH=~/.idevrc

#######颜色代码########
COLOR_RED="31m"  # 红色
COLOR_GREEN="32m"  # 绿色
COLOR_YELLOW="33m"  # 黄色
COLOR_BLUE="36m"  # 蓝色
COLOR_FUCHSIA="35m"  # 紫红色
MESSAGE_TITLE="[$COMMON_NAME Log]: $(date +'%Y-%m-%d %H:%M:%S') -"  # 日志标题，包含当前时间

# 获取内网 IP 地址
INTRANET_IP=$(hostname -I | awk '{print $1}')

# -------------------
# 版本信息
# -------------------
DOCKER_COMPOSE_VERSION="2.39.2"  # DockerCompose 版本

SYSTEM_INFO=`uname -a`
# 存储小写的操作系统名称
OS_NAME=$(uname -s | tr A-Z a-z)
# 存储机器硬件名称
MACHINE_TYPE=$(uname -m)

if [[ $SYSTEM_INFO =~ 'Darwin' ]];then
    INTRANET_IP=$(ipconfig getifaddr en0)
fi