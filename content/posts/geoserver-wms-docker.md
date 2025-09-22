---
title: "GeoServer 发布 WMS 影像服务 (Docker)"
description: "基于 Docker 部署 GeoServer，发布 WMS/WMTS 影像服务的完整教程，包含数据准备、服务配置、RESTful API 使用和 QGIS 测试"
keywords: ["GeoServer", "WMS", "WMTS", "Docker", "GIS", "影像服务", "RESTful API"]
author: "Arkin"
date: 2023-06-08T15:00:00+08:00
lastmod: 2025-09-23T01:58:12+08:00
draft: false
tags: ["GeoServer", "Docker", "GIS", "WMS", "WMTS"]
categories: ["GIS", "Docker", "Web服务"]
aliases: []
image: "img/featured-image.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> 本文将详细介绍如何使用 Docker 部署 GeoServer，并发布 WMS/WMTS 影像服务。涵盖从环境搭建到服务发布的完整流程，包括 Web 界面操作和 RESTful API 自动化发布。

## 1. GeoServer 环境搭建

### 1.1 下载并运行 GeoServer 镜像

```bash
# 获取 GeoServer 镜像
docker pull kartoza/geoserver

# 运行容器，注意端口映射
docker run -d -p 8888:8080 --name geoserver kartoza/geoserver:latest

# 进入容器查看配置
docker exec -it geoserver /bin/bash
```

**默认登录信息：**

- 账号：`admin`
- 密码：`geoserver`

### 1.2 数据准备与挂载

```bash
# 将影像数据复制到容器内
docker cp /path/to/your/images geoserver:/opt/geoserver/data_dir/gwc

# 或者使用数据卷挂载（推荐）
docker run -d -p 8888:8080 \
  -v /host/data:/opt/geoserver/data_dir \
  --name geoserver kartoza/geoserver:latest
```

## 2. GeoServer 核心概念

### 2.1 Workspaces（工作区）

**工作区的作用：**

- **数据组织**：将相关的数据资源组织在一起
- **命名空间隔离**：避免不同数据源之间的命名冲突
- **权限控制**：为不同工作区设置不同的访问控制策略
- **集中管理**：在工作空间级别进行数据资源的管理和维护
- **服务配置**：为每个工作空间配置不同的服务参数

**创建工作区：**

1. 登录 GeoServer Web 界面
2. 进入 `Workspaces` → `Add new workspace`
3. 填写工作区名称和命名空间 URI
4. 保存配置

### 2.2 DataStore（数据存储）

**数据存储的作用：**

- **连接外部数据源**：支持数据库、文件系统、WFS 服务等
- **数据导入**：将外部数据导入到 GeoServer 中
- **数据管理**：添加、删除、更新数据集和图层
- **数据查询**：通过标准接口进行空间和属性查询
- **服务发布**：将数据发布为 WMS、WFS、WCS 等服务

**支持的数据源类型：**

- **栅格数据**：GeoTIFF、ImagePyramid、ImageMosaic、WorldImage
- **矢量数据**：Shapefile、GeoPackage、PostGIS、MySQL 等
- **其他格式**：ArcGrid、NetCDF 等

### 2.3 Layers（图层）

**图层的作用：**

- **数据可视化**：将地理数据可视化并呈现在地图中
- **数据过滤**：定义空间和属性过滤条件
- **地理分析**：提供空间查询和分析的基础
- **样式定义**：控制数据的显示效果和样式
- **服务发布**：作为地理服务发布的核心对象

## 3. 发布影像服务

### 3.1 发布 GeoTIFF 影像

**步骤：**

1. **创建工作区**（如尚未创建）
2. **新建数据存储**：
   - 选择 `GeoTIFF` 类型
   - 配置数据源路径
   - 设置工作区
3. **发布图层**：
   - 配置图层名称和标题
   - 设置空间参考系统
   - 定义边界框范围
   - 配置样式参数

### 3.2 发布 ImagePyramid

**ImagePyramid 的优势：**

- 支持多分辨率影像
- 提高大数据量影像的访问性能
- 自动处理不同缩放级别的显示

**配置要点：**

- 确保影像数据已按金字塔结构组织
- 正确设置空间参考系统
- 配置合适的缓存参数

### 3.3 发布 GeoPackage

**GeoPackage 特点：**

- 轻量级数据库格式
- 支持栅格和矢量数据
- 便于数据分发和共享

## 4. WMS 和 WMTS 服务

### 4.1 WMS（Web Map Service）

**WMS 特点：**

- 动态生成地图图像
- 支持多种输出格式
- 适合小数据量或实时数据

**WMS 请求示例：**

```http
http://localhost:8080/geoserver/{workspace}/wms?
service=WMS&
version=1.1.0&
request=GetMap&
layers={layer_name}&
bbox={minx,miny,maxx,maxy}&
width={width}&
height={height}&
srs={EPSG:4490}&
styles=&
format=image/png
```

**参数说明：**

- `service=WMS`：指定服务类型
- `version=1.1.0`：WMS 版本
- `request=GetMap`：请求类型
- `layers`：图层名称
- `bbox`：边界框坐标
- `width/height`：输出图像尺寸
- `srs`：空间参考系统
- `format`：输出格式

### 4.2 WMTS（Web Map Tile Service）

**WMTS 特点：**

- 预先生成瓦片缓存
- 访问速度快
- 适合大数据量影像

**WMTS 请求示例：**

```http
http://localhost:8080/geoserver/{workspace}/gwc/service/wmts?
service=WMTS&
version=1.0.0&
Request=GetTile&
layer={layer_name}&
style=&
tilematrixset=EPSG:4326&
Format=image/png&
TileMatrix=EPSG:4326:{zoom}&
TileCol={col}&
TileRow={row}
```

