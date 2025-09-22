---
title: "Docker Notes"
description: "Detailed description of Docker-Course, containing keywords and core content overview"
keywords: ["keyword1", "keyword2", "keyword3"]
date: 2021-10-23T01:31:03+08:00
lastmod: 2025-09-23T01:31:03+08:00
draft: false
tags: ["tag1", "tag2"]
categories: ["category1", "category2"]
aliases: []
image: "img/featured-image.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> This article is based on years of Docker practical experience, systematically organizing a complete knowledge system from basic concepts to production deployment. It covers core technologies such as image principles, container orchestration, data persistence, and network configuration, combined with real project cases to provide reusable best practice solutions. Suitable for Docker beginners to get started quickly, and also suitable for experienced developers as a technical reference manual.

## 1. Docker Basic Concepts

### 1.1 Three Core Objects Explained

#### Image

Docker images are similar to templates that can be used to create container services. For example: `tomcat` image → `run` → `tomcat01` container (providing server). Multiple containers can be created from one image, and ultimately services or projects run in containers.

**Features:**

- Lightweight, executable independent software packages
- Contains everything needed to run software: code, runtime, libraries, environment variables, and configuration files
- All applications can be packaged into images and run directly

#### Container

Docker uses container technology to independently run one or a group of applications, created through images. Containers have basic commands like start, stop, delete, and can be simply understood as a simplified Linux system.

**Container Features:**

- Created based on images
- Complete lifecycle management
- Isolated from each other, no mutual interference
- Can be quickly started and destroyed

#### Repository

The storage location for images, similar to Git, divided into public and private repositories.

**Common Repositories:**

- Docker Hub (default foreign)
- Alibaba Cloud Image Service
- Private repositories

### 1.2 Docker Runtime Flow Diagram

```text
Dockerfile → Docker Image → Docker Container → Running Service
```

### 1.3 Differences from Virtual Machines (Why Faster)

**Docker Advantages:**

- Reuses host kernel, no Guest OS needed
- Fewer abstraction layers than virtual machines
- Faster startup, lower resource overhead
- Containers share operating system kernel

**Traditional Virtual Machines:**

- Each virtual machine has a complete operating system
- High resource overhead, slow startup
- Complete isolation but lower efficiency

## 2. Installation and Environment Check

Installation is omitted. After installation, you can use the following commands for self-check:

```bash
docker version   # Version information
docker info      # System information (number of images/containers, etc.)
```

Reference Documentation:

- Official Reference Manual: <https://docs.docker.com/reference/>

## 3. Common Commands Quick Reference

### 3.1 Image Related

```bash
# List images
docker images            
docker images -a         # All
docker images -q         # Only IDs

# Search images
docker search mysql      
docker search --filter stars=50 mysql

# Pull images
docker pull mysql        # Default latest
docker pull mysql:5.7

# Delete images
docker rmi <IMAGE_ID>
docker rmi -f $(docker images -aq)  # Delete all (use with caution)
```

### 3.2 Container Related

```bash
# Basic run
docker run [OPTIONS] IMAGE
# Common parameters:
# --name <NAME>   Container name
# -d              Run in background
# -it             Interactive terminal
# -p 8080:80      Port mapping (host:container)
# -P              Random port mapping

# Examples
docker run -it centos /bin/bash
exit                           # Exit and stop
# or Ctrl+P, Ctrl+Q            # Exit but don't stop

# View containers
docker ps                      # Running
docker ps -a                   # Including history
docker ps -q                   # Only IDs

# Start/Stop/Delete
docker start <CONTAINER_ID>
docker stop <CONTAINER_ID>
docker restart <CONTAINER_ID>
docker kill <CONTAINER_ID>
docker rm <CONTAINER_ID>
docker rm -f $(docker ps -aq)  # Delete all (use with caution)

# Logs/Process/Metadata
docker logs -f --tail=100 <CONTAINER_ID>
docker top <CONTAINER_ID>
docker inspect <CONTAINER_ID>

# Enter running container
docker exec -it <CONTAINER_ID> /bin/bash   # New terminal (commonly used)
docker attach <CONTAINER_ID>               # Attach to current terminal

# Copy between host and container
docker cp <CONTAINER_ID>:/path/in/container /host/path
docker cp /host/path <CONTAINER_ID>:/path/in/container
```

### 3.3 Commit Container as Image

