---
title: "Remote Sensing Satellite Raw Data Guide: GF-2, Landsat-8 and MODIS Data Format Analysis"
description: "Detailed introduction to raw data formats, file structures, and naming conventions of mainstream remote sensing satellites including GF-2, Landsat-8, and MODIS, helping remote sensing practitioners quickly understand satellite data products"
keywords: ["Remote Sensing Satellites", "GF-2", "Landsat-8", "MODIS", "Satellite Data", "Remote Sensing Data Processing"]
author: "Arkin"
date: 2021-10-22T16:00:00+08:00
lastmod: 2021-10-22T16:00:00+08:00
draft: false
tags: ["Remote Sensing", "Satellite Data", "GF-2", "Landsat-8", "MODIS", "Data Format"]
categories: ["GIS Geographic Information"]
aliases: ["/posts/remote-sensing-satellite-data"]
image: "img/remote-sensing-satellite.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Remote sensing satellite data is an important data source in the field of geographic information science and earth observation. This article provides detailed introduction to raw data formats, file structures, and naming conventions of mainstream remote sensing satellites including GF-2, Landsat-8, and MODIS, helping remote sensing practitioners quickly understand and use satellite data products.

## Overview

Remote sensing satellite data includes various types and formats, with different satellites having different data products in terms of file structure, band configuration, and naming conventions. Understanding these differences is crucial for correctly using and processing satellite data.

## I. Remote Sensing Satellite Data File Descriptions

### 1. GF-2 (Gaofen-2) Satellite Data

GF-2 (Gaofen-2) is a high-resolution optical remote sensing satellite independently developed by China, successfully launched on August 19, 2014. The satellite has sub-meter spatial resolution and important application value in land resource surveys, urban planning, environmental monitoring, and other fields.

#### Data File Composition

GF-2 satellite data contains 10 files, including 5 multispectral files (MSS) and 5 panchromatic data files (PAN).

**Taking panchromatic data as an example, each file contains:**

- **2 JPG files**: Thumbnail and quick view of the scene image
- **RPB file**: RPC file containing detailed RPC model parameters for orthorectification
- **TIFF file**: Image file of the scene
- **XML file**: Detailed parameter information (metadata) of the scene image, including:
  - Cloud percentage (CloudPercent)
  - Imaging time (ReceiveTime)
  - Sensor type (SensorID)
  - Scene ID (SceneID)
  - Product level (ProductLevel)

Multispectral data files have the same structure.

![GF-2 Data File Structure](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211009090055160.png)

#### Technical Parameters

- **Spatial Resolution**: Panchromatic 0.8m, Multispectral 3.2m
- **Swath Width**: 45km
- **Revisit Cycle**: 4-6 days
- **Spectral Bands**: Panchromatic band + 4 multispectral bands (Blue, Green, Red, Near-infrared)

### 2. Landsat-8 Satellite Data

On February 11, 2013, NASA successfully launched the Landsat-8 satellite. The Landsat-8 satellite carries two sensors: the OLI (Operational Land Imager) and the TIRS (Thermal Infrared Sensor).

#### Sensor Characteristics

**OLI Characteristics:**
- 9 bands with 185×185km imaging swath
- Bands 1-7, 9-11 have 30m spatial resolution
- Band 8 is a 15m resolution panchromatic band
- Global coverage every 16 days

**Improvements over Landsat-7:**
1. **Band 5**: Band range adjusted to 0.845-0.885μm, excluding water vapor absorption effects at 0.825μm
2. **Band 8**: Narrower panchromatic band range for better vegetation and non-vegetation area distinction
3. **New bands**:
   - Band 1: Blue band (0.433-0.453μm), mainly for coastal zone observation
   - Band 9: Short-wave infrared band (1.360-1.390μm), for cloud detection

**TIRS Thermal Infrared Sensor:**
- Mainly used for collecting heat loss from two thermal zones of Earth
- Aim to understand water consumption in observed areas

![Landsat-8 Data Characteristics](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211009091426869.png)

![Landsat-8 Band Configuration](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211009091445236.png)

### 3. MODIS Sensor Data

MODIS (Moderate Resolution Imaging Spectroradiometer) is an important instrument in the US Earth Observing System (EOS) program for observing global biological and physical processes, carried on Terra and Aqua satellites.

![MODIS Sensor](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211022163718958.png)

#### MODIS Data Band Distribution Characteristics

The MODIS sensor has 36 bands covering the spectral range from visible to thermal infrared:

| Band | Band Range (nm) | SNR | Main Application | Resolution (m) |
|------|-----------------|-----|------------------|----------------|
| 1    | 620-670        | 128 | Land/cloud boundary | 250         |
| 2    | 841-876        | 201 | Land/cloud boundary | 250         |
| 3    | 459-479        | 243 | Land/cloud properties | 500         |
| 4    | 545-565        | 228 | Land/cloud properties | 500         |
| 5    | 1230-1250      | 74  | Land/cloud properties | 500         |
| 6    | 1628-1652      | 275 | Land/cloud properties | 500         |
| 7    | 2105-2155      | 110 | Land/cloud properties | 500         |
| 8    | 405-420        | 880 | Ocean color/phytoplankton/biochemistry | 1000        |
| 9    | 438-448        | 838 | Ocean color/phytoplankton/biochemistry | 1000        |
| 10   | 483-493        | 802 | Ocean color/phytoplankton/biochemistry | 1000        |
| 11   | 526-536        | 754 | Ocean color/phytoplankton/biochemistry | 1000        |
| 12   | 546-556        | 750 | Ocean color/phytoplankton/biochemistry | 1000        |
| 13   | 662-672        | 910 | Ocean color/phytoplankton/biochemistry | 1000        |
| 14   | 673-683        | 1087| Ocean color/phytoplankton/biochemistry | 1000        |
| 15   | 743-753        | 586 | Ocean color/phytoplankton/biochemistry | 1000        |
| 16   | 862-877        | 516 | Ocean color/phytoplankton/biochemistry | 1000        |
| 17   | 890-920        | 167 | Atmospheric water vapor | 1000        |
| 18   | 931-941        | 57  | Atmospheric water vapor | 1000        |
| 19   | 915-965        | 250 | Atmospheric water vapor | 1000        |
| 20   | 3.660-3.840    | 0.05| Surface/cloud temperature | 1000        |
| 21   | 3.929-3.989    | 2.00| Surface/cloud temperature | 1000        |
| 22   | 3.929-3.989    | 0.07| Surface/cloud temperature | 1000        |
| 23   | 4.020-4.080    | 0.07| Surface/cloud temperature | 1000        |
| 24   | 4.433-4.498    | 0.25| Atmospheric temperature | 1000        |
| 25   | 4.482-4.549    | 0.25| Atmospheric temperature | 1000        |
| 26   | 1360-1390      | 150 | Cirrus clouds | 1000        |
| 27   | 6.535-6.895    | 0.25| Water vapor | 1000        |
| 28   | 7.175-7.475    | 0.25| Water vapor | 1000        |
| 29   | 8.400-8.700    | 0.25| Water vapor | 1000        |
| 30   | 9.580-9.880    | 0.25| Ozone | 1000        |
| 31   | 10.780-11.280  | 0.05| Surface/cloud temperature | 1000        |
| 32   | 11.770-12.270  | 0.05| Surface/cloud temperature | 1000        |
| 33   | 13.185-13.485  | 0.25| Cloud top height | 1000        |
| 34   | 13.485-13.785  | 0.25| Cloud top height | 1000        |
| 35   | 13.785-14.085  | 0.25| Cloud top height | 1000        |
| 36   | 14.085-14.385  | 0.35| Cloud top height | 1000        |

#### MODIS Data Product Classification

**By data product characteristics:**
- Calibrated data products
- Land data products
- Ocean data products
- Atmospheric data products

**By processing level:**
- **Level 0**: Raw data
- **Level 1**: L1A data with calibration parameters assigned
- **Level 2**: L1B data after calibration and geolocation, in international standard EOS-HDF format, containing all band data, widely used
- **Level 3**: Based on 1B data, correcting edge distortion (Bowtie effect) from sensor imaging process
- **Level 4**: Using parameter file parameters for geometric correction and radiometric correction, giving precise geocoding, reflectance and radiance for each pixel
- **Level 5+**: Advanced products developed based on various application models

## II. Remote Sensing Satellite Product Naming Conventions

### 1. MODIS Product Naming Rules

**Example filename:**
```
MOD04_L2.A2005224.0205.005.2006225195920.hdf
```

**Naming rule analysis:**
- **MOD04**: Product name, MODIS aerosol product
- **L2**: Product level, Level 2
- **A2005224**: Product time, day 224 of 2005 (counting from January 1st)
- **0205**: Satellite overpass time, add 8 hours for Beijing time
- **005**: Product version, Version 005
- **2006225195920**: Product processing time

**Another example:**
```
MOD09A1.A2006001.h08v05.005.2006012234657.hdf
```
- **MOD09A1**: MODIS surface reflectance product
- **A2006001**: Day 1 of 2006
- **h08v05**: Tile identifier (horizontal 08, vertical 05)
- **005**: Version number

### 2. Landsat TM Product Naming Rules

**Example 1:**
```
LT51310352009209IKR00
```
- **LT5**: Landsat-5 satellite
- **131**: Path number
- **035**: Row number
- **2009**: Acquisition date
- **209**: Day 209 of 2009
- **IKR**: Ground station code
- **00**: Product level

**Example 2:**
```
L5131035_03520090728_B10
```
- **L5**: Landsat-5 satellite
- **131**: Starting path number
- **035_035**: Starting and ending row numbers
- **20090728**: Date
- **B1**: First band

## III. Data Usage Recommendations

### 1. Data Selection Principles

**Choose based on application needs:**
- **High-resolution applications**: Choose GF-2 and other sub-meter data
- **Long time series analysis**: Choose Landsat series data
- **Global environmental monitoring**: Choose MODIS data
- **Specific applications**: Choose based on spectral requirements and spatial resolution

### 2. Data Processing Considerations

**Preprocessing steps:**
1. **Radiometric calibration**: Convert DN values to radiance
2. **Atmospheric correction**: Remove atmospheric effects
3. **Geometric correction**: Correct geometric distortions
4. **Image enhancement**: Improve image quality

**Quality checks:**
- Check cloud coverage
- Verify data completeness
- Confirm metadata information
- Assess image quality

## Summary

Remote sensing satellite data is an important data source for earth observation and geographic information applications. This article detailed the file formats, technical parameters, and naming conventions of three mainstream satellite data types: GF-2, Landsat-8, and MODIS. Mastering these basic knowledge is of great significance for correctly using and processing satellite data products.

**Key Points:**
1. **GF-2**: Sub-meter high resolution, suitable for detailed monitoring
2. **Landsat-8**: Medium resolution, suitable for long time series analysis
3. **MODIS**: Low resolution high revisit frequency, suitable for global monitoring
4. **Naming conventions**: Include key information such as time, location, product type

## Related Resources

- [China Centre for Resources Satellite Data and Application](http://www.cresda.com/)
- [USGS Landsat Data](https://www.usgs.gov/landsat-missions)
- [NASA MODIS Data](https://modis.gsfc.nasa.gov/)
- [Recommended Remote Sensing Data Processing Software](https://www.arcgis.com/)

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