**参数说明：**

- `Request=GetTile`：请求瓦片
- `tilematrixset`：瓦片矩阵集
- `TileMatrix`：缩放级别
- `TileCol/TileRow`：瓦片行列号

## 5. QGIS 测试

### 5.1 加载 WMS 服务

1. 打开 QGIS
2. 右键图层面板 → `Add Layer` → `Add WMS/WMTS Layer`
3. 点击 `New` 创建新连接
4. 输入服务 URL 和连接名称
5. 选择图层并添加到地图

### 5.2 加载 WMTS 服务

1. 在 `Add WMS/WMTS Layer` 对话框中选择 `WMTS` 标签
2. 输入 WMTS 服务 URL
3. 选择图层和样式
4. 添加到地图

### 5.3 加载 WFS 服务

1. 选择 `Add WFS Layer`
2. 输入 WFS 服务 URL
3. 选择要素类型
4. 添加到地图

## 6. RESTful API 自动化发布

### 6.1 发布影像服务流程

#### 创建栅格数据存储

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/coveragestores
Content-Type: application/json

{
    "coverageStore": {
        "name": "数据存储名称",
        "type": "GeoTIFF",
        "enabled": true,
        "url": "file:data/images/",
        "description": "描述",
        "workspace": {
            "name": "工作空间名称"
        }
    }
}
```

#### 发布栅格数据

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/coveragestores/{cs}/coverages
Content-Type: application/json

{
    "coverage": {
        "name": "coverage名称",
        "title": "标题",
        "description": "描述",
        "latLonBoundingBox": {
            "crs": "EPSG:4326",
            "maxx": "110.89222777777778",
            "maxy": "22",
            "minx": "110.6211111111111",
            "miny": "21.533331777777775"
        },
        "nativeBoundingBox": {
            "crs": "EPSG:4490",
            "maxx": "110.89222777777778",
            "maxy": "22",
            "minx": "110.6211111111111",
            "miny": "21.533331777777775"
        }
    }
}
```

#### 创建切片服务

```bash
POST http://localhost:8080/geoserver/gwc/rest/seed/{ws}:{layer}.json
Content-Type: application/json

{
    "seedRequest": {
        "name": "图层名称",
        "gridSetId": "EPSG:4326",
        "zoomStart": 0,
        "zoomStop": 15,
        "format": "image/png",
        "type": "seed",
        "threadCount": 4
    }
}
```

### 6.2 发布矢量要素服务

#### 创建矢量数据存储

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/datastores
Content-Type: application/json

{
    "dataStore": {
        "name": "矢量存储名称",
        "enabled": true,
        "connectionParameters": {
            "entry": [
                {
                    "@key": "database",
                    "$": "file:data/vector.gpkg"
                },
                {
                    "@key": "dbtype",
                    "$": "geopkg"
                }
            ]
        },
        "workspace": {
            "name": "工作空间名称"
        }
    }
}
```

#### 发布矢量要素

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/datastores/{ds}/featuretypes
Content-Type: application/json

{
    "featureType": {
        "name": "要素类型名称",
        "nativeName": "原生名称",
        "title": "标题",
        "srs": "EPSG:4490",
        "nativeBoundingBox": {
            "minx": 110.6044444444439,
            "maxx": 116.921111111111,
            "miny": 21.22555555555599,
            "maxy": 24.79999999999999,
            "crs": "EPSG:4490"
        },
        "enabled": true
    }
}
```

## 7. 网格影像服务

### 7.1 可行性分析

**技术原理：**

- 通过 HTTP 请求获取图像流数据
- 支持动态获取（WMS）和静态获取（WMTS）
- 前端根据显示范围生成层级和行列号信息

**优势：**

- 数据管理简单
- 冗余量少
- 整体性好

**挑战：**

- 不符合 OGC 标准
- 推广困难
- 需要自定义客户端

### 7.2 瓦片计算

**EPSG:4326 切片规则：**

```python
# 计算瓦片分辨率
resolution = 360 / (2 ** level)

# 计算经纬度范围
minLon = x * resolution * 256 - 180
maxLon = (x + 1) * resolution * 256 - 180
maxLat = 90 - y * resolution * 256
minLat = 90 - (y + 1) * resolution * 256
```

**切片文件结构：**

```text
EPSG_4326_{level}/
├── {row}_{col}/
│   └── {x}_{y}.png
```

## 8. 最佳实践与注意事项

### 8.1 性能优化

- **数据预处理**：提前生成瓦片缓存
- **缓存策略**：合理配置缓存参数
- **资源限制**：设置合适的线程数和内存限制
- **网络优化**：使用 CDN 加速瓦片访问

### 8.2 安全考虑

- **访问控制**：配置用户权限和角色
- **网络安全**：使用 HTTPS 加密传输
- **数据保护**：定期备份重要数据

### 8.3 监控与维护

- **日志监控**：定期检查服务日志
- **性能监控**：监控服务响应时间
- **数据更新**：建立数据更新机制

## 参考资源

- [GeoServer 官方文档](https://docs.geoserver.org/)
- [OGC WMS 标准规范](https://www.osgeo.cn/doc_ogcstd/ogc_standard/ch08_chapter7/chapter.html)
- [OGC WMTS 标准规范](https://www.osgeo.cn/doc_ogcstd/ogc_standard/ch10_chapter9/chapter.html)
- [GeoServer REST API 文档](https://www.osgeo.cn/geoserver-user-manual/rest/index.html#rest)

---

*本文基于实际项目经验整理，涵盖了 GeoServer 部署、配置和使用的完整流程。如有疑问，欢迎交流讨论。*