```bash
docker commit -a "author" -m "message" <CONTAINER_ID> <REPO>:<TAG>
```

### 3.4 Image Import/Export

```bash
docker save -o image.tar <IMAGE[:TAG]>   # Export image
docker load -i image.tar                 # Import image
```

## 4. Image Principles and Layering

### 4.1 UnionFS (Union File System)

Union File System is a layered, lightweight, and high-performance file system that supports modifications to the file system as commits that can be stacked layer by layer, while mounting different directories to the same virtual file system. Union File System is the foundation of Docker images, and images can inherit through layering.

**Features:**

- Load multiple file systems simultaneously
- From the outside, only one file system can be seen
- Union loading stacks the file systems of each layer
- The final file system contains all files and directories from underlying layers

### 4.2 Docker Image Loading Principles

Docker images are actually composed of layered file systems, and this hierarchical file system is called Union File System (UnionFS).

**Image Layered Structure:**

1. **bootfs (boot file system)**
   - Mainly contains bootloader and kernel
   - Linux loads bootfs file system when starting up
   - bootfs is at the bottom layer of Docker images
   - After boot loading is complete, the entire kernel is in memory

2. **rootfs (root file system)**
   - Above bootfs
   - Contains standard directories and files in typical Linux systems: `/dev`, `/proc`, `/bin`, `/etc`, etc.
   - rootfs is various different operating system distributions, such as Ubuntu, CentOS, etc.

### 4.3 Benefits of Image Layering

**Resource Sharing:**

- Many images are built based on Base images
- Host only needs to keep one base image on disk
- Only one base image needs to be loaded in memory
- Can serve all containers, every layer of the image can be shared

**View Image Layers:**

```bash
docker image inspect redis
# Check the "Layers" array in the "RootFS" section
```

**Understanding Layers:**

- All Docker images start with a base image layer
- When modifications or additions are made, new image layers are created on top of the current image layer
- For example: Create new image based on Ubuntu Linux 16.04 → Add Python packages → Add security patches, forming 3 image layers

**Important Features:**

- Docker images are read-only
- When a container starts, a new writable layer is loaded on top of the image
- This layer is the container layer, everything below are image layers

## 5. Data Management: Volumes and Mounts

### 5.1 Why Data Volumes Are Needed

**Docker Philosophy Review:**

- Docker packages applications and environments into images
- If data is in containers, deleting containers will lose data
- Requirement: Data persistence
- For example, MySQL, what if the container is deleted?

**Solution:**

- Containers can have a data sharing technology
- Data generated in Docker containers is synchronized to local
- This is volume technology! Directory mounting, mounting directories inside containers to Linux
- Achieves container persistence and synchronization operations, containers can also share data

### 5.2 Using Data Volumes

#### Method 1: Direct Command Mounting -v

```bash
# Basic syntax
docker run -it -v host_directory:container_directory

# Test example
docker run -it -v /home/test:/home centos /bin/bash

# Check detailed information through docker inspect container_id
# The "Mounts" node has container mount information
```

**Features:**

- After container stops, when host mount directory files are updated, restarting the container will still synchronize data
- After mounting, data can be directly modified on the host without entering the container

#### Method 2: Generate Images Through Dockerfile

```dockerfile
FROM centos
VOLUME ["volume01","volume02"]
CMD echo "------------end------------"
CMD /bin/bash
```

Build image:

```bash
docker build -f /path/to/dockerfile -t my-centos:1.0 .
```

### 5.3 Volume Types Explained

#### Anonymous Mount

```bash
# Only write container internal path, no host path
docker run -d -P --name nginx01 -v /etc/nginx nginx
```

#### Named Mount

```bash
# Use -v volume_name:container_path
docker run -d -P --name nginx02 -v juming:/etc/nginx nginx
```

#### Specified Path Mount

```bash
# Use -v /host_path:container_path
docker run -d -P --name nginx03 -v /home/nginx:/etc/nginx nginx
```

**How to Distinguish:**

- `-v container_path` → Anonymous mount
- `-v volume_name:container_path` → Named mount
- `-v /host_path:container_path` → Specified path mount

**View Volume Information:**

```bash
docker volume ls                    # List all volumes
docker volume inspect <VOLUME_NAME> # View volume detailed information
```

**All Docker container volumes are placed in `/var/lib/docker/volumes/xxx/_data` when no directory is specified**

### 5.4 Volume Read/Write Permissions

