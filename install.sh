#!/usr/bin/env bash
source ./common.sh
source ./install_docker.sh

args=$@

# 主程序
main() {
   if [ -f $IDEVRC_PATH ];then
      source $IDEVRC_PATH > /dev/null
   elif [ -f $IDEVCTL_BIN_PATH ];then
      IDEV_BASE=$(cat $IDEVCTL_BIN_PATH | grep IDEV_BASE= | awk -F= '{print $2}' 2>/dev/null)
   else
      IDEV_BASE=$(cat $IDEV_INSTALL_ENV | grep IDEV_BASE= | awk -F= '{print $2}' 2>/dev/null)
   fi

   IDEV_INSTALL_MODE=$(cat $IDEV_BASE/.env | grep IDEV_INSTALL_MODE= | awk -F= '{print $2}' 2>/dev/null)

   mkdir -p $IDEV_BASE
   log "安装目录为 $IDEV_BASE, 开始进行安装"
   
   # 检查安装锁文件是否存在
   if [[ -f "$IDEV_INSTALL_LOCK_FILE" ]]; then
      log "安装锁文件 $IDEV_INSTALL_LOCK_FILE 已存在，退出安装."
      exit 0
   fi

   # 创建安装锁文件并写入内容
   run_command "touch '$IDEV_INSTALL_LOCK_FILE'"
   run_command "echo "安装锁文件创建于 $(date)" > "$IDEV_INSTALL_LOCK_FILE""
   log "创建安装锁文件 $IDEV_INSTALL_LOCK_FILE."
   
   # 检查 IDEV_BASE 是否等于 CURRENT_DIR
   if [ "$IDEV_BASE" != "$CURRENT_DIR" ]; then
      log "拷贝当前目录所有文件到 $IDEV_BASE..."
      run_command "cp -r $CURRENT_DIR/. $IDEV_BASE/"
      log "文件拷贝完成"
   fi

   run_command "cp -f $IDEV_INSTALL_ENV $IDEV_INSTALL_ENV_EXAMPLE"

   # 使用单引号来避免引号冲突
   run_command "sed -i -e 's#KAFKA_HOST=.*#KAFKA_HOST=$INTRANET_IP#g' $IDEV_INSTALL_ENV"

   # 记录Idev安装路径
   run_command "echo 'IDEV_BASE=$IDEV_BASE' > $IDEVRC_PATH"
   # 安装 idevctl 命令
   run_command "cp idevctl /usr/local/bin && chmod +x $IDEVCTL_BIN_PATH"
   run_command "ln -s $IDEVCTL_BIN_PATH /usr/bin/idevctl 2>/dev/null"

   log "======================= 开始安装 Docker ======================="
   execute_and_log "Docker 安装" install_docker
   execute_and_log "服务状态检查" check_service_status
   execute_and_log "Docker Compose 安装" install_docker_compose
   log "======================= Docker 安装完成 ======================="
   
   # 通过加载环境变量的方式保留已修改的配置项，仅添加新增的配置项
   source $IDEVRC_PATH >/dev/null 2>&1
   # 将配置信息存储到安装目录的环境变量配置文件中
   run_command "grep '127.0.0.1 $(hostname)' /etc/hosts >/dev/null || echo '127.0.0.1 $(hostname)' >> /etc/hosts"

   run_command "idevctl generate_compose_files"
   run_command "idevctl config 1>/dev/null 2>/dev/null"
   if [ $? != 0 ];then
      run_command "idevctl config"
      log "docker-compose 版本与配置文件不兼容或配置文件存在问题，请重新安装最新版本的 docker-compose 或检查配置文件"
      exit
   fi
   
   log "启动服务"
   run_command "idevctl down -v"
   run_command "idevctl up -d --remove-orphans"
   run_command "idevctl status"

   log "======================= 安装完成 =======================\n"
   run_command "rm -rf $IDEV_INSTALL_LOCK_FILE"
}

main "$@"
