### 创建管理员用户

默认的 `guest` 用户只能在本地访问。为了安全性和更好的管理，建议创建一个新的管理员用户。

#### 1. 进入 RabbitMQ 容器

```bash
docker exec -it idev-rabbitmq bash
```

#### 2. 创建用户

创建一个用户名为 `admin`，密码为 `admin123` 的用户：

```bash
rabbitmqctl add_user admin admin123
```

#### 3. 设置用户标签

为用户分配 `administrator` 标签，使其具有管理员权限：

```bash
rabbitmqctl set_user_tags admin administrator
```

#### 4. 设置用户权限

为用户设置权限，允许其访问所有虚拟主机（vhost）和资源：

```bash
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
```

#### 5. 删除默认的 `guest` 用户（可选）

为了安全性，建议删除默认的 `guest` 用户：

```bash
rabbitmqctl delete_user guest
```

### 验证部署

1. **访问 RabbitMQ 管理界面**：
    * 打开浏览器，访问 `http://<服务器IP>:15672`
    * 使用新创建的管理员用户（如 `admin`）登录

2. **检查挂载的目录**：
    * 查看 `data`，确认消息数据已保存
    * 查看 `logs`，确认日志文件已保存

3. **测试数据持久化**：
    * 在 RabbitMQ 管理界面中创建队列或发送消息
    * 停止并删除容器：

    ```bash
    docker stop idev-rabbitmq
    docker rm idev-rabbitmq
    ```

    * 重新启动容器，检查队列和消息是否仍然存在

### 常见问题排查

#### 1. 无法访问管理界面

* **检查容器是否运行**：

    ```bash
    docker ps | grep 
    ```

* **检查端口映射**：

    ```bash
    docker port idev-rabbitmq
    ```

* **检查防火墙和安全组**：
  * 确保服务器的防火墙开放了 `15672` 端口。
  * 如果是云服务器，检查安全组规则。

#### 2. 数据未持久化

* **检查挂载目录权限**：

    ```bash
    sudo chmod -R 775 ./data
    sudo chown -R 999:999 ./data
    ```

#### 3. RabbitMQ 管理插件未启用

* **进入容器并启用插件**：

    ```bash
    docker exec -it rabbitmq bash
    rabbitmq-plugins enable rabbitmq_management
    ```

#### 4. `.erlang.cookie` 文件权限问题

如果 RabbitMQ 启动失败并提示 `.erlang.cookie` 文件权限问题，运行以下命令修复：

```bash
sudo chmod 600 ./data/.erlang.cookie
sudo chown 999:999 ./data/.erlang.cookie
```

# 插件

下载地址：http://www.rabbitmq.com/community-plugins.html 