```bash
# Through -v container_path:ro rw, can set read/write permissions
# ro  read only  # Read only
# rw  read write # Read/write, default

# Once container permissions are set, containers have limitations on mounted content
docker run -d -P --name nginx04 -v juming-nginx:/etc/nginx:ro nginx
docker run -d -P --name nginx05 -v juming-nginx:/etc/nginx:rw nginx

# ro proves this path cannot be written in container, only host can read/write
```

### 5.5 Practical: Run MySQL with Persistence

```bash
# Download mysql
docker pull mysql

# Run container with multiple directory mounts
# -d background run
# -p port mapping
# -v volume mount
# -e environment configuration
# --name container name
docker run --name mysql01 \
  -e MYSQL_ROOT_PASSWORD=12345678 \
  -p 3310:3306 \
  -v /home/mysql/conf:/etc/mysql/conf.d \
  -v /home/mysql/data:/var/lib/mysql \
  -d mysql

# After successful run, can test with SQLyog
# Even if container is deleted, mounted directory data won't be lost
```

### 5.6 Data Volume Container

Multiple containers synchronize data to achieve data sharing.

**Test Data Volume Container:**

```bash
# Run container
docker run -it --name docker01 my-centos:1.0

# Create docker02 container, mount docker01's data volume
docker run -it --name docker02 --volumes-from docker01 my-centos:1.0

# Create a new file in docker01, check if docker02 synchronizes
# Test results prove synchronization, then delete docker01 container, check if files still exist in docker02
docker rm -f docker01

# Test results show files created by docker01 still exist in docker02
# Test proves Docker container data sharing is similar to copy form, not simply reading shared volume data
```

**Multiple MySQL Data Sharing:**

```bash
# Create shared container
docker run --name mysql01 \
  -e MYSQL_ROOT_PASSWORD=12345678 \
  -p 3310:3306 \
  -v /home/mysql/conf:/etc/mysql/conf.d \
  -v /home/mysql/data:/var/lib/mysql \
  -d mysql

# Add --volumes-from mysql01
docker run --name mysql02 \
  -e MYSQL_ROOT_PASSWORD=12345678 \
  -p 3311:3306 \
  --volumes-from mysql01 \
  -d mysql

# At this point, two containers achieve data synchronization
```

**Conclusion:**

- Configuration information transfer between containers, data volume container lifecycle continues until no containers use it
- But once mounted to host, even if all containers are deleted, local data won't be lost

## 6. Dockerfile: From Script to Image

Dockerfile is used to build Docker images! Command parameter scripts!

### 6.1 Dockerfile Build Process

**Build Steps:**

1. Write a dockerfile file
2. `docker build` dockerfile file into an image
3. `docker run` run the image
4. `docker push` publish image (Docker Hub, Alibaba Cloud Image)

**Dockerfile Build Process:**

- Each reserved keyword (instruction) must be uppercase
- Execute from top to bottom in order
- `#` indicates comments
- Each instruction creates and commits a new image layer

### 6.2 Dockerfile Instructions Explained

```dockerfile
FROM               # Base image, everything starts building from here
MAINTAINER         # Who wrote the image, name + email
RUN                # Commands that need to run when building the image
ADD                # Step: tomcat image, this tomcat compressed package! Add content
WORKDIR            # Image working directory
VOLUME             # Mounted directory
EXPOSE             # Reserved port configuration
CMD                # Commands to run when container starts, only the last one takes effect, can be replaced
ENTRYPOINT         # Commands to run when container starts, can append commands
ONBUILD            # When building an inherited DockerFile, ONBUILD instructions will run. Trigger instruction.
COPY               # Similar to ADD, copy our files to the image
ENV                # Set environment variables when building
```

### 6.3 Practical Test: Create Your Own CentOS

Most images in DockerHub are created from this base image `FROM scratch`, then configured with required software and configurations for building.

**Create your own centos:**

```dockerfile
FROM centos
MAINTAINER dahongdou<1299136522@qq.com>

ENV MYPATH /usr/local
# Enter container default path
WORKDIR $MYPATH
# Add vim and ifconfig
RUN yum -y install vim
RUN yum -y install net-tools

EXPOSE 80

CMD echo $MYPATH
CMD echo "----end----"
CMD /bin/bash
```

**Build Image:**

```bash
# Command docker build -f dockerfile_path -t image_name[:tag] .(this dot is required)
docker build -f /path/to/dockerfile -t my-centos:1.0 .
```

