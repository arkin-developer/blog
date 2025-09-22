---
title: "Basic Workflow and Methods of Remote Sensing Image Processing"
description: "Detailed introduction to basic workflows and methods of remote sensing image preprocessing, including geometric correction, image fusion, orthorectification, radiometric correction, and other core processing techniques for practical remote sensing data processing guidance"
keywords: ["Remote Sensing Image Processing", "Geometric Correction", "Image Fusion", "Orthorectification", "Radiometric Correction", "ENVI", "Remote Sensing Preprocessing"]
author: "Arkin"
date: 2021-11-04T13:00:00+08:00
lastmod: 2025-01-27T17:00:00+08:00
draft: false
tags: ["Remote Sensing", "Image Processing", "ENVI", "Geometric Correction", "Image Fusion", "Radiometric Correction"]
categories: ["GIS Geographic Information"]
aliases: ["/posts/remote-sensing-image-processing"]
image: "img/remote-sensing-processing.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> Remote sensing image preprocessing methods are generally similar, mainly including two application directions: quantitative and qualitative. Quantitative research is usually more valued in academic research, so more consideration is given to ensuring data accuracy and high fidelity during processing. Qualitative research is usually in commercial applications, such as base maps and reference maps, where attention should be paid to the accuracy of geographic location information.

## Overview

Remote sensing image preprocessing methods are generally similar, mainly including two application directions: quantitative and qualitative.

**Quantitative Research**: Academic research usually values quantitative research more, so more consideration is given to ensuring data accuracy and high fidelity during processing. Therefore, more consideration needs to be given to radiometric correction (atmospheric correction, radiometric calibration) processing to remove noise and restore true data.

**Qualitative Research**: Usually in commercial applications, such as base maps and reference maps, attention should be paid to the accuracy of geographic location information, involving orthorectification, geometric registration, map projection, and other processing.

## Remote Sensing Image Preprocessing

