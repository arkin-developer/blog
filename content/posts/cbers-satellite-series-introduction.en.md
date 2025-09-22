---
title: "CBERS Satellite Series: Technical Evolution from CBERS-01 to CBERS-04A"
description: "Comprehensive introduction to the development history, technical parameters, and payload configurations of the China-Brazil Earth Resources Satellite (CBERS) series, including technical characteristics, application areas, and data access methods for six satellites"
keywords: ["CBERS", "China-Brazil Earth Resources Satellite", "Remote Sensing Satellites", "Satellite Technology", "Resource Satellites", "Sino-Brazilian Cooperation"]
author: "Arkin"
date: 2022-11-07T16:00:00+08:00
lastmod: 2025-01-27T16:00:00+08:00
draft: false
tags: ["CBERS", "China-Brazil Earth Resources Satellite", "Remote Sensing", "Satellite Technology", "International Cooperation"]
categories: ["GIS Geographic Information"]
aliases: ["/posts/cbers-satellite-series"]
image: "img/cbers-satellite.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> The China-Brazil Earth Resources Satellite (CBERS) series represents an important international cooperation project in the field of remote sensing satellites between China and Brazil. Since the launch of the first satellite in 1999, the series has developed three generations and six satellites, playing an important role in land resource surveys, environmental monitoring, disaster warning, and other fields. This article provides detailed introduction to the development history, technical characteristics, and application value of the CBERS series.

## I. Program Overview

![image-20221105223446731](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221105223446731.png)

**CBERS** (China-Brazil Earth Resources Satellite) is a cooperation program between China's CAST (China Academy of Space Technology) and Brazil's INPE (National Institute for Space Research). The program was signed in July 1988 as a bilateral government agreement for developing and operating two satellites, aiming to establish a complete remote sensing system (space and ground segments) to provide multispectral remote sensing images for both countries.

### Cooperation Background

- **Cooperation Foundation**: Joint investment and development based on China's Resource-1 original plan
- **Overall Objective**: Utilize multi-sensor imaging payloads with different spatial resolutions to observe and monitor Earth resources and environment
- **International Cooperation**: Joined the International Charter on Space and Major Disasters in 2007, undertaking global major disaster monitoring services

## II. Satellite Details

### 2.1 CBERS-01/02 (First Generation)

![image-20221107144750176](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221107144750176.png)

> CBERS-01/02 satellites were jointly developed by China and Brazil as transmission-type resource remote sensing satellites. CBERS-01 was successfully launched on October 14, 1999, ending China's long-term reliance on foreign resource satellites and marking a new stage in China's aerospace remote sensing applications.

#### Satellite Parameters

| Parameter | Details |
|-----------|---------|
| Launch Date | October 14, 1999 (CBERS-01)/October 21, 2003 (CBERS-02) |
| Orbit Type & Altitude | Sun-synchronous recurring orbit, 778 km |
| Inclination | 98.5° |
| Repeat Cycle | 26 days |
| Mean Descending Node Local Time | 10:30 AM |
| Design Lifetime | 2 years |
| Spacecraft Launch Mass | 1450 kg |
| Mission Status | Retired |

**Mission Status Details:**
- **CBERS-01**:
  - WFI sensor malfunctioned 7 months after launch in May 2000
  - X-band failure in downlink on August 13, 2003, preventing all image data transmission
  - Data validity period ended: February 2, 2004

- **CBERS-02**:
  - CCD camera sensor operation interrupted in May 2006 due to power supply anomalies
  - IRMSS instrument has been unusable since 2005
  - Data validity period ended: October 25, 2008

#### Payload Configuration

**1. CCD Camera (CCD)**

![image-20221106110157391](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221106110157391.png)

- **Spatial Resolution**: 19.5m (resampled to 20m)
- **Swath Width**: 113 km
- **Spectral Bands**: 4 bands in visible and near-infrared spectrum + 1 panchromatic band
- **Side-looking Capability**: ±32° range
- **Calibration System**: Internal calibration system

**2. Infrared Multispectral Scanner (IRMSS)**

![image-20221106110232236](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221106110232236.png)

- **Band Configuration**: 1 panchromatic band, 2 shortwave infrared bands, 1 thermal infrared band
- **Swath Width**: 119.5 km
- **Spatial Resolution**:
  - Visible and shortwave infrared bands: 78m (resampled to 80m)
  - Thermal infrared band: 156m (resampled to 160m)
- **Calibration System**: Internal calibration and solar calibration systems

