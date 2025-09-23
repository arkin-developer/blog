---
title: "遥感图像处理的基本流程和方法"
description: "详细介绍遥感图像预处理的基本流程和方法，包括几何纠正、图像融合、正射校正、辐射校正等核心处理技术，为遥感数据处理提供实用的技术指导"
keywords: ["遥感图像处理", "几何纠正", "图像融合", "正射校正", "辐射校正", "ENVI", "遥感预处理"]
author: "Arkin"
date: 2021-11-04T13:00:00+08:00
lastmod: 2021-11-04T13:00:00+08:00
draft: false
tags: ["遥感", "图像处理", "ENVI", "几何纠正", "图像融合", "辐射校正"]
categories: ["GIS地理信息"]
aliases: ["/posts/remote-sensing-image-processing"]
image: "img/remote-sensing-processing.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> 遥感图像预处理方法大致相同，主要有两种应用方向，定量和定性。定量研究通常科研学术会比较看重定量的研究，故在处理的过程中会更多的考虑到保证数据准确性和高还原性。定性研究通常商业应用中，例如作为底图、参考图等等，这种应用中要注意其地理位置信息的准确性。

## 概述

遥感图像预处理方法大致相同，主要有两种应用方向，定量和定性。

**定量研究**：通常科研学术会比较看重定量的研究，故在处理的过程中会更多的考虑到保证数据准确性和高还原性。因此需要更多的考虑到辐射校正(大气校正、辐射定标)的一些处理，去除噪音还原真实数据。

**定性研究**：通常商业应用中，例如作为底图、参考图等等，这种应用中要注意其地理位置信息的准确性，涉及到正射校正、几何配准、地图投影等处理。

## 遥感图像预处理

