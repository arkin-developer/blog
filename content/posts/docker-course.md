---
title: "Docker 笔记"
description: "Docker-Course的详细描述，包含关键词和核心内容概述"
keywords: ["关键词1", "关键词2", "关键词3"]
date: 2021-10-23T01:31:03+08:00
lastmod: 2021-10-23T01:31:03+08:00
draft: false
tags: ["Docker", "容器技术", "教程", "运维"]
categories: ["技术"]
aliases: []
image: "img/featured-image.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> 本文基于多年 Docker 实践经验，系统梳理了从基础概念到生产部署的完整知识体系。涵盖镜像原理、容器编排、数据持久化、网络配置等核心技术，并结合实际项目案例，提供可复用的最佳实践方案。适合 Docker 初学者快速入门，也适合有经验的开发者作为技术参考手册。

## 1. Docker 基础概念

### 1.1 三个核心对象详解

#### 镜像（Image）

Docker 镜像类似于一个模板，可以通过这个模板来创建容器服务。例如：`tomcat` 镜像 → `run` → `tomcat01` 容器（提供服务器）。通过一个镜像可以创建多个容器，最终服务运行或者项目运行就是在容器中。

**特点：**

- 轻量级、可执行的独立软件包
- 包含运行某个软件所需的所有内容：代码、运行时、库、环境变量和配置文件
- 所有应用都可以打包成镜像，直接运行起来

#### 容器（Container）

Docker 利用容器技术，独立运行一个或者一组应用，通过镜像来创建。容器具有启动、停止、删除等基本命令，可以简单理解为一个简易的 Linux 系统。

**容器特点：**

- 基于镜像创建
- 具备完整的生命周期管理
- 相互隔离，互不影响
- 可快速启动和销毁

#### 仓库（Repository）

镜像的存放地方，类似于 Git，分为公有仓库和私有仓库。

**常见仓库：**

- Docker Hub（默认国外）
- 阿里云镜像服务
- 私有仓库

### 1.2 Docker 运行流程图

```text
Dockerfile → Docker 镜像 → Docker 容器 → 运行服务
```

### 1.3 与虚拟机的区别（为何更快）

**Docker 优势：**

- 复用宿主机内核，无需 Guest OS
- 比虚拟机少了更多的抽象层
- 启动更快、资源开销更低
- 容器间共享操作系统内核

**传统虚拟机：**

- 每个虚拟机都有完整的操作系统
- 资源开销大，启动慢
- 完全隔离但效率较低

## 2. 安装与环境检查

安装略。安装完成后可用以下命令自检：

```bash
docker version   # 版本信息
docker info      # 系统信息（镜像/容器数量等）
```

参考文档：

- 官方参考手册: <https://docs.docker.com/reference/>

## 3. 常用命令速查

### 3.1 镜像相关

```bash
# 列出镜像
docker images            
docker images -a         # 所有
docker images -q         # 仅 ID

# 搜索镜像
docker search mysql      
docker search --filter stars=50 mysql

# 拉取镜像
docker pull mysql        # 默认 latest
docker pull mysql:5.7

# 删除镜像
docker rmi <IMAGE_ID>
docker rmi -f $(docker images -aq)  # 全删（谨慎）
```

### 3.2 容器相关

```bash
# 基本运行
docker run [OPTIONS] IMAGE
# 常用参数：
# --name <NAME>   容器名
# -d              后台运行
# -it             交互终端
# -p 8080:80      端口映射（宿主:容器）
# -P              随机映射端口

# 示例
docker run -it centos /bin/bash
exit                           # 退出并停止
# 或 Ctrl+P, Ctrl+Q            # 退出但不停止

# 查看容器
docker ps                      # 运行中
docker ps -a                   # 包含历史
docker ps -q                   # 仅 ID

# 启停删
docker start <CONTAINER_ID>
docker stop <CONTAINER_ID>
docker restart <CONTAINER_ID>
docker kill <CONTAINER_ID>
docker rm <CONTAINER_ID>
docker rm -f $(docker ps -aq)  # 删除所有（谨慎）

# 日志/进程/元数据
docker logs -f --tail=100 <CONTAINER_ID>
docker top <CONTAINER_ID>
docker inspect <CONTAINER_ID>

# 进入运行中的容器
docker exec -it <CONTAINER_ID> /bin/bash   # 新开终端（常用）
docker attach <CONTAINER_ID>               # 附着当前终端

# 宿主机与容器间拷贝
docker cp <CONTAINER_ID>:/path/in/container /host/path
docker cp /host/path <CONTAINER_ID>:/path/in/container
```

