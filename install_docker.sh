#!/usr/bin/env bash
source ./common.sh

# 安装 Docker
install_docker() {
    if which docker >/dev/null; then
        log "检测到 Docker 已安装，跳过安装步骤"
        log "启动 Docker"
        run_command "service docker start"
    else
        if [[ -d docker ]]; then
            log "... 离线安装 docker"
            run_command "chmod +x docker/bin/*"
            run_command "cp docker/bin/* /usr/bin/"
            run_command "cp docker/service/docker.service /etc/systemd/system/"
            run_command "chmod 754 /etc/systemd/system/docker.service"
            log "... 启动 docker"
            run_command "service docker start"
        else
            log "... 在线安装 docker"
            run_command "curl -fsSL https://resource.fit2cloud.com/get-docker-linux.sh -o get-docker.sh"
            run_command "sudo sh get-docker.sh"
            log "... 启动 docker"
            run_command "service docker start"
        fi
    fi
}

# 检查服务状态
check_service_status() {
    docker ps 1>/dev/null 2>/dev/null
    if [ $? != 0 ]; then
        log "Docker 未正常启动，请先安装并启动 Docker 服务后再次执行本脚本"
        exit
    fi
}

# 安装 Docker Compose
install_docker_compose() {
    if which docker-compose >/dev/null; then
        log "检测到 Docker Compose 已安装，跳过安装步骤"
    else
        if [[ -d docker ]]; then
            log "... 离线安装 docker-compose"
            run_command "cp docker/bin/docker-compose /usr/bin/"
            run_command "chmod +x /usr/bin/docker-compose"
        else
            log "... 在线安装 docker-compose"
            run_command "curl -L "https://resource.fit2cloud.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${OS_NAME}-${MACHINE_TYPE}" -o /usr/local/bin/docker-compose"
            run_command "chmod +x /usr/local/bin/docker-compose"
            run_command "ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose"
        fi
    fi
}