### 6.4 CMD and ENTRYPOINT Command Differences

Build a centos image through writing two DockerFile files to understand the similarities and differences between CMD and ENTRYPOINT.

**CMD Example:**

```dockerfile
FROM centos
CMD ["ls","-a"]
```

Build and test:

```bash
docker build -f dockerfile-cmd -t cmdtest .
docker run cmdtest
# Directly executes CMD command

# Want to append a command, -l in CMD case replaces CMD command [-l,-a], need complete input
docker run cmdtest -l
# Error: docker: Error response from daemon: OCI runtime create failed...

# Correct input method in CMD case, need to write completely
docker run cmdtest ls -al
```

**ENTRYPOINT Example:**

```dockerfile
FROM centos
ENTRYPOINT ["ls","-a"]
```

Build and test:

```bash
docker build -f dockerfile-entrypoint -t entrypointtest .
docker run entrypointtest
# Returns same result as CMD

# Try to append command -l
docker run entrypointtest -l
# Success! Can directly append -l from command line
```

**Difference Summary:**

- `CMD`: Commands to run when container starts, only the last one takes effect, can be replaced
- `ENTRYPOINT`: Commands to run when container starts, can append commands

### 6.5 Practical 1: Build Tomcat Image

**Prepare Files:**

- tomcat compressed package
- jdk installation package

**Write Dockerfile:**

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

**Build Image:**

```bash
# Use docker build to build image
# Don't need to input parameter -f, will automatically find Dockerfile file in this directory
docker build -t diytomcat .
```

### 6.6 Practical 2: Deep Learning Environment Packaging

**Requirement:** Package deep learning project as image for delivery

**Dockerfile Example:**

```dockerfile
# Base image choose cuda:10.0 ubuntu16.04
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
# Image author
MAINTAINER dahongdou<1299136522@qq.com>
# Define SHELL address
SHELL ["/bin/bash","-c"]
# Set a working directory
WORKDIR /usr/local/workspace
# Copy python installation package and software to image
COPY ./Python-3.7.11.tgz /usr/local/workspace
COPY ./pytorch_segmentation4CD /usr/local/workspace
# Change mirror source address for faster installation
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
COPY ./sources.list /etc/apt/sources.list
RUN mkdir /root/.pip
RUN echo -e '[global] \nindex-url = https://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf
# Install ssh
RUN apt-get update
RUN apt-get -y install openssh-server
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
# Install dependencies
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
# Execute python installation operation   
RUN tar xvf Python-3.7.11.tgz
RUN cd Python-3.7.11 && ./configure --prefix=/usr/local/python3.7 && make altinstall
# Create soft links
RUN ln -snf /usr/local/python3.7/bin/python3.7 /usr/bin/python3
RUN ln -snf /usr/local/python3.7/bin/pip3.7 /usr/bin/pip3
# Install pytorch 
RUN pip3 install torch===1.2.0 torchvision===0.4.0 -f https://download.pytorch.org/whl/torch_stable.html
# Install dependencies in requirements.txt
RUN cd pytorch_segmentation4CD && pip3 install -r requirements.txt

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
```

## 7. Practical Checklist

### 7.1 Nginx One-Click Container Start

```bash
docker pull nginx
docker run -d --name nginx01 -p 3344:80 nginx
```

### 7.2 Tomcat Quick Test

```bash
docker run -it --rm tomcat:9.0
```

### 7.3 Elasticsearch Single Node (Memory Limit Example)

```bash
docker run -d --name es \
  -p 9200:9200 -p 9300:9300 \
  -e "discovery.type=single-node" \
  -e ES_JAVA_OPTS="-Xms256m -Xmx512m" \
  elasticsearch:7.6.2
```

## 8. Publish Images

### 8.1 Push to Docker Hub (Example)

```bash
docker login -u <username>
docker tag local-image <username>/<repo>:<tag>
docker push <username>/<repo>:<tag>
```

### 8.2 Push to Alibaba Cloud Image Service (Example)

```bash
docker login --username=<your_aliyun_username> registry.cn-<region>.aliyuncs.com
docker tag local-image registry.cn-<region>.aliyuncs.com/<namespace>/<repo>:<tag>
docker push registry.cn-<region>.aliyuncs.com/<namespace>/<repo>:<tag>
```

## 9. Docker Network Basics

### 9.1 Docker Network Basic Understanding

**View Network Interfaces:**