**3. Wide Field Imager (WFI)**

![image-20221106110101989](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221106110101989.png)

- **Band Configuration**: 1 visible band, 1 near-infrared band
- **Spatial Resolution**: 258m
- **Swath Width**: 890 km
- **Features**: Wide scanning capability for high repetition rate ground coverage in short time
- **Calibration System**: On-board calibration system with diffuse reflection window for relative radiometric calibration

#### Sensor Comparison Table

| Sensor Name | CCD Camera | Wide Field Imager (WFI) | Infrared Multispectral Scanner (IRMSS) |
|-------------|------------|-------------------------|----------------------------------------|
| Sensor Type | Push-broom | Push-broom (separate cameras) | Oscillating scan (forward and reverse) |
| Visible/NIR Bands | Band1-5 | Band10-11 | Band6 |
| Shortwave IR Bands | None | None | Band7-8 |
| Thermal IR | None | None | Band9 |
| Radiometric Quantization | 8bit | 8bit | 8bit |
| Scan Bandwidth (km) | 113 | 890 | 120 |
| Spatial Resolution (m) | 20×20 | 260×260 | 80×80/160×160 |
| Side-looking Capability | ±32° | None | ±32° |
| Revisit Cycle | 26 days vertical view (3 days side view) | 5 days | 26 days |

### 2.2 CBERS-02B (First Generation Enhanced)

> CBERS-02B was launched on September 19, 2007, as an Earth observation satellite with high, medium, and low spatial resolutions. The 2.36m resolution HR camera changed the situation of long-term monopoly of foreign high-resolution satellite data in the domestic market.

#### Satellite Parameters

| Parameter | Details |
|-----------|---------|
| Launch Date | September 19, 2007 |
| Orbit Type & Altitude | Sun-synchronous recurring orbit, 778 km |
| Inclination | 98.5° |
| Repeat Cycle | 26 days |
| Mean Descending Node Local Time | 10:30 AM |
| Design Lifetime | 2 years |
| Spacecraft Launch Mass | 1450 kg |
| Mission Status | Retired (May 10, 2010, due to on-board power shortage/failure) |

#### Payload Configuration

**1. CCD Camera (CCD)**
- Same configuration as CBERS-01/02

**2. High Resolution Camera (HR)**
- **Spatial Resolution**: 2.36m
- **Features**: New push-broom camera replacing IRMSS instrument

**3. Wide Field Imager (WFI)**
- Same configuration as CBERS-01/02

#### Sensor Comparison Table

| Sensor Name | CCD Camera | High Resolution Camera (HRS) | Wide Field Imager (WFI) |
|-------------|------------|------------------------------|-------------------------|
| Sensor Type | Push-broom | Oscillating scan (forward and reverse) | Push-broom (separate cameras) |
| Visible/NIR Bands | Band1-5 | Band6 | Band10-11 |
| Shortwave IR Bands | None | None | None |
| Thermal IR | None | None | None |
| Radiometric Quantization | 8bit | 8bit | 8bit |
| Scan Bandwidth (km) | 113 | 27 | 890 |
| Spatial Resolution (m) | 20×20 | 2.7×2.7 | 260×260 |
| Side-looking Capability | ±32° | None | None |
| Revisit Cycle | 26 days vertical view (3 days side view) | Planned 130 days | 5 days |

### 2.3 CBERS-03 (Second Generation First)

> CBERS-3 (also known as Resource-03) was launched on December 9, 2013, but the CZ-4B rocket experienced a failure during flight, and the satellite failed to enter orbit.

**Important Note**:
```
Note: Resource-1 02C satellite does not belong to the CBERS program!!!
```

![image-20221107151947337](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221107151947337.png)

### 2.4 CBERS-04 (Second Generation)

> CBERS-04 was successfully launched on December 7, 2014, carrying 4 cameras. The 5m/10m spatial resolution panchromatic multispectral camera (PAN) and 40m/80m spatial resolution infrared multispectral scanner (IRS) were developed by China, while the 20m spatial resolution multispectral camera (MUX) and 73m spatial resolution wide field imager (WFI) were developed by Brazil.

![image-20221106195741197](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221106195741197.png)

#### Satellite Parameters

| Parameter | Details |
|-----------|---------|
| Launch Date | December 7, 2014 |
| Orbit Type & Altitude | Sun-synchronous recurring orbit, 778 km |
| Inclination | 98.5° |
| Repeat Cycle | 26 days |
| Mean Descending Node Local Time | 10:30 AM |
| Design Lifetime | 3 years |
| Spacecraft Launch Mass | 2080 kg |
| Mission Status | In orbit |