*[遥感图像处理流程_GDAL专栏-CSDN博客_遥感影像处理流程](https://blog.csdn.net/liminlu0314/article/details/8757262)*

### 1、几何纠正

原理：图像几何校正一般分为两大类：系统性和非系统性。系统性一般有传感器本身引起的，有规律可循和可预测性，可以用传感器模型来校正，卫星地面接收站已经完成这项工作；非系统性几何变形是不规律的，它可以是传感器平台本身的高度、姿态等不稳定，也可以是地球曲率及空气折射的变化以及地形的变化等。几何校正通常指的是消除这些非系统性几何形变。

几何校正是利用地面控制点和几何校正数学模型来校正非系统因素产生的误差，同时也是将图像投影到平面上，使其符合地图投影系统的过程；由于校正过程中会将坐标系统赋予图像数据，所以此过程包括了地理编码（Geo-coding）

#### 1）卫星自带地理定位文件进行几何校正

针对*空间分辨率较低*，地面控制点的选择有相当难度的卫星数据，可以选择使用卫星传感器自带地理定位文件进行几何校正，校正精度主要受地理定位文件影响。

```python
# ENVI工具地址
/Geometric Correction/Georeference by Sensor/ <选择传感器类型>
```

#### 2）Image to Image 几何校正

以一幅栅格文件作为基准图配准另一幅栅格文件，通过从两幅图像上选择同名点（或控制点）使相同地物出现在相同的位置。大多数几何校正都是使用此种方法。

```python
# 工具使用
# 此工具需要在ENVI Classic 完成，选择主菜单
/Map/Registration/Select GCPs:Image to Image
```

#### 3）Image to Map 几何校正

通过地面控制点对遥感图像几何进行平面化的过程，控制点可以使键盘输入、矢量文件或者栅格文件中获取。地形图校正就可以采取这种方法。

```python
/Geometric Correction/Registration/Registration: Image to Map
```

#### 4）Image to Image 自动图像配准

根据像元灰度值或者地物特征自动寻找两幅图像上的同名点，根据同名点完成两幅图像的配置过程。当同一地区的两幅图像，由于各自校正误差的影响使得图上的相同地物不重叠时，可以利用此方法进行调整。

```python
/Geometric Correction/Registration/Registration: Image to Image
```

#### 5）Image Registration Workflow 流程化工具

将具有不同坐标系、不同地理位置的图像配准到统一坐标系下，使图像中相同地理位置包含相同的地物。可以自动定位和匹配基准图像和待配准图像的同名点，使用可用空间参考信息和各种自动匹配技术来提高精度。

```python
/Geometric Correction/Registration/Image Registration Workflow
```

### 2、薄云处理

原理：在薄云的条件下，传感器所接受的图像信息包含了云层对太阳光的反射信息以及地物的反射信息穿过云层的那部分。

![image-20211103155243810](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211103155243810.png)

这部分内容在网上查阅了一番，好像目前（2021年11月3日）仍没有相对统一的流程化工具，有的说*HIS变换*和*滤波*，但没有看到相对成熟的结果。唯一有说服力的是何凯明大神的*暗通道去雾法*（还是得何大神出马），相关原理明确，结果喜人！但是遥感处理软件还没有看到有应用该方法的工具。如果做定性需求的可以考虑去github找找相关算法来把薄云去掉，定量的就不建议，通过这个方法势必会改变原有图像的DN值，从而影响辐射校正操作。

### 3、图像融合

原理：图像融合是将低空间分辨率的多光谱图像或高光谱数据与高空间分辨率的单波段图像重采样生成一幅高分辨率多光谱图像的遥感影像处理技术，使得处理后的图像既有较高的空间分辨率，又具有多光谱特征。图像融合的关键是融合前两幅图像的*精确配准*以及处理过程中*融合方法*的选择。

| 融合方法 | 适用范围 |
| :---------------------------------: | :----------------------------------------------------------: |
| IHS变换 | 纹理改善，空间保持较好。光谱信息损失较大，受波段限制。 |
| Brovey变换 | 光谱信息保持较好，受波段限制。 |
| 乘积运算(CN) | 对大的地貌类型效果好，同时可用于多光谱与高光谱的融合。 |
| PCA变换 | 无波段限制，光谱保持好。第一主成分信息高度集中，色调发生较大变化。 |
| **Gram-schmidt Pan Sharpening(GS)** | 改进了PCA中信息过分集中的问题，不受波段限制，较好的保持空间纹理信息，尤其能高保真保持光谱特征。专为最新高空间分辨率影像设计，能较好保持影像的纹理和光谱信息。 |

#### 1）HSV变换和Brovey变换

要求输入数据具有地理参考或者具有相同的尺寸大小。RGB输入波段数据类型必须为字节型（Byte）。这两种操作方法类似。

```python
/Image Sharpening/Color Normalized (Brovey) Sharpening
```

#### 2）Gram-schmidt Pan Sharpening(GS)

这是一种高保真的遥感图像融合方法，这种方法可以满足绝大部分的图像融合，特别是高分辨率图。

```python
# 这个工具使用比较麻烦
/Image Sharpening/Gram-Schmidt Pan Sharpening
# 下面这个工具比较常用
/Image Sharpening/NNDiffuse Pan Sharpening
```

#### 3）CN乘积运算

要求数据具有*中心波长*和*FWHM*

### 4、图像镶嵌

原理：图像镶嵌指在一定数学基础控制下，把多景相邻遥感图像拼接成一个大范围、无缝的图像的过程。

#### 1）接边线

接边线是指在镶嵌过程中，在相邻的两个图的重叠区内，按照一定规则选择一条线作为两个图的接边线。作用是改变接边处差异太大的问题，如果没有精确配准，需要选择重叠区的河流、道路等地物绘制接边线。

#### 2）羽化（Feathering）

接边线常常需要做适当模糊才能更好地融入图像中。

#### 3）匀色

ENVI采用颜色平衡的方法，尽量避免由于镶嵌图像颜色不一致而影响镶嵌结果。以一幅图像为基准，统计各镶嵌图像的直方图，采用直方图匹配法匹配其他镶嵌图像，使得镶嵌图像具有相近的灰度特征。

```python
# 无缝镶嵌工具（Seamless Mosaic）
/Mosaicking/Seamless Mosaic

# 基于像素的图像镶嵌
/Mosaicking/Pixel Based Mosaicking
```

### 5、图像裁剪

原理：根本目的是为了将研究之外的区域去除。常有规则裁剪和不规则裁剪两种。

#### 1）规则分幅裁剪

```python
File/sava As
```

#### 2）不规则分幅裁剪

```python
# 手动绘制裁剪范围
算了，这部分不写了，裁剪在ArcGIS上使用，简单快捷。
```

### 6、图像增强

原理：通过各种图像增强算法，可以提高图像的目视效果，方便人工目视、图像分类中样本选取等。图像增强的主要目的是增强图像，以便处理结果图像比原始图像更适合于特定的应用要求。

#### 1）空间域增强处理

空间域增强处理是通过直接改变图像中的单个像元及相邻像元的灰度值来增强图像，这种增强方式往往是由目的的，如增强图像中的线状物体细部部分或者主干部分等。

```python
# 卷积滤波
/Filter/Convolutions and Morphology
# 基于概率统计的滤波器
/Filter/Occurrence Measures
# 基于二阶概率统计的滤波
/Filter/Co-occurrence Measures
```

#### 2）辐射增强处理

辐射增强处理是通过对单个像元的灰度值进行变换处理来增强处理，如直方图匹配、直方图拉伸、去除条带噪声处理等。

```python
# 交互式直方图拉伸
Display/Custom Stretch
# 坏道填充
/Raster Management/Replace Bad Lines
# 去条带处理
/Raster Management/Destripe
```

#### 3）光谱增强处理

光谱增强是基于多光谱数据对波段进行变换达到图像增强处理，如主成分变换、独立主成分变换、彩色空间变换和色彩拉伸等。

```python
# 波段比增强
/Band Algebra/Band Ratios
# 主成分分析（PCA）
/Transform/PCA Rotation/Forward PCA Rotation New Statistics and Rotate
# 独立主成分分析（ICA）
/Transform/ICA Rotation/Forward ICA Rotation New Statistics and Rotate
# 色彩空间变换
/Transform/Color Transforms/RGB to HSV Color Transform
# 色彩拉伸
/Transform/Decorrelation Stretch
# NDVI计算
/Spectral/Vegetation/NDVI
# 缨帽变化
/Transform/Tasseled Cap
```

备注：以上所有工具箱路径都是基于*ENVI5.6*版本

#### 4）傅里叶变换

傅里叶变换时将图像从空间域转换到频率域。傅里叶变换主要用于消除周期性噪声，还可以消除由于传感器异常引起的规律性错误。

```python
# 快速傅里叶变换（FFT）
/Filter/FFT (Forward)
# 定义FFT滤波器
/Filter/FFT Filter Definition
# 反向FFT变换
/Filter/FFT (Inverse)
# 基于波段组合的假彩色合成
/Raster Management/Build Layer Stack
# 选择RGB组成波段
/Statistics/Compute Band Statistics
# 波段加权真彩色增强
/Band Algebra/Band Math
```

### 7、正射校正

正射校正是对图像空间和几何畸变进行校正生成多中心投影平面正射图像的处理过程，它除了能纠正一般系统因素产生的几何畸变外，还可以消除地形引起的几何畸变。它采用少量的地面控制点与相机或卫星模型相结合，确立相机（传感器）、图像和地面3个平台的简单关系，建立正确的校正公式，产生精确的正射图像。

目前，ENVI仅支持两种正射校正模型，分别是严格轨道模型（Pushbroom）和有理多项系数（Rational Polynomial Coefficient , *RPC*）。

#### 1）无控制点的正射校正

这种校正方式主要依靠RPC文件和DEM数据定位和几何纠正图像，校正精度取决于所提供的RPC文件的定位精度和DEM分辨率。

```python
# 以下操作在ENVI Classic中完成
File/Open External File/QuickBird/GeoTIFF
```

#### 2）有控制点的正射校正

利用地面控制点参与正射校正可以提高校正精度，控制点的（x, y）坐标选择与Image to Map 几何校正的控制点选择方式一直，包括从矢量、图像、二进制文件和手动输入方式，z值可以是野外测量或者从高分辨率DEM数据中获取。

```python
# 以下操作在ENVI Classic中完成
File/Open External File/QuickBird/GeoTIFF
# 用完以上工具后，接着
Map/Orthorectification/QuickBird/Orthorectify QuickBird With Ground Control
```

#### 3）正射校正流程化工具

```python
/Geometric Correction/Orthorectification/RPC Orthorectification Workflow
```

#### 4）自定义RPC正射校正

航空图像（框幅式和数码像片）和丢失RPC参数卫星图像数据，可以根据相机参数、传感器参数、外方位元素和地面控制点构建严格的物理校正模型，从而实现正射校正。

```python
# 建立RPCs
/Geometric Correction/Orthorectification/Build RPCs
# 建立完后就可以使用正射校正流程化完成正射校正过程
```

### 8、辐射校正（辐射定标和大气校正）

遥感图像通常是用无量纲（无单位）的数字量化值（DN）记录信息的，进行遥感定量化分析时，常用到辐射亮度值、反射率值和温度值等物理量。通过辐射定标可以实现DN值与这些物理量的转化。大气校正能减少或消除大气对遥感图像的影响，得到真实的地表反射信息。

#### 1）辐射定标

辐射定标是将传感器记录的电压或数字量化值转换位绝对辐射亮度值（辐射率）的过程，或者转换为与地表（表观）反射率、表面（表观）温度等物理量有关的相对值的处理过程。

```python
# 通用定标工具
# 辐射亮度值（radiance）、大气表观反射率（reflectance）和亮度温度（brightness temperatures）
/Radiometric Correction/Radiometric Calibration
# 热红外数据定标
/Radiometric Correction/Calibrate TIMS
# NOAA AVHRR 数据定标
/Radiometric Correction/Calibrate AVHRR
# 海面温度（SST）计算
/Raster Management/Data-Specific Utilities/AVHRR Sea Surface Temperature (SST)
```

![image-20211104134712421](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/imgs/image-20211104134712421.png)

#### 2）大气校正

大气校正的目的是消除大气和光照等因素对地物反射的影响，获得地物反射率、辐射率、地表温度等真实物理模型参数，用来消除大气中水蒸气、氧气、二氧化碳、甲烷和臭氧对地物反射的影响。大多数情况下，大气校正同时也是反演地物真实反射率的过程。

**大气校正类型：**

- **绝对大气校正方法：**将遥感图像的DN值转换为地表反射率、地表辐射率和地表温度等的方法。常见的绝对大气校正方法有基于辐射传输模型的MORTRAN模型、LOW-TRAN模型、ATCOR模型和6S模型等，以及基于简化辐射传输模型的黑暗像元法、基于统计学模型的反射率反演。
- **相对大气校正方法：**校正后得到的图像上相同的DN值表示相同的地物反射率，其结果不考虑地物的实际反射率。常见的相对大气校正方法有基于统计的不变目标法和直方图匹配。

**大气校正方法：**

1. **简化黑暗像元法大气校正：**它的基本原理是在假设待校正的遥感图像上存在黑暗像元、地表郎伯面反射和大气性质均一，并忽略大气多次散射辐射照作用和临近像元漫反射作用的前提下，反射率很小（近似0）的黑暗像元由于大气的影响，器反射率相对增加。这样，将其他像元减去这些黑暗像元的像元值，就能减少大气（主要是大气散射）对整幅图像的影响，达到大气校正的目的。整个过程的关键是寻找黑暗像元以及黑暗像元增加的像元值。
2. **基于统计学模型的反射率反演：**主要有平场域法（Flat Field，FF）、对数残差法（Log Residuals）、内部平均法（Internal Average Relative Reflectance，IARR）和经验线性法（Empirical Line）
3. **不变目标法相对大气校正：**按照数学基础可以分为两种（非线性校正法和线性校正法），非线性校正法最经典的是直方图匹配。图像的直方图是图像中所有灰度值的概率分布。将校正图像的直方图与参考图像的直方图进行匹配，使两幅图像具有相同或相近的灰度值概率分布，达到两幅图像上同名地物具有相同灰度值的目的；线性校正法有个前提假设：不同时相的图像灰度值之间满足线性关系，这种假设在近似情况下是成立的。这样就可以通过线性等式来描述不同时相间的灰度关系，用x表示参考图像，y表示待校正图像，它们之间的线性关系可描述为 *y=a*x+b*

```python
# 简化黑暗像元法大气校正
/Radiometric Correction/Dark Subtraction
# 平场域法
/Radiometric Correction/Flat Field Correction
# 对数残差法
/Radiometric Correction/Log Residuals Correction
# 内部平均法
/Radiometric Correction/IAR Reflectance Correction
# 经验线性法——计算系数并定标工具
/Radiometric Correction/Empirical Line Compute Factors and Correct
# 经验线性法——使用现有系数定标
/Radiometric Correction/Empirical Line Correct Using Existing Factors
```

**大气校正工具：**

```python
# FLAASH工具
/Radiometric Correction/Atmospheric Correction Module/FLAASH Atmospheric Correction
# QUAC快速大气校正工具
/Radiometric Correction/Atmospheric Correction Module/QUAC - Quick Atmospheric Correction
```

### 9、自定义坐标系

国外商业软件的坐标系分为两种：标准坐标系（Standard）和自定义坐标系（Custom）。由于我国的特殊情况，往往需要自定义坐标系。

```python
/Raster Management/Edit ENVI Header
# 重投影
/Raster Management/Reproject Raster
```

## 处理路径

**定性路径**：（大气校正） >  几何校正  >  图像融合  >  正射校正  >  图像镶嵌  >  图像裁剪  >   图像增强  >  转8bit（看需求）  

**定量路径**：辐射定标  >  大气校正  > （分类和提取） >   模型反演  

**高分2号数据处理路径**：辐射定标 > 大气校正 > 几何纠偏 > 图像融合> 正射校正 

## 总结

遥感图像处理的基本流程和方法涵盖了从数据预处理到最终应用的完整过程。不同的应用需求决定了不同的处理路径，定量研究注重数据的物理真实性，定性研究注重空间位置的准确性。掌握这些基本的处理方法和技术要点，对于提高遥感数据的应用效果具有重要意义。

*注：以上所有工具箱路径都是基于ENVI 5.6版本*

## 相关资源

- [ENVI官方文档](https://www.l3harrisgeospatial.com/Software-Technology/ENVI)
- [遥感图像处理流程 - GDAL专栏](https://blog.csdn.net/liminlu0314/article/details/8757262)
- [遥感图像处理基础教程](https://www.researchgate.net/publication/remote-sensing-image-processing)
- [ENVI图像处理实战指南](https://www.l3harrisgeospatial.com/Learn/Resources/ENVI-Tutorials)

---

*感谢阅读，欢迎交流与反馈。*

*我的邮箱📮 arkin-dev@qq.com（需要交流请发邮件）。*