```bash
ip addr
# 1: lo: <LOOPBACK,UP,LOWER_UP> - Local loopback address
# 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> - Alibaba Cloud internal network address
# 3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> - docker0 address
```

**Container Network Access:**

```bash
# Create tomcat01
docker run -d -P --name tomcat01 tomcat

# View container internal network address ip addr, find container gets eth0@if262 ip address when starting, assigned by docker
docker exec -it tomcat01 ip addr
```

### 9.2 Container Interconnection --link

**Scenario Thinking:** When we write a microservice, database url=ip:, if the project doesn't restart but database ip changes, we hope to solve this problem, can access containers by name, achieve high availability!

```bash
# Can tomcat01 ping tomcat02 directly?
docker exec -it tomcat01 ping tomcat02

# Results show cannot ping

# Create tomcat03, connect to tomcat01 through --link
docker run -d -P --name tomcat03 --link tomcat01 tomcat
```

### 9.3 Custom Network

**Create Custom Network:**

```bash
docker network create mynet --subnet 172.18.0.0/16
```

**Use Custom Network:**

```bash
docker run -d --name r1 --net mynet --ip 172.18.0.11 redis:6
docker run -d --name r2 --net mynet --ip 172.18.0.12 redis:6
```

### 9.4 Practical: Deploy Redis Cluster

```bash
# Create a redis network card
docker network create redis --subnet 172.38.0.0/16

# Create 6 redis configurations through script
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

# Start 6 redis containers
for port in $(seq 1 6);
do \
docker run -p 637${port}:6379 -p 1637${port}:16379 --name redis-${port} \
-v /mydata/redis/node-${port}/data:/data \
-v /mydata/redis/node-${port}/conf/redis.conf:/etc/redis/redis.conf \
-d --net redis --ip 172.38.0.1${port} redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf; \
done

# Create cluster
redis-cli --cluster create 172.38.0.11:6379 172.38.0.12:6379 172.38.0.13:6379 172.38.0.14:6379 172.38.0.15:6379 172.38.0.16:6379 --cluster-replicas 1
```

## 10. Learning Suggestions and Pitfalls Avoidance

### 10.1 Core Learning Path

**Four Core Concepts:**

- Image: Template, read-only
- Container: Running instance, writable layer
- Volume: Data persistence
- Network: Container communication

**Learning Order Suggestions:**

1. First master basic commands: `docker run`, `docker ps`, `docker images`
2. Understand image layering principles
3. Master data volume mounting
4. Learn Dockerfile building
5. Understand network configuration

### 10.2 Common Pitfall Avoidance Guide

**Container Runtime Issues:**

- Background run must have foreground process, otherwise container will exit immediately
- Common error: `docker run -d centos` will stop immediately because there's no foreground process

**Data Management:**

- Use "full delete" commands with caution, confirm with `docker ps`/`docker images` before execution
- In production, prioritize named volumes and explicit host path mounts to avoid data not found
- Ensure important data is mounted to host before deleting containers

**Image Building:**

- Each instruction in Dockerfile creates new image layer, try to merge RUN instructions
- Use `.dockerignore` file to exclude unnecessary files
- Choose appropriate base images to avoid oversized images

**Network Configuration:**

- By default containers cannot communicate directly, need to create custom networks
- Using `--link` is outdated, recommend using custom networks

### 10.3 Production Environment Best Practices

**Security:**

- Don't store sensitive information in images (passwords, keys, etc.)
- Run containers with non-root users
- Regularly update base images

**Performance:**

- Reasonably set container resource limits (CPU, memory)
- Use multi-stage builds to reduce image size
- Optimize Dockerfile layer caching

**Monitoring:**

- Use `docker stats` to monitor container resource usage
- Configure log rotation to avoid oversized log files
- Set container health checks

### 10.4 Common Commands Quick Reference

```bash
# Image Management
docker images                    # List images
docker rmi <image_id>           # Delete image
docker build -t <name> .        # Build image

# Container Management
docker ps -a                    # List all containers
docker rm <container_id>        # Delete container
docker logs <container_id>      # View logs
docker exec -it <container_id> /bin/bash  # Enter container

# Data Volume Management
docker volume ls                # List volumes
docker volume inspect <volume>  # View volume details

# Network Management
docker network ls               # List networks
docker network create <name>    # Create network
```

## References and Extensions

- Official Reference Manual: <https://docs.docker.com/reference/>
