---
title: "ArcGIS Enterprise 10.6 安装教程"
description: "详细的ArcGIS Enterprise 10.6安装步骤指南，包含IIS配置、Server安装、DataStore配置和Portal部署的完整流程"
keywords: ["ArcGIS Enterprise", "安装教程", "GIS服务器", "地理信息系统", "企业级GIS"]
author: "Arkin"
date: 2021-09-23T10:00:00+08:00
lastmod: 2025-01-27T10:00:00+08:00
draft: false
tags: ["ArcGIS", "Enterprise", "安装教程", "GIS服务器", "企业级部署"]
categories: ["GIS地理信息"]
aliases: ["/posts/arcgis-enterprise-installation"]
image: "img/arcgis-enterprise.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> ArcGIS Enterprise 是一个完整的基于服务器的 GIS，可以组织、分析和分发地理信息。本教程将详细介绍 ArcGIS Enterprise 10.6 的完整安装流程，包括环境准备、组件安装和站点配置。

## 准备工作

### 软件下载
- **下载链接**: [百度网盘](https://pan.baidu.com/s/1qtIIC7lbaVU_ZYgL1EeDTA)
- **提取码**: esvb
- **系统要求**: Windows Server 2016 或更高版本

### 系统环境要求
- Windows Server 操作系统
- 至少 8GB 内存
- 足够的磁盘空间用于数据和日志存储
- 网络连接用于许可证验证

## 1. 系统环境配置

### 1.1 计算机名和DNS后缀设置

如果您的计算机组织方式是隶属于"域"而不是"工作组"，可以跳过此步骤。

1. 打开【系统属性】面板，点击【更改】

2. 在【计算机名/域】更改中，点击【其他】

3. 在【DNS后缀和NetBIOS计算机名】面板中，自定义一个域名

![系统属性配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922101322991.png)

4. 设置完成后重启计算机

## 2. IIS 安装和配置

### 2.1 安装 Server Adaptor

安装 IIS 适配器组件：

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\ServerAdaptor\SetupFiles\setup.msi
```

![Server Adaptor安装](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923104548737.png)

### 2.2 配置SSL证书

1. 在 IIS 主页面中打开【服务器证书】

2. 在右侧面板中点击【创建自签名证书】

3. 在【创建自签名证书】面板中设置证书名称

![创建自签名证书](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922103615582.png)

![证书配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922103653920.png)

4. 绑定证书到网站

![证书绑定](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922103922860.png)

![绑定完成](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922104027340.png)

## 3. ArcGIS Server 安装

### 3.1 安装 ArcGIS Server

运行安装程序：

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\Server\SetupFiles\setup.msi
```

**重要提醒**：
- 安装时设置的账号密码要妥善保存
- 确保 ArcGIS Desktop 版本为 10.6
- 选择正确的安装路径

![ArcGIS Server安装](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923113130335.png)

![安装配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922104727499.png)

## 4. ArcGIS DataStore 安装

### 4.1 安装 DataStore

运行安装程序：

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\DataStore\SetupFiles\setup.msi
```

**配置要点**：
- 密码设置与 ArcGIS Server 保持一致
- 选择合适的数据库类型（关系型或时空型）

![DataStore安装](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923113637435.png)

![DataStore配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923113248250.png)

## 5. ArcGIS Portal 安装

### 5.1 安装 Portal for ArcGIS

运行安装程序：

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\Portal\SetupFiles\setup.msi
```

**配置要求**：
- 账号密码与前面组件保持一致
- 配置管理员账户信息

![Portal安装](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923134728720.png)

## 6. 创建 ArcGIS Server 站点

### 6.1 访问管理界面

在浏览器中访问：

```
https://localhost:6443/arcgis/manager/
```

### 6.2 创建新站点

1. 点击【创建新站点】

2. 按照向导逐步配置：
   - 设置站点管理员账户
   - 配置站点目录
   - 设置集群配置

![创建新站点](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922112912842.png)

![站点配置](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922113239599.png)

![配置完成](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923134531389.png)

## 7. 验证安装

### 7.1 检查服务状态

- **ArcGIS Server Manager**: `https://localhost:6443/arcgis/manager/`
- **ArcGIS Portal**: `https://localhost:7443/arcgis/home/`
- **ArcGIS Server REST API**: `https://localhost:6443/arcgis/rest/services/`

### 7.2 功能测试

1. 发布一个测试服务
2. 验证服务可以正常访问
3. 测试 Portal 中的内容管理功能

## 8. 常见问题解决

### 8.1 证书问题

如果遇到 SSL 证书警告：
- 确保自签名证书已正确配置
- 检查证书绑定是否正确
- 在浏览器中添加证书信任

### 8.2 端口冲突

检查以下端口是否被占用：
- 6443 (ArcGIS Server)
- 7443 (Portal)
- 6080 (ArcGIS Server HTTP)
- 6099 (Portal HTTP)

### 8.3 防火墙配置

确保防火墙允许以下端口通信：
- 6443/tcp
- 7443/tcp
- 6080/tcp
- 6099/tcp

## 9. 最佳实践建议

### 9.1 安全配置

- 使用强密码策略
- 定期更新安全补丁
- 配置适当的用户权限
- 启用审计日志

### 9.2 性能优化

- 合理分配服务器资源
- 配置适当的缓存策略
- 监控系统性能指标
- 定期清理日志文件

### 9.3 备份策略

- 定期备份站点配置
- 备份数据存储
- 制定灾难恢复计划
- 测试恢复流程

## 总结

ArcGIS Enterprise 10.6 的安装需要按照特定的顺序进行，确保每个组件都正确配置。通过本教程，您应该能够成功部署一个完整的 ArcGIS Enterprise 环境。

**安装要点回顾**：
1. 系统环境准备和DNS配置
2. IIS 安装和SSL证书配置
3. 按顺序安装 Server、DataStore、Portal
4. 创建和配置 ArcGIS Server 站点
5. 验证安装和功能测试

如果您在安装过程中遇到问题，请参考 ArcGIS Enterprise 官方文档或联系技术支持。

## 相关资源

- [ArcGIS Enterprise 官方文档](https://enterprise.arcgis.com/)
- [ArcGIS Server 管理指南](https://enterprise.arcgis.com/en/server/)
- [Portal for ArcGIS 用户指南](https://enterprise.arcgis.com/en/portal/)