### 3.3 提交容器为镜像

```bash
docker commit -a "author" -m "message" <CONTAINER_ID> <REPO>:<TAG>
```

### 3.4 镜像导入导出

```bash
docker save -o image.tar <IMAGE[:TAG]>   # 导出镜像
docker load -i image.tar                 # 导入镜像
```

## 4. 镜像原理与分层

### 4.1 UnionFS（联合文件系统）

联合文件系统是一种分层、轻量并且高性能的文件系统，它支持对文件系统的修改作为一次提交来一层层叠加，同时可以将不同目录挂载到同一个虚拟文件系统下。联合文件系统是 Docker 镜像的基础，镜像可以通过分层来进行继承。

**特性：**

- 一次同时加载多个文件系统
- 从外面看起来，只能看到一个文件系统
- 联合加载会把各层文件系统叠加起来
- 最终的文件系统会包含所有底层的文件和目录

### 4.2 Docker 镜像加载原理

Docker 的镜像实际上由一层一层的文件系统组成，这种层级的文件系统叫联合文件系统（UnionFS）。

**镜像分层结构：**

1. **bootfs（boot file system）**
   - 主要包含 bootloader 和 kernel
   - Linux 刚启动时会加载 bootfs 文件系统
   - 在 Docker 镜像的最底层是 bootfs
   - 当 boot 加载完成之后整个内核就在内存中了

2. **rootfs（root file system）**
   - 在 bootfs 之上
   - 包含典型 Linux 系统中的 `/dev`、`/proc`、`/bin`、`/etc` 等标准目录和文件
   - rootfs 就是各种不同的操作系统发行版，比如 Ubuntu、CentOS 等

### 4.3 镜像分层的好处

**资源共享：**

- 很多镜像都是根据 Base 镜像构建而来的
- 宿主机只需在磁盘上保留一份 base 镜像
- 内存中也只需要加载一份 base 镜像
- 可以为所有的容器服务，镜像的每一层都可以被共享

**查看镜像分层：**

```bash
docker image inspect redis
# 查看 "RootFS" 部分的 "Layers" 数组
```

**理解分层：**

- 所有的 Docker 镜像都起始于一个基础镜像层
- 当进行修改或增加新的内容时，就会在当前镜像层之上，创建新的镜像层
- 例如：基于 Ubuntu Linux 16.04 创建新镜像 → 添加 Python 包 → 添加安全补丁，形成 3 个镜像层

**重要特点：**

- Docker 的镜像都是只读的
- 当容器启动时，一个新的可写层就被加载到镜像的顶部
- 这一层就是容器层，容器层之下的都是镜像层

## 5. 数据管理：卷与挂载

### 5.1 为什么需要数据卷

**Docker 理念回顾：**

- Docker 将应用和环境打包成镜像
- 如果数据在容器中，删除容器，数据就会丢失
- 需求：数据可持续化
- 例如 MySQL，如果容器删除了，数据怎么办？

**解决方案：**

- 容器之间可以有一个数据共享的技术
- Docker 容器中产生的数据，同步到本地
- 这就是卷技术！目录的挂载，将容器内的目录，挂载到 Linux 上面
- 做到容器的持久化和同步操作，容器间也是可以数据共享的

### 5.2 使用数据卷

#### 方式一：直接使用命令来挂载 -v

```bash
# 基本语法
docker run -it -v 主机目录:容器内目录

# 测试示例
docker run -it -v /home/test:/home centos /bin/bash

# 通过 docker inspect 容器id 查看详细信息
# 其中 "Mounts" 节点有容器的挂载信息
```

**特点：**

- 容器停止后，宿主机挂载目录文件更新后，重新启动容器，依然会同步数据
- 挂载后，可以直接在宿主机上修改数据，不用再进入容器

#### 方式二：通过 Dockerfile 的方式生成镜像

```dockerfile
FROM centos
VOLUME ["volume01","volume02"]
CMD echo "------------end------------"
CMD /bin/bash
```

构建镜像：

```bash
docker build -f /path/to/dockerfile -t my-centos:1.0 .
```

