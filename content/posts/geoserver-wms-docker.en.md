---
title: "Publishing WMS Image Services with GeoServer on Docker"
description: "Complete tutorial on deploying GeoServer with Docker and publishing WMS/WMTS image services, including data preparation, service configuration, RESTful API usage, and QGIS testing"
keywords: ["GeoServer", "WMS", "WMTS", "Docker", "GIS", "Image Services", "RESTful API"]
author: "Arkin"
date: 2023-06-08T15:00:00+08:00
lastmod: 2025-09-23T01:58:16+08:00
draft: false
tags: ["GeoServer", "Docker", "GIS", "WMS", "WMTS"]
categories: ["GIS", "Docker", "Web Services"]
aliases: []
image: "img/featured-image.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> This article provides a comprehensive guide on deploying GeoServer with Docker and publishing WMS/WMTS image services. It covers the complete workflow from environment setup to service publishing, including both web interface operations and RESTful API automation.

## 1. GeoServer Environment Setup

### 1.1 Download and Run GeoServer Image

```bash
# Pull GeoServer image
docker pull kartoza/geoserver

# Run container with port mapping
docker run -d -p 8888:8080 --name geoserver kartoza/geoserver:latest

# Enter container to check configuration
docker exec -it geoserver /bin/bash
```

**Default Login Credentials:**

- Username: `admin`
- Password: `geoserver`

### 1.2 Data Preparation and Mounting

```bash
# Copy image data to container
docker cp /path/to/your/images geoserver:/opt/geoserver/data_dir/gwc

# Or use data volume mounting (recommended)
docker run -d -p 8888:8080 \
  -v /host/data:/opt/geoserver/data_dir \
  --name geoserver kartoza/geoserver:latest
```

## 2. GeoServer Core Concepts

### 2.1 Workspaces

**Functions of Workspaces:**

- **Data Organization**: Organize related data resources together
- **Namespace Isolation**: Avoid naming conflicts between different data sources
- **Access Control**: Set different access control policies for different workspaces
- **Centralized Management**: Manage data resources at workspace level
- **Service Configuration**: Configure different service parameters for each workspace

**Creating a Workspace:**

1. Log into GeoServer Web interface
2. Go to `Workspaces` → `Add new workspace`
3. Fill in workspace name and namespace URI
4. Save configuration

### 2.2 DataStore

**Functions of DataStore:**

- **Connect External Data Sources**: Support databases, file systems, WFS services, etc.
- **Data Import**: Import external data into GeoServer
- **Data Management**: Add, delete, update datasets and layers
- **Data Query**: Perform spatial and attribute queries through standard interfaces
- **Service Publishing**: Publish data as WMS, WFS, WCS services

**Supported Data Source Types:**

- **Raster Data**: GeoTIFF, ImagePyramid, ImageMosaic, WorldImage
- **Vector Data**: Shapefile, GeoPackage, PostGIS, MySQL, etc.
- **Other Formats**: ArcGrid, NetCDF, etc.

### 2.3 Layers

**Functions of Layers:**

- **Data Visualization**: Visualize and present geographic data on maps
- **Data Filtering**: Define spatial and attribute filtering conditions
- **Geographic Analysis**: Provide foundation for spatial queries and analysis
- **Style Definition**: Control data display effects and styles
- **Service Publishing**: Serve as core objects for geographic service publishing

## 3. Publishing Image Services

### 3.1 Publishing GeoTIFF Images

**Steps:**

1. **Create Workspace** (if not already created)
2. **Create New Data Store**:
   - Select `GeoTIFF` type
   - Configure data source path
   - Set workspace
3. **Publish Layer**:
   - Configure layer name and title
   - Set spatial reference system
   - Define bounding box extent
   - Configure style parameters

### 3.2 Publishing ImagePyramid

**Advantages of ImagePyramid:**

- Support multi-resolution images
- Improve access performance for large data volumes
- Automatically handle display at different zoom levels

**Configuration Points:**

- Ensure image data is organized in pyramid structure
- Correctly set spatial reference system
- Configure appropriate cache parameters

### 3.3 Publishing GeoPackage

**GeoPackage Features:**

- Lightweight database format
- Support both raster and vector data
- Easy data distribution and sharing

## 4. WMS and WMTS Services

### 4.1 WMS (Web Map Service)

**WMS Features:**

- Dynamically generate map images
- Support multiple output formats
- Suitable for small data volumes or real-time data

**WMS Request Example:**

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

**Parameter Description:**

- `service=WMS`: Specify service type
- `version=1.1.0`: WMS version
- `request=GetMap`: Request type
- `layers`: Layer name
- `bbox`: Bounding box coordinates
- `width/height`: Output image dimensions
- `srs`: Spatial reference system
- `format`: Output format

### 4.2 WMTS (Web Map Tile Service)

**WMTS Features:**