#### Payload Configuration

**1. Multispectral Camera (MUXCam)**
- MUXCam is a new version of the high-resolution CCD camera from CBERS-1, CBERS-2, and CBERS-2B
- **Spatial Resolution**: 20m
- **Swath Width**: 120 km
- **Spectral Bands**: 3 bands in visible and near-infrared spectrum

**2. Panchromatic and Multispectral Camera (PanMUX)**
- CCD push-broom camera
- **Spatial Resolution**: 5m GSD panchromatic images and 10m GSD three-band multispectral images
- **Swath Width**: 60 km
- **Side-looking Capability**: ±32° range
- **Features**: Focal plane adjustment and on-orbit calibration capabilities

**3. Infrared Multispectral Scanner (IRS)**
- Continuation of IRMSS from first-generation satellites
- 4-spectral-band imager
- Higher spatial resolution compared to IRMSS payload

**4. Wide Field Imager (WFI)**
- Updated version of WFI from CBERS-1, 2, and 2B satellites
- **Spatial Resolution**: 64m
- **Swath Width**: 866 km
- **Band Configuration**: 1 visible band, 1 near-infrared band

#### Sensor Comparison Table

| Sensor Name | Multispectral Camera (MUXCam) | Panchromatic and Multispectral Camera (PanMUX) | Infrared Multispectral Scanner (IRS) | Wide Field Imager (WFI) |
|-------------|-------------------------------|------------------------------------------------|--------------------------------------|-------------------------|
| Sensor Type | Push-broom | Push-broom | Oscillating scan (forward and reverse) | Push-broom |
| Visible/NIR Bands | Band5-8 | Band1-4 | Band9 | Band13-16 |
| Shortwave IR Bands | None | None | Band10-11 | None |
| Thermal IR | None | None | Band12 | None |
| Radiometric Quantization | 8bit | 8bit | 8bit | 10bit |
| Scan Bandwidth (km) | 120 | 60 | 120 | 866 |
| Spatial Resolution (m) | 20×20 | 5×5/10×10 | 40×40/80×80 | 64×64 |
| Side-looking Capability | None | ±32° | None | None |
| Revisit Cycle | 26 days | 52 days* | 26 days | 5 days |

**Other Payloads:**
- Two image data transmitters (for MUXCam, PanMUX, IRS, WFI)
- Digital Data Recorder (DDR)
- Data Collection System (DCS)
- Space Environment Monitor (SEM)

### 2.5 CBERS-04A (Second Generation Latest)

> CBERS-04A was successfully launched on December 20, 2019, configured with three optical payloads: China's Wide Panchromatic Multispectral Camera (WPM), and Brazil's Multispectral Camera (MUX) and Wide Field Camera (WFI).

![image-20221107131955024](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/huaweimetabook/image-20221107131955024.png)

#### Satellite Parameters

| Parameter | Details |
|-----------|---------|
| Launch Date | December 20, 2019 |
| Orbit Type & Altitude | Sun-synchronous recurring orbit, 628.6 km |
| Inclination | 97.89° |
| Repeat Cycle | 31 days |
| Mean Descending Node Local Time | 10:30 AM |
| Design Lifetime | 5 years |
| Spacecraft Launch Mass | 1730 kg |
| Mission Status | In orbit |

#### Payload Configuration

**1. Wide Panchromatic Multispectral Camera (WPM)**
- **Spatial Resolution**: 2m panchromatic resolution and 8m multispectral resolution
- **Swath Width**: 92 km
- **Spectral Bands**: 5 bands in visible and near-infrared spectrum

**2. Multispectral Camera (MUX)**
- Same MUX camera used in CBERS-3&4 satellites
- Resolution reduced to 16.5m due to orbit altitude reduction from 778 km to 628.6 km

**3. Wide Field Imager (WFI)**
- Same WFI camera used in CBERS-3&4 satellites
- **Spatial Resolution**: 55m
- **Swath Width**: 684 km

#### Sensor Comparison Table

| Sensor Name | Wide Panchromatic Multispectral Camera (WPM) | Multispectral Camera (MUX) | Wide Field Imager (WFI) |
|-------------|----------------------------------------------|---------------------------|-------------------------|
| Sensor Type | Push-broom | Push-broom | Push-broom |
| Visible/NIR Bands | Band0-4 | Band5-8 | Band13-16 |
| Shortwave IR Bands | None | None | None |
| Thermal IR | None | None | None |
| Radiometric Quantization | 10bit | 8bit | 10bit |
| Scan Bandwidth (km) | 92 | 95 | 684 |
| Spatial Resolution (m) | 2×2/8×8 | 16.5×16.5 | 55×55 |
| Side-looking Capability | ±32° | ±32° | None |
| Revisit Cycle (days) | 31 days | 31 days | 5 days |

**Other Payloads:**
- Image data transmitters for MUX, WFI, and WPM cameras (DTS)
- Digital Data Recorder (DDR)
- Data Collection System (DCS)
- Space Environment Monitor (SEM)

## III. Program Development Overview

### Satellite Development History

As of November 7, 2022, through the CBERS program, China and Brazil have cooperatively built six satellites:

**First Generation:**
- CBERS-01 (October 14, 1999 – February 2, 2004, retired)
- CBERS-02 (October 21, 2003 – October 25, 2008, retired)
- CBERS-02B (September 19, 2007 – March 11, 2010, retired)

**Second Generation:**
- CBERS-03 (December 9, 2013, launch failure)
- CBERS-04 (December 7, 2014, in orbit)
- CBERS-04A (December 20, 2019, in orbit)

### Technical Development Characteristics

**Resolution Improvement:**
- First Generation: Mainly 20m resolution
- Second Generation: Up to 2m resolution

**Payload Configuration Optimization:**
- From single payload to multi-payload coordination
- From 8bit to 10bit quantization
- From fixed configuration to flexible configuration

**Enhanced Application Capabilities:**
- Expanded coverage area
- Optimized revisit cycle
- Improved data processing capabilities

## IV. Data Access and Applications

### Data Download Channels

**1. China Centre for Resources Satellite Data and Application**
- **Website**: https://data.cresda.cn
- **Recommended Browsers**: Microsoft Edge, Google Chrome
- **Available Sensors**:

| Satellite | Sensors |
|-----------|---------|
| CBERS-04A | MUX (20m multispectral camera), WFI (73m wide field imager) |
| CBERS-04 | IRS (40&80m infrared camera), P10 (10m multispectral camera), MUX (20m multispectral camera), WFI (73m wide field imager) |
| CBERS-02B | CCD (20m optical camera), WFI (256m wide field imager) |
| CBERS-02 | CCD (20m charge-coupled device camera), IRS (78&156m infrared multispectral scanner), WFI (256m wide field camera) |
| CBERS-01 | CCD (20m charge-coupled device camera), IRS (78&156m infrared multispectral scanner), WFI (256m wide field camera) |

**2. Brazilian National Institute for Space Research**
- **Website**: http://www2.dgi.inpe.br/catalogo/explore
- **Limitation**: Only Brazilian territory remote sensing images
- **Open Access**: Brazil has opened all sensor permissions for CBERS-04 & CBERS-04A

### Application Areas

**Main Application Areas:**
- Land resource surveys, evaluation, planning, monitoring
- Emergency management
- Crop yield estimation
- Environmental protection and monitoring
- Urban planning
- Water and forestry resource surveys
- Disaster monitoring

**International Cooperation:**
- Joined the International Charter on Space and Major Disasters
- Provide global major disaster monitoring services
- Share resource satellite data with Africa

## Summary

The CBERS satellite series represents important cooperation achievements between China and Brazil in the field of aerospace remote sensing. From CBERS-01 in 1999 to CBERS-04A in 2019, the series has achieved significant improvements in technical level and application capabilities.

**Key Achievements:**
1. **Technical Breakthrough**: From 20m to 2m resolution
2. **International Cooperation**: Established successful bilateral cooperation model
3. **Application Value**: Played important roles in multiple fields
4. **Global Impact**: Contributed to international remote sensing data sharing

**Development Significance:**
- Ended China's history of relying on foreign resource satellites
- Established a complete remote sensing system (space and ground segments)
- Provided a successful example for South-South cooperation
- Promoted the development of global remote sensing technology

## Related Resources

- [China Centre for Resources Satellite Data and Application](https://data.cresda.cn)
- [Brazilian National Institute for Space Research](http://www2.dgi.inpe.br/catalogo/explore)
- [CBERS Official Documentation](https://rs-freedatasource.readthedocs.io/zh_CN/latest/CBERS.html)
- [INPE/CBERS](http://www.cbers.inpe.br/)
- [CBERS-1 and 2 Technical Documentation](https://grupoqd.com.br/aquisicao-dos-dados-do-cbers-04a/)