### 5.3 卷类型详解

#### 匿名挂载

```bash
# 只写容器内路径，没有写容器外的路径
docker run -d -P --name nginx01 -v /etc/nginx nginx
```

#### 具名挂载

```bash
# 使用 -v 卷名:容器路径
docker run -d -P --name nginx02 -v juming:/etc/nginx nginx
```

#### 指定路径挂载

```bash
# 使用 -v /宿主机路径:容器内路径
docker run -d -P --name nginx03 -v /home/nginx:/etc/nginx nginx
```

**如何区分：**

- `-v 容器内路径` → 匿名挂载
- `-v 卷名:容器内路径` → 具名挂载
- `-v /宿主机路径:容器内路径` → 指定路径挂载

**查看卷信息：**

```bash
docker volume ls                    # 列出所有卷
docker volume inspect <VOLUME_NAME> # 查看卷详细信息
```

**Docker 容器所有的卷，没有指定目录的情况下都是放在 `/var/lib/docker/volumes/xxx/_data`**

### 5.4 卷的读写权限

```bash
# 通过 -v 容器内路径:ro rw，可以设置读写权限
# ro  read only  # 只读
# rw  read write # 可读写，默认

# 一旦设置容器权限，容器对我们挂载出来的内容就有限定了
docker run -d -P --name nginx04 -v juming-nginx:/etc/nginx:ro nginx
docker run -d -P --name nginx05 -v juming-nginx:/etc/nginx:rw nginx

# ro 证明这个路径容器内无法写入，只能通过宿主机来读写
```

### 5.5 实战：运行 MySQL 并持久化

```bash
# 下载 mysql
docker pull mysql

# 运行容器，进行多个目录挂载
# -d 后台运行
# -p 端口映射
# -v 卷挂载
# -e 环境配置
# --name 容器名称
docker run --name mysql01 \
  -e MYSQL_ROOT_PASSWORD=12345678 \
  -p 3310:3306 \
  -v /home/mysql/conf:/etc/mysql/conf.d \
  -v /home/mysql/data:/var/lib/mysql \
  -d mysql

# 运行成功后，可以用 SQLyog 来测试一下
# 尽管删除容器，挂载目录的数据还是不会丢失
```

### 5.6 数据卷容器

多个容器同步数据，实现数据共享。

**测试数据卷容器：**

```bash
# 运行容器
docker run -it --name docker01 my-centos:1.0

# 创建 docker02 容器，挂载 docker01 的数据卷
docker run -it --name docker02 --volumes-from docker01 my-centos:1.0

# 在 docker01 中创建一个新的文件，查看 docker02 是否同步
# 测试结果证明同步的，而后删除掉 docker01 这个容器，查看 docker02 中文件是否还在
docker rm -f docker01

# 测试结果发现 docker02 中，刚才 docker01 创建的文件依然存在
# 测试证明，Docker 中的容器的数据共享类似于拷贝的形式，而不是单纯的读取共享卷中的数据
```

**多个 MySQL 实现数据共享：**

```bash
# 创建共享容器
docker run --name mysql01 \
  -e MYSQL_ROOT_PASSWORD=12345678 \
  -p 3310:3306 \
  -v /home/mysql/conf:/etc/mysql/conf.d \
  -v /home/mysql/data:/var/lib/mysql \
  -d mysql

# 加上 --volumes-from mysql01
docker run --name mysql02 \
  -e MYSQL_ROOT_PASSWORD=12345678 \
  -p 3311:3306 \
  --volumes-from mysql01 \
  -d mysql

# 这个时候，两个容器实现数据同步
```

**结论：**

- 容器之间配置信息的传递，数据卷容器的生命周期一直持续到没有使用容器为止
- 但一旦挂载宿主机，这个时候，尽管容器被全部删除，本地的数据也不会丢失

## 6. Dockerfile：从脚本到镜像

Dockerfile 是用来构建 Docker 镜像的文件！命令参数脚本！

### 6.1 Dockerfile 构建过程

**构建步骤：**

1. 编写一个 dockerfile 文件
2. `docker build` dockerfile 文件构建为一个镜像
3. `docker run` 运行镜像
4. `docker push` 发布镜像（Docker Hub、阿里云镜像）

**Dockerfile 构建过程：**

