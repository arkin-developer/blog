---
title: "ArcGIS Enterprise 10.6 Installation Guide"
description: "Comprehensive installation guide for ArcGIS Enterprise 10.6, including IIS configuration, Server installation, DataStore setup, and Portal deployment"
keywords: ["ArcGIS Enterprise", "Installation Guide", "GIS Server", "Geographic Information System", "Enterprise GIS"]
author: "Arkin"
date: 2021-09-23T10:00:00+08:00
lastmod: 2021-09-23T10:00:00+08:00
draft: false
tags: ["ArcGIS", "Enterprise", "Installation Guide", "GIS Server", "Enterprise Deployment"]
categories: ["GIS Geographic Information"]
aliases: ["/posts/arcgis-enterprise-installation"]
image: "img/arcgis-enterprise.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> ArcGIS Enterprise is a complete server-based GIS that can organize, analyze, and distribute geographic information. This tutorial provides detailed instructions for the complete installation process of ArcGIS Enterprise 10.6, including environment preparation, component installation, and site configuration.

## Prerequisites

### Software Download
- **Download Link**: [Baidu Netdisk](https://pan.baidu.com/s/1qtIIC7lbaVU_ZYgL1EeDTA)
- **Extraction Code**: esvb
- **System Requirements**: Windows Server 2016 or higher

### System Environment Requirements
- Windows Server operating system
- At least 8GB RAM
- Sufficient disk space for data and log storage
- Network connection for license verification

## 1. System Environment Configuration

### 1.1 Computer Name and DNS Suffix Setup

If your computer organization is part of a "domain" rather than a "workgroup", you can skip this step.

1. Open the [System Properties] panel and click [Change]

2. In the [Computer Name/Domain] change dialog, click [Other]

3. In the [DNS suffix and NetBIOS computer name] panel, customize a domain name

![System Properties Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922101322991.png)

4. Restart the computer after configuration

## 2. IIS Installation and Configuration

### 2.1 Install Server Adaptor

Install the IIS adapter component:

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\ServerAdaptor\SetupFiles\setup.msi
```

![Server Adaptor Installation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923104548737.png)

### 2.2 Configure SSL Certificate

1. Open [Server Certificates] in the IIS main page

2. Click [Create Self-Signed Certificate] in the right panel

3. Set the certificate name in the [Create Self-Signed Certificate] panel

![Create Self-Signed Certificate](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922103615582.png)

![Certificate Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922103653920.png)

4. Bind certificate to website

![Certificate Binding](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922103922860.png)

![Binding Complete](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922104027340.png)

## 3. ArcGIS Server Installation

### 3.1 Install ArcGIS Server

Run the installer:

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\Server\SetupFiles\setup.msi
```

**Important Notes**:
- Save the account password set during installation
- Ensure ArcGIS Desktop version is 10.6
- Select the correct installation path

![ArcGIS Server Installation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923113130335.png)

![Installation Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922104727499.png)

## 4. ArcGIS DataStore Installation

### 4.1 Install DataStore

Run the installer:

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\DataStore\SetupFiles\setup.msi
```

**Configuration Points**:
- Password should match ArcGIS Server
- Choose appropriate database type (relational or spatiotemporal)

![DataStore Installation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923113637435.png)

![DataStore Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923113248250.png)

## 5. ArcGIS Portal Installation

### 5.1 Install Portal for ArcGIS

Run the installer:

```
..\ArcGIS_Enterprise_Builder_Windows_106_161855\SetupFiles\Portal\SetupFiles\setup.msi
```

**Configuration Requirements**:
- Account password should match previous components
- Configure administrator account information

![Portal Installation](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923134728720.png)

## 6. Create ArcGIS Server Site

### 6.1 Access Management Interface

Access in browser:

```
https://localhost:6443/arcgis/manager/
```

### 6.2 Create New Site

1. Click [Create New Site]

2. Follow the wizard step by step:
   - Set site administrator account
   - Configure site directory
   - Set cluster configuration

![Create New Site](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922112912842.png)

![Site Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210922113239599.png)

![Configuration Complete](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20210923134531389.png)

## 7. Verify Installation

### 7.1 Check Service Status

- **ArcGIS Server Manager**: `https://localhost:6443/arcgis/manager/`
- **ArcGIS Portal**: `https://localhost:7443/arcgis/home/`
- **ArcGIS Server REST API**: `https://localhost:6443/arcgis/rest/services/`

### 7.2 Function Testing

1. Publish a test service
2. Verify service accessibility
3. Test content management functionality in Portal

## 8. Common Issues and Solutions

### 8.1 Certificate Issues

If you encounter SSL certificate warnings:
- Ensure self-signed certificate is properly configured
- Check certificate binding is correct
- Add certificate trust in browser

### 8.2 Port Conflicts

Check if the following ports are occupied:
- 6443 (ArcGIS Server)
- 7443 (Portal)
- 6080 (ArcGIS Server HTTP)
- 6099 (Portal HTTP)

### 8.3 Firewall Configuration

Ensure firewall allows communication on the following ports:
- 6443/tcp
- 7443/tcp
- 6080/tcp
- 6099/tcp

## 9. Best Practice Recommendations

### 9.1 Security Configuration

- Use strong password policies
- Regularly update security patches
- Configure appropriate user permissions
- Enable audit logging

### 9.2 Performance Optimization

- Properly allocate server resources
- Configure appropriate caching strategies
- Monitor system performance metrics
- Regularly clean log files

### 9.3 Backup Strategy

- Regularly backup site configuration
- Backup data stores
- Develop disaster recovery plans
- Test recovery procedures

## Summary

ArcGIS Enterprise 10.6 installation requires following a specific sequence to ensure each component is properly configured. Through this tutorial, you should be able to successfully deploy a complete ArcGIS Enterprise environment.

**Installation Key Points Recap**:
1. System environment preparation and DNS configuration
2. IIS installation and SSL certificate configuration
3. Install Server, DataStore, Portal in sequence
4. Create and configure ArcGIS Server site
5. Verify installation and function testing

If you encounter issues during installation, please refer to the ArcGIS Enterprise official documentation or contact technical support.

## Related Resources

- [ArcGIS Enterprise Official Documentation](https://enterprise.arcgis.com/)
- [ArcGIS Server Administration Guide](https://enterprise.arcgis.com/en/server/)
- [Portal for ArcGIS User Guide](https://enterprise.arcgis.com/en/portal/)

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