- Pre-generated tile cache
- Fast access speed
- Suitable for large data volume images

**WMTS Request Example:**

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

**Parameter Description:**

- `Request=GetTile`: Request tile
- `tilematrixset`: Tile matrix set
- `TileMatrix`: Zoom level
- `TileCol/TileRow`: Tile column and row numbers

## 5. QGIS Testing

### 5.1 Loading WMS Service

1. Open QGIS
2. Right-click layer panel → `Add Layer` → `Add WMS/WMTS Layer`
3. Click `New` to create new connection
4. Enter service URL and connection name
5. Select layer and add to map

### 5.2 Loading WMTS Service

1. In `Add WMS/WMTS Layer` dialog, select `WMTS` tab
2. Enter WMTS service URL
3. Select layer and style
4. Add to map

### 5.3 Loading WFS Service

1. Select `Add WFS Layer`
2. Enter WFS service URL
3. Select feature type
4. Add to map

## 6. RESTful API Automation

### 6.1 Publishing Image Service Workflow

#### Create Raster Data Store

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/coveragestores
Content-Type: application/json

{
    "coverageStore": {
        "name": "Data Store Name",
        "type": "GeoTIFF",
        "enabled": true,
        "url": "file:data/images/",
        "description": "Description",
        "workspace": {
            "name": "Workspace Name"
        }
    }
}
```

#### Publish Raster Data

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/coveragestores/{cs}/coverages
Content-Type: application/json

{
    "coverage": {
        "name": "coverage name",
        "title": "Title",
        "description": "Description",
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

#### Create Tile Service

```bash
POST http://localhost:8080/geoserver/gwc/rest/seed/{ws}:{layer}.json
Content-Type: application/json

{
    "seedRequest": {
        "name": "Layer Name",
        "gridSetId": "EPSG:4326",
        "zoomStart": 0,
        "zoomStop": 15,
        "format": "image/png",
        "type": "seed",
        "threadCount": 4
    }
}
```

### 6.2 Publishing Vector Feature Service

#### Create Vector Data Store

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/datastores
Content-Type: application/json

{
    "dataStore": {
        "name": "Vector Store Name",
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
            "name": "Workspace Name"
        }
    }
}
```

#### Publish Vector Features

```bash
POST http://localhost:8080/geoserver/rest/workspaces/{ws}/datastores/{ds}/featuretypes
Content-Type: application/json

{
    "featureType": {
        "name": "Feature Type Name",
        "nativeName": "Native Name",
        "title": "Title",
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

## 7. Grid Image Services

### 7.1 Feasibility Analysis

**Technical Principles:**

- Obtain image stream data through HTTP requests
- Support dynamic acquisition (WMS) and static acquisition (WMTS)
- Frontend generates level and row/column information based on display extent

**Advantages:**

- Simple data management
- Low redundancy
- Good integrity

**Challenges:**

- Not compliant with OGC standards
- Difficult to promote
- Requires custom client

### 7.2 Tile Calculation

**EPSG:4326 Tile Rules:**

```python
# Calculate tile resolution
resolution = 360 / (2 ** level)

# Calculate longitude and latitude range
minLon = x * resolution * 256 - 180
maxLon = (x + 1) * resolution * 256 - 180
maxLat = 90 - y * resolution * 256
minLat = 90 - (y + 1) * resolution * 256
```

**Tile File Structure:**

```text
EPSG_4326_{level}/
├── {row}_{col}/
│   └── {x}_{y}.png
```

## 8. Best Practices and Considerations

### 8.1 Performance Optimization

- **Data Preprocessing**: Pre-generate tile cache
- **Cache Strategy**: Reasonably configure cache parameters
- **Resource Limits**: Set appropriate thread count and memory limits
- **Network Optimization**: Use CDN to accelerate tile access

### 8.2 Security Considerations

- **Access Control**: Configure user permissions and roles
- **Network Security**: Use HTTPS for encrypted transmission
- **Data Protection**: Regularly backup important data

### 8.3 Monitoring and Maintenance

- **Log Monitoring**: Regularly check service logs
- **Performance Monitoring**: Monitor service response time
- **Data Updates**: Establish data update mechanisms

## Reference Resources

- [GeoServer Official Documentation](https://docs.geoserver.org/)
- [OGC WMS Standard Specification](https://www.osgeo.cn/doc_ogcstd/ogc_standard/ch08_chapter7/chapter.html)
- [OGC WMTS Standard Specification](https://www.osgeo.cn/doc_ogcstd/ogc_standard/ch10_chapter9/chapter.html)
- [GeoServer REST API Documentation](https://www.osgeo.cn/geoserver-user-manual/rest/index.html#rest)

---

*This article is compiled based on actual project experience, covering the complete workflow of GeoServer deployment, configuration, and usage. Feel free to discuss if you have any questions.*