- 每个保留关键字（指令）都是必须是大写字母
- 执行从上到下顺序执行
- `#` 表示注释
- 每一个指令都会创建提交一个新的镜像层

### 6.2 Dockerfile 指令详解

```dockerfile
FROM               # 基础镜像，一切从这里开始构建
MAINTAINER         # 镜像是谁写的，姓名+邮箱
RUN                # 镜像构建的时候需要运行的命令
ADD                # 步骤：tomcat镜像，这个tomcat压缩包！添加内容
WORKDIR            # 镜像的工作目录
VOLUME             # 挂载的目录
EXPOSE             # 保留端口配置
CMD                # 指定这个容器启动的时候要运行的命令，只有最后一个会生效，可被替代
ENTRYPOINT         # 指定这个容器启动的时候要运行的命令，可以追加命令
ONBUILD            # 当构建一个被继承 DockerFile 这个时候就会运行ONBUILD 的指令。触发指令。
COPY               # 类似于ADD，将我们文件拷贝到镜像中
ENV                # 构建的时候设置环境变量
```

### 6.3 实战测试：创建自己的 CentOS

DockerHub 中绝大多数的镜像都是从这个基础镜像创建的 `FROM scratch`，然后配置需要的软件和配置来进行构建。

**创建一个自己的 centos：**

```dockerfile
FROM centos
MAINTAINER dahongdou<1299136522@qq.com>

ENV MYPATH /usr/local
# 进入容器内默认的路径
WORKDIR $MYPATH
# 添加vim 和 ifconfig
RUN yum -y install vim
RUN yum -y install net-tools

EXPOSE 80

CMD echo $MYPATH
CMD echo "----end----"
CMD /bin/bash
```

**构建镜像：**

```bash
# 命令 docker build -f dockerfile路径 -t 镜像名[:tag] .(这个点一定要)
docker build -f /path/to/dockerfile -t my-centos:1.0 .
```

### 6.4 CMD 和 ENTRYPOINT 命令的区别

通过写两个 DockerFile 文件去构建一个 centos 镜像，理解一下 CMD 与 ENTRYPOINT 的异同。

**CMD 示例：**

```dockerfile
FROM centos
CMD ["ls","-a"]
```

构建并测试：

```bash
docker build -f dockerfile-cmd -t cmdtest .
docker run cmdtest
# 直接执行了 CMD 命令

# 想追加一个命令，-l 在CMD的情况下，替换了CMD命令的【-l,-a】，需要完整的输入
docker run cmdtest -l
# 错误：docker: Error response from daemon: OCI runtime create failed...

# CMD情况下的正确输入方式，需要完全写全
docker run cmdtest ls -al
```

**ENTRYPOINT 示例：**

```dockerfile
FROM centos
ENTRYPOINT ["ls","-a"]
```

构建并测试：

```bash
docker build -f dockerfile-entrypoint -t entrypointtest .
docker run entrypointtest
# 返回结果和CMD的一样

# 尝试追加命令 -l
docker run entrypointtest -l
# 成功！可以直接从命令行追加-l
```

**区别总结：**

- `CMD`：指定这个容器启动的时候要运行的命令，只有最后一个会生效，可被替代
- `ENTRYPOINT`：指定这个容器启动的时候要运行的命令，可以追加命令

### 6.5 实战一：构建 Tomcat 镜像

**准备文件：**

- tomcat 压缩包
- jdk 安装包

**编写 Dockerfile：**

```dockerfile
FROM centos
MAINTAINER dahongdou<1299136522@qq.com>

COPY readme.txt /usr/local/readme.txt

ADD jdk-8u301-linux-aarch64.tar.gz /usr/local/
ADD apache-tomcat-9.0.54.tar.gz /usr/local/

RUN yum -y install vim

ENV MYPATH /usr/local
WORKDIR $MYPATH

ENV JAVA_HOME /usr/local/jdk1.8.0_301
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.54
ENV CATALINA_BASE /usr/local/apache-tomcat-9.0.54
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin

EXPOSE 8080

CMD /usr/local/apache-tomcat-9.0.54/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.54/logs/catalina.out
```

**构建镜像：**

```bash
# 使用 docker build 构建镜像
# 不用输入参数-f，会自动找该目录下 Dockerfile 的文件
docker build -t diytomcat .
```

### 6.6 实战二：深度学习环境打包

