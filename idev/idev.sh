#!/usr/bin/env bash
action=$1
args=$@

function usage() {
  echo "Idev 控制脚本"
  echo
  echo "Usage: "
  echo "  ./msctl.sh [COMMAND] [ARGS...]"
  echo "  ./msctl.sh --help"
  echo
  echo "Commands: "
  echo "  status    查看 Idev 服务运行状态"
  echo "  start     启动 Idev 服务"
  echo "  stop      停止 Idev 服务"
  echo "  restart   重启 Idev 服务"
  echo "  install   安装 Idev 服务"
  echo "  uninstall 卸载 Idev 服务"
  echo "  init_env 初始化.env"
  echo "  init_sample_env 将修改的.env转为sample"
}

function init_env(){
  for projectname in apollo elasticsearch elk fastdfs  kafka laravel mongo mysql nacos nginxphp postgres redis rocketmq  xxljob;
  do
  (cp -rf $projectname/sample.env  $projectname/.env ;)
  done
}

function init_sample_env(){
  for projectname in apollo elasticsearch elk fastdfs  kafka laravel mongo mysql nacos nginxphp postgres redis rocketmq  xxljob;
  do
  (cp -rf $projectname/.env  $projectname/sample.env ;)
  done
}

function install() {
  for projectname in  mongo mysql apollo xxljob elk nacos  kafka postgres redis rocketmq;
  do(
    cd $projectname;
    docker-compose up -d;)
  done
}

function status() {
  echo
  docker status $(docker ps -a)
}

function start() {
  echo
  docker start $(docker ps -a | awk '{ print $1}' | tail -n +2)
}

function stop() {
  echo
  docker stop $(docker ps -a | awk '{ print $1}' | tail -n +2)
}

function restart() {
  echo
  docker restart $(docker ps -a | awk '{ print $1}' | tail -n +2)
}

function main() {
  case "${action}" in
  status)
    status
    ;;
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  install)
    install
    ;;
  help)
    usage
    ;;
  --help)
    usage
    ;;
  *)
    echo
    $@
    ;;
  esac
}
main $@