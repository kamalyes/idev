#!/usr/bin/env bash
source ./variables.sh

set -e  # 在发生错误时退出
set -a  # 导出所有变量

function log() {
    message="$MESSAGE_TITLE $1 "
    echo -e "\033[32m## ${message} \033[0m\n" 2>&1 | tee -a ${IDEV_INSTALL_LOG}
}

function color_echo() {
  # 输出带颜色的文本，并同时记录到日志文件
  message="$MESSAGE_TITLE $2 "
  echo -e "\033[$1## ${message} \033[0m\n" 2>&1 | tee -a ${IDEV_INSTALL_LOG}
}

function run_command() {
    local command="$1"
    
    color_echo ${COLOR_GREEN} "Executing command: $command"  # 使用绿色输出命令
    
    # 执行命令并捕获输出和错误
    { 
      eval "$command" 2>&1 | tee -a "${IDEV_INSTALL_LOG}"
    } || {
      color_echo ${COLOR_RED} "Error executing: $command"  # 使用红色输出错误
      return 1  # 返回错误代码
    }
}

# 通用的安装和检查函数
execute_and_log() {
    local command_name="$1"
    shift
    local command="$@"

    if $command; then
        log "${command_name} 成功"
    else
        log "${command_name} 失败"
        exit 1
    fi
}