**需求：** 将深度学习项目打包为镜像进行交付

**Dockerfile 示例：**

```dockerfile
# 基础镜像选择 cuda:10.0 的 ubuntu16.04
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
# 镜像作者
MAINTAINER dahongdou<1299136522@qq.com>
# 定义 SHELL 地址
SHELL ["/bin/bash","-c"]
# 设置一个工作目录
WORKDIR /usr/local/workspace
# 把 python 安装包和软件拷贝到镜像内
COPY ./Python-3.7.11.tgz /usr/local/workspace
COPY ./pytorch_segmentation4CD /usr/local/workspace
# 更换镜像源地址，加速安装
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
COPY ./sources.list /etc/apt/sources.list
RUN mkdir /root/.pip
RUN echo -e '[global] \nindex-url = https://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf
# 安装 ssh
RUN apt-get update
RUN apt-get -y install openssh-server
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
# 安装依赖
RUN apt-get -y install build-essential
RUN apt-get -y install python-dev
RUN apt-get -y install python-setuptools
RUN apt-get -y install python-pip
RUN apt-get -y install python-smbus
RUN apt-get -y install libncursesw5-dev
RUN apt-get -y install libgdbm-dev
RUN apt-get -y install libc6-dev
RUN apt-get -y install zlib1g-dev
RUN apt-get -y install libsqlite3-dev
RUN apt-get -y install tk-dev
RUN apt-get -y install libssl-dev
RUN apt-get -y install openssl
RUN apt-get -y install libffi-dev
# 执行 python 安装操作   
RUN tar xvf Python-3.7.11.tgz
RUN cd Python-3.7.11 && ./configure --prefix=/usr/local/python3.7 && make altinstall
# 建立软链接
RUN ln -snf /usr/local/python3.7/bin/python3.7 /usr/bin/python3
RUN ln -snf /usr/local/python3.7/bin/pip3.7 /usr/bin/pip3
# 安装 pytorch 
RUN pip3 install torch===1.2.0 torchvision===0.4.0 -f https://download.pytorch.org/whl/torch_stable.html
# 安装 requirements.txt 里的依赖
RUN cd pytorch_segmentation4CD && pip3 install -r requirements.txt

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
```

## 7. 实战清单

### 7.1 Nginx 一键起容器

```bash
docker pull nginx
docker run -d --name nginx01 -p 3344:80 nginx
```

### 7.2 Tomcat 快速测试

```bash
docker run -it --rm tomcat:9.0
```

### 7.3 Elasticsearch 单机（限制内存示例）

```bash
docker run -d --name es \
  -p 9200:9200 -p 9300:9300 \
  -e "discovery.type=single-node" \
  -e ES_JAVA_OPTS="-Xms256m -Xmx512m" \
  elasticsearch:7.6.2
```

## 8. 发布镜像

### 8.1 推送到 Docker Hub（示意）

```bash
docker login -u <username>
docker tag local-image <username>/<repo>:<tag>
docker push <username>/<repo>:<tag>
```

### 8.2 推送到阿里云镜像服务（示意）

```bash
docker login --username=<your_aliyun_username> registry.cn-<region>.aliyuncs.com
docker tag local-image registry.cn-<region>.aliyuncs.com/<namespace>/<repo>:<tag>
docker push registry.cn-<region>.aliyuncs.com/<namespace>/<repo>:<tag>
```

## 9. Docker 网络入门

### 9.1 Docker 网络基本了解

**查看网络接口：**

```bash
ip addr
# 1: lo: <LOOPBACK,UP,LOWER_UP> - 本机回环地址
# 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> - 阿里云内网地址
# 3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> - docker0地址
```

**容器网络访问：**

```bash
# 创建 tomcat01
docker run -d -P --name tomcat01 tomcat

# 查看容器内部网络地址 ip addr，发现容器启动时会得到一个 eth0@if262 ip地址，docker分配的
docker exec -it tomcat01 ip addr
```

### 9.2 容器互联 --link

**场景思考：** 当我们编写了一个微服务，database url=ip:，项目不重启，数据库 ip 换掉了，我们希望可以解决这个问题，可以通过名字来访问容器，实现高可用！

```bash
# 直接用 tomcat01 ping tomcat02 是否可以 ping 通？
docker exec -it tomcat01 ping tomcat02

# 结果发现是 ping 不通的

# 创建一个 tomcat03，通过 --link 来连接 tomcat01
docker run -d -P --name tomcat03 --link tomcat01 tomcat
```