*[Remote Sensing Image Processing Workflow - GDAL Column - CSDN Blog](https://blog.csdn.net/liminlu0314/article/details/8757262)*

### 1. Geometric Correction

Principle: Image geometric correction is generally divided into two categories: systematic and non-systematic. Systematic errors are generally caused by the sensor itself, with regular patterns and predictability, and can be corrected using sensor models. Satellite ground receiving stations have already completed this work. Non-systematic geometric distortions are irregular, which can be due to unstable sensor platform height, attitude, or changes in Earth curvature, atmospheric refraction, and terrain. Geometric correction usually refers to eliminating these non-systematic geometric distortions.

Geometric correction uses ground control points and geometric correction mathematical models to correct errors caused by non-systematic factors, while also projecting images onto a plane to conform to map projection systems. Since the correction process assigns coordinate systems to image data, this process includes geocoding.

#### 1) Geometric Correction Using Satellite Built-in Geolocation Files

For satellite data with *low spatial resolution* where ground control point selection is quite difficult, satellite sensor built-in geolocation files can be used for geometric correction. Correction accuracy mainly depends on the geolocation files.

```python
# ENVI Tool Path
/Geometric Correction/Georeference by Sensor/ <Select Sensor Type>
```

#### 2) Image to Image Geometric Correction

Use one raster file as reference to register another raster file by selecting corresponding points (or control points) from both images to make the same features appear at the same locations. Most geometric corrections use this method.

```python
# Tool Usage
# This tool needs to be completed in ENVI Classic, select main menu
/Map/Registration/Select GCPs:Image to Image
```

#### 3) Image to Map Geometric Correction

Planarize remote sensing image geometry through ground control points. Control points can be obtained from keyboard input, vector files, or raster files. Topographic map correction can use this method.

```python
/Geometric Correction/Registration/Registration: Image to Map
```

#### 4) Image to Image Automatic Image Registration

Automatically find corresponding points on two images based on pixel gray values or feature characteristics, and complete image registration based on corresponding points. When two images of the same area do not overlap due to respective correction errors, this method can be used for adjustment.

```python
/Geometric Correction/Registration/Registration: Image to Image
```

#### 5) Image Registration Workflow Tool

Register images with different coordinate systems and geographic locations to a unified coordinate system, so that images contain the same features at the same geographic locations. Can automatically locate and match corresponding points between reference images and images to be registered, using available spatial reference information and various automatic matching techniques to improve accuracy.

```python
/Geometric Correction/Registration/Image Registration Workflow
```

### 2. Thin Cloud Processing

Principle: Under thin cloud conditions, the image information received by sensors includes both cloud reflection information of sunlight and surface feature reflection information that passes through clouds.

![image-20211103155243810](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211103155243810.png)

After searching online, it seems that as of November 3, 2021, there is still no relatively unified workflow tool. Some mention *HIS transform* and *filtering*, but no relatively mature results have been seen. The only convincing one is He Kaiming's *Dark Channel Prior* method (He Kaiming comes to the rescue again), with clear principles and impressive results! However, no remote sensing processing software has been seen to apply this method. For qualitative requirements, you can consider looking for related algorithms on GitHub to remove thin clouds. For quantitative work, this is not recommended, as this method will inevitably change the original image DN values, thereby affecting radiometric correction operations.

### 3. Image Fusion

Principle: Image fusion is a remote sensing image processing technique that resamples low spatial resolution multispectral images or hyperspectral data with high spatial resolution single-band images to generate high-resolution multispectral images, so that the processed images have both high spatial resolution and multispectral characteristics. The key to image fusion is *precise registration* of images before fusion and selection of *fusion methods* during processing.

| Fusion Method | Applicable Scope |
| :---------------------------------: | :----------------------------------------------------------: |
| IHS Transform | Good texture improvement and spatial preservation. Significant spectral information loss, limited by bands. |
| Brovey Transform | Good spectral information preservation, limited by bands. |
| Product Operation (CN) | Good for large geomorphological types, can be used for multispectral and hyperspectral fusion. |
| PCA Transform | No band limitation, good spectral preservation. First principal component highly concentrated, significant tone changes. |
| **Gram-Schmidt Pan Sharpening (GS)** | Improved PCA information over-concentration problem, no band limitation, good spatial texture preservation, especially high-fidelity spectral characteristics. Designed for latest high spatial resolution imagery, can well preserve image texture and spectral information. |

#### 1) HSV Transform and Brovey Transform

Requires input data to have geographic reference or the same size. RGB input band data type must be Byte. These two operation methods are similar.

```python
/Image Sharpening/Color Normalized (Brovey) Sharpening
```

#### 2) Gram-Schmidt Pan Sharpening (GS)

This is a high-fidelity remote sensing image fusion method that can satisfy most image fusion needs, especially for high-resolution images.

```python
# This tool is relatively troublesome to use
/Image Sharpening/Gram-Schmidt Pan Sharpening
# The tool below is more commonly used
/Image Sharpening/NNDiffuse Pan Sharpening
```

#### 3) CN Product Operation

Requires data to have *center wavelength* and *FWHM*

### 4. Image Mosaicking

Principle: Image mosaicking refers to the process of stitching multiple adjacent remote sensing images into a large-scale, seamless image under certain mathematical foundation control.

#### 1) Seamline

Seamline refers to selecting a line as the seamline between two images in the overlapping area of adjacent images during the mosaicking process according to certain rules. Its purpose is to solve the problem of excessive differences at the seam. If there is no precise registration, it is necessary to select features such as rivers and roads in the overlapping area to draw seamlines.

#### 2) Feathering

Seamlines often need appropriate blurring to better integrate into images.

#### 3) Color Balancing

ENVI uses color balancing methods to minimize the impact of inconsistent colors in mosaic images on mosaic results. Using one image as reference, it statistics histograms of each mosaic image and uses histogram matching to match other mosaic images, so that mosaic images have similar gray characteristics.

```python
# Seamless Mosaic Tool
/Mosaicking/Seamless Mosaic

# Pixel-based Image Mosaicking
/Mosaicking/Pixel Based Mosaicking
```

### 5. Image Clipping

Principle: The fundamental purpose is to remove areas outside the study region. Commonly includes regular clipping and irregular clipping.

#### 1) Regular Clipping

```python
File/Save As
```

#### 2) Irregular Clipping

```python
# Manually draw clipping boundaries
Forget it, I won't write this part. Clipping is used in ArcGIS, simple and fast.
```

### 6. Image Enhancement

Principle: Through various image enhancement algorithms, the visual effects of images can be improved, facilitating visual interpretation, sample selection in image classification, etc. The main purpose of image enhancement is to enhance images so that the processed result images are more suitable for specific application requirements than the original images.

#### 1) Spatial Domain Enhancement

Spatial domain enhancement directly changes the gray values of individual pixels and adjacent pixels in images for enhancement. This enhancement method is often purposeful, such as enhancing linear feature details or main parts in images.

```python
# Convolution Filtering
/Filter/Convolutions and Morphology
# Statistics-based Filters
/Filter/Occurrence Measures
# Second-order Statistics-based Filtering
/Filter/Co-occurrence Measures
```

#### 2) Radiometric Enhancement

Radiometric enhancement enhances images by transforming individual pixel gray values, such as histogram matching, histogram stretching, destriping, etc.

```python
# Interactive Histogram Stretching
Display/Custom Stretch
# Bad Line Replacement
/Raster Management/Replace Bad Lines
# Destriping
/Raster Management/Destripe
```

#### 3) Spectral Enhancement

Spectral enhancement is based on multispectral data to transform bands for image enhancement, such as principal component transform, independent component transform, color space transform, and color stretching.

```python
# Band Ratio Enhancement
/Band Algebra/Band Ratios
# Principal Component Analysis (PCA)
/Transform/PCA Rotation/Forward PCA Rotation New Statistics and Rotate
# Independent Component Analysis (ICA)
/Transform/ICA Rotation/Forward ICA Rotation New Statistics and Rotate
# Color Space Transform
/Transform/Color Transforms/RGB to HSV Color Transform
# Color Stretching
/Transform/Decorrelation Stretch
# NDVI Calculation
/Spectral/Vegetation/NDVI
# Tasseled Cap Transform
/Transform/Tasseled Cap
```

Note: All toolbox paths above are based on *ENVI 5.6* version

#### 4) Fourier Transform

Fourier transform converts images from spatial domain to frequency domain. Fourier transform is mainly used to eliminate periodic noise and can also eliminate regular errors caused by sensor anomalies.

```python
# Fast Fourier Transform (FFT)
/Filter/FFT (Forward)
# Define FFT Filter
/Filter/FFT Filter Definition
# Inverse FFT Transform
/Filter/FFT (Inverse)
# False Color Composite Based on Band Combination
/Raster Management/Build Layer Stack
# Select RGB Composition Bands
/Statistics/Compute Band Statistics
# Band Weighted True Color Enhancement
/Band Algebra/Band Math
```

### 7. Orthorectification

Orthorectification is the process of correcting image spatial and geometric distortions to generate multi-center projection plane ortho images. In addition to correcting general systematic geometric distortions, it can also eliminate terrain-induced geometric distortions. It uses a small number of ground control points combined with camera or satellite models to establish simple relationships between camera (sensor), image, and ground platforms, establish correct correction formulas, and generate precise ortho images.

Currently, ENVI only supports two orthorectification models: rigorous orbital model (Pushbroom) and Rational Polynomial Coefficient (*RPC*).

#### 1) Orthorectification Without Control Points

This correction method mainly relies on RPC files and DEM data for positioning and geometric correction of images. Correction accuracy depends on the positioning accuracy of the provided RPC files and DEM resolution.

```python
# The following operations are completed in ENVI Classic
File/Open External File/QuickBird/GeoTIFF
```

#### 2) Orthorectification With Control Points

Using ground control points in orthorectification can improve correction accuracy. Control point (x, y) coordinate selection is the same as Image to Map geometric correction control point selection methods, including vector, image, binary file, and manual input methods. z values can be field measurements or obtained from high-resolution DEM data.

```python
# The following operations are completed in ENVI Classic
File/Open External File/QuickBird/GeoTIFF
# After using the above tool, then
Map/Orthorectification/QuickBird/Orthorectify QuickBird With Ground Control
```

#### 3) Orthorectification Workflow Tool

```python
/Geometric Correction/Orthorectification/RPC Orthorectification Workflow
```

#### 4) Custom RPC Orthorectification

For aerial images (frame and digital photos) and satellite image data with lost RPC parameters, strict physical correction models can be constructed based on camera parameters, sensor parameters, exterior orientation elements, and ground control points to achieve orthorectification.

```python
# Build RPCs
/Geometric Correction/Orthorectification/Build RPCs
# After building, use orthorectification workflow to complete orthorectification process
```

### 8. Radiometric Correction (Radiometric Calibration and Atmospheric Correction)

Remote sensing images are usually recorded using dimensionless (unitless) digital quantization values (DN). For remote sensing quantitative analysis, radiance values, reflectance values, and temperature values are commonly used. Radiometric calibration can achieve conversion between DN values and these physical quantities. Atmospheric correction can reduce or eliminate atmospheric effects on remote sensing images and obtain true surface reflectance information.

#### 1) Radiometric Calibration

Radiometric calibration is the process of converting sensor-recorded voltage or digital quantization values to absolute radiance values (radiance) or relative values related to surface (apparent) reflectance, surface (apparent) temperature, and other physical quantities.

```python
# General Calibration Tool
# Radiance values (radiance), atmospheric apparent reflectance (reflectance), and brightness temperatures
/Radiometric Correction/Radiometric Calibration
# Thermal Infrared Data Calibration
/Radiometric Correction/Calibrate TIMS
# NOAA AVHRR Data Calibration
/Radiometric Correction/Calibrate AVHRR
# Sea Surface Temperature (SST) Calculation
/Raster Management/Data-Specific Utilities/AVHRR Sea Surface Temperature (SST)
```

![image-20211104134712421](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211104134712421.png)

#### 2) Atmospheric Correction

The purpose of atmospheric correction is to eliminate the effects of atmosphere and illumination on surface reflectance, obtain true physical model parameters such as surface reflectance, radiance, and surface temperature, and eliminate the effects of water vapor, oxygen, carbon dioxide, methane, and ozone in the atmosphere on surface reflectance. In most cases, atmospheric correction is also the process of inverting true surface reflectance.

**Atmospheric Correction Types:**

- **Absolute Atmospheric Correction Methods**: Methods to convert DN values of remote sensing images to surface reflectance, surface radiance, and surface temperature. Common absolute atmospheric correction methods include radiation transfer model-based MORTRAN model, LOWTRAN model, ATCOR model, and 6S model, as well as simplified radiation transfer model-based dark pixel method and statistics-based reflectance inversion.
- **Relative Atmospheric Correction Methods**: After correction, the same DN values on the image represent the same surface reflectance, and the results do not consider the actual reflectance of surface features. Common relative atmospheric correction methods include statistics-based invariant target method and histogram matching.

**Atmospheric Correction Methods:**

1. **Simplified Dark Pixel Atmospheric Correction**: Its basic principle is that under the assumption that dark pixels exist on remote sensing images to be corrected, Lambertian surface reflection, and uniform atmospheric properties, ignoring atmospheric multiple scattering radiation and adjacent pixel diffuse reflection effects, dark pixels with very small reflectance (approximately 0) have relatively increased reflectance due to atmospheric effects. Subtracting the pixel values of these dark pixels from other pixels can reduce atmospheric (mainly atmospheric scattering) effects on the entire image and achieve atmospheric correction. The key to the entire process is finding dark pixels and the increased pixel values of dark pixels.
2. **Statistics-based Reflectance Inversion**: Mainly includes Flat Field (FF), Log Residuals, Internal Average Relative Reflectance (IARR), and Empirical Line methods.
3. **Invariant Target Relative Atmospheric Correction**: Can be divided into two types based on mathematical foundation (nonlinear correction method and linear correction method). The most classic nonlinear correction method is histogram matching. Image histogram is the probability distribution of all gray values in an image. Matching the histogram of the corrected image with the histogram of the reference image makes the two images have the same or similar gray value probability distribution, achieving the purpose of having the same gray values for corresponding features on both images. Linear correction method has a premise assumption: gray values of images at different times satisfy linear relationships. This assumption is valid under approximate conditions. This allows describing gray relationships between different times through linear equations, using x to represent the reference image and y to represent the image to be corrected. The linear relationship between them can be described as *y=a*x+b*

```python
# Simplified Dark Pixel Atmospheric Correction
/Radiometric Correction/Dark Subtraction
# Flat Field Method
/Radiometric Correction/Flat Field Correction
# Log Residuals Method
/Radiometric Correction/Log Residuals Correction
# Internal Average Method
/Radiometric Correction/IAR Reflectance Correction
# Empirical Line Method - Compute Factors and Calibrate Tool
/Radiometric Correction/Empirical Line Compute Factors and Correct
# Empirical Line Method - Calibrate Using Existing Factors
/Radiometric Correction/Empirical Line Correct Using Existing Factors
```

**Atmospheric Correction Tools:**

```python
# FLAASH Tool
/Radiometric Correction/Atmospheric Correction Module/FLAASH Atmospheric Correction
# QUAC Quick Atmospheric Correction Tool
/Radiometric Correction/Atmospheric Correction Module/QUAC - Quick Atmospheric Correction
```

### 9. Custom Coordinate System

Foreign commercial software coordinate systems are divided into two types: Standard coordinate system (Standard) and Custom coordinate system (Custom). Due to China's special circumstances, custom coordinate systems are often needed.

```python
/Raster Management/Edit ENVI Header
# Reprojection
/Raster Management/Reproject Raster
```

## Processing Paths

**Qualitative Path**: (Atmospheric Correction) > Geometric Correction > Image Fusion > Orthorectification > Image Mosaicking > Image Clipping > Image Enhancement > Convert to 8-bit (as needed)  

**Quantitative Path**: Radiometric Calibration > Atmospheric Correction > (Classification and Extraction) > Model Inversion

**GF-2 Data Processing Path**: Radiometric Calibration > Atmospheric Correction > Geometric Correction > Image Fusion > Orthorectification

## Summary

The basic workflow and methods of remote sensing image processing cover the complete process from data preprocessing to final application. Different application requirements determine different processing paths. Quantitative research focuses on the physical authenticity of data, while qualitative research focuses on spatial location accuracy. Mastering these basic processing methods and technical points is important for improving the effectiveness of remote sensing data applications.

*Note: All toolbox paths above are based on ENVI 5.6 version*

## Related Resources

- [ENVI Official Documentation](https://www.l3harrisgeospatial.com/Software-Technology/ENVI)
- [Remote Sensing Image Processing Workflow - GDAL Column](https://blog.csdn.net/liminlu0314/article/details/8757262)
- [Remote Sensing Image Processing Fundamentals Tutorial](https://www.researchgate.net/publication/remote-sensing-image-processing)
- [ENVI Image Processing Practical Guide](https://www.l3harrisgeospatial.com/Learn/Resources/ENVI-Tutorials)