### 9.3 自定义网络

**创建自定义网络：**

```bash
docker network create mynet --subnet 172.18.0.0/16
```

**使用自定义网络：**

```bash
docker run -d --name r1 --net mynet --ip 172.18.0.11 redis:6
docker run -d --name r2 --net mynet --ip 172.18.0.12 redis:6
```

### 9.4 实战：部署 Redis 集群

```bash
# 创建一个 redis 网卡
docker network create redis --subnet 172.38.0.0/16

# 通过脚本创建 6 个 redis 配置
for port in $(seq 1 6);
do \
mkdir -p /mydata/redis/node-${port}/conf
touch /mydata/redis/node-${port}/conf/redis.conf
cat << EOF >/mydata/redis/node-${port}/conf/redis.conf
port 6379
bind 0.0.0.0
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 172.38.0.1${port}
cluster-announce-port 6379
cluster-announce-bus-port 16379
appendonly yes
EOF
done

# 启动 6 个 redis 容器
for port in $(seq 1 6);
do \
docker run -p 637${port}:6379 -p 1637${port}:16379 --name redis-${port} \
-v /mydata/redis/node-${port}/data:/data \
-v /mydata/redis/node-${port}/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.1${port} redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf; \
done

# 创建集群
redis-cli --cluster create 172.38.0.11:6379 172.38.0.12:6379 172.38.0.13:6379 172.38.0.14:6379 172.38.0.15:6379 172.38.0.16:6379 --cluster-replicas 1
```

## 10. 学习建议与避坑

### 10.1 核心学习路径

**四大核心概念：**

- 镜像（Image）：模板，只读
- 容器（Container）：运行实例，可写层
- 卷（Volume）：数据持久化
- 网络（Network）：容器通信

**学习顺序建议：**

1. 先掌握基本命令：`docker run`、`docker ps`、`docker images`
2. 理解镜像分层原理
3. 掌握数据卷挂载
4. 学习 Dockerfile 构建
5. 了解网络配置

### 10.2 常见避坑指南

**容器运行问题：**

- 后台运行必须有前台进程，否则容器会立即退出
- 常见错误：`docker run -d centos` 会立即停止，因为没有前台进程

**数据管理：**

- 谨慎使用"全量删除"类命令，执行前先用 `docker ps`/`docker images` 确认
- 在生产中优先使用具名卷与显式的主机路径挂载，避免数据找不到
- 容器删除前确保重要数据已挂载到宿主机

**镜像构建：**

- Dockerfile 中每个指令都会创建新的镜像层，尽量合并 RUN 指令
- 使用 `.dockerignore` 文件排除不必要的文件
- 选择合适的基础镜像，避免镜像过大

**网络配置：**

- 默认情况下容器间无法直接通信，需要创建自定义网络
- 使用 `--link` 是过时的方式，推荐使用自定义网络

### 10.3 生产环境最佳实践

**安全：**

- 不要在镜像中存储敏感信息（密码、密钥等）
- 使用非 root 用户运行容器
- 定期更新基础镜像

**性能：**

- 合理设置容器资源限制（CPU、内存）
- 使用多阶段构建减小镜像大小
- 优化 Dockerfile 层缓存

**监控：**

- 使用 `docker stats` 监控容器资源使用
- 配置日志轮转，避免日志文件过大
- 设置容器健康检查

### 10.4 常用命令速查

```bash
# 镜像管理
docker images                    # 列出镜像
docker rmi <image_id>           # 删除镜像
docker build -t <name> .        # 构建镜像

# 容器管理
docker ps -a                    # 列出所有容器
docker rm <container_id>        # 删除容器
docker logs <container_id>      # 查看日志
docker exec -it <container_id> /bin/bash  # 进入容器

# 数据卷管理
docker volume ls                # 列出卷
docker volume inspect <volume>  # 查看卷详情

# 网络管理
docker network ls               # 列出网络
docker network create <name>    # 创建网络
```

## 参考与延伸

- 官方参考手册: <https://docs.docker.com/reference/>

---

*感谢阅读，欢迎交流与反馈。*

*我的邮箱📮 arkin-dev@qq.com（需要交流请发邮件）。*

