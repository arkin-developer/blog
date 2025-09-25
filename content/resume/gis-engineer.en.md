---
layout: resume/single.profile
avatar: "https://github.com/arkin-developer/blog/raw/main/assets/img/author-offical.jpg"
title: "GIS Engineer Resume"
description: "WebGIS/Spatial Analysis/Remote Sensing/3D/Engineering"
draft: false
download: "https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/resume/GIS%E5%BC%80%E5%8F%91%E5%B7%A5%E7%A8%8B%E5%B8%88_%E8%B5%96%E4%B8%BA%E4%B9%BE_%E4%B8%9C%E8%8E%9E_4%E5%B9%B4.pdf"
basic_info:
  name: "Lai Weiqian (Arkin)"
  target_position: "GIS Development Engineer"
  email: "arkin-dev@qq.com"
  phone: "13430147593"
  city: "Dongguan, Shenzhen"
---

## Self-Assessment

- ### Professional Background

  4 years of experience in Geographic Information System development and remote sensing intelligent research, with professional growth capabilities in the computer software industry, team management experience in small technical teams, familiar with GIS system project development processes, and proficient in Python, Golang, TypeScript, C/C++ software development languages.

- ### Professional Skills

  1. Successfully implemented geographic information system and remote sensing image intelligent interpretation research cases, with independent project development experience.
  2. Understand remote sensing image imaging principles, proficient in remote sensing image preprocessing technologies including radiometric calibration, geometric correction, atmospheric correction, fusion and mosaic.
  3. Familiar with **spatial database and GIS service construction**, able to manage and visualize spatial data based on PostGIS, GeoServer, Mapbox, etc.
  4. Possess **AI and remote sensing/geographic information integration research capabilities**, including image classification, object detection, change detection and other application scenarios, able to integrate deep learning frameworks (PyTorch, TensorFlow) with remote sensing data.

  #### **Esri Software**

  1. Proficient in using ArcGIS platform (ArcGIS Pro, ArcGIS Server, ArcGIS API for Python/JavaScript) for data processing, spatial analysis and secondary development.
  2. Proficient in using ArcPy SDK, including batch thematic map generation and process-based GIS data processing model construction.

  #### **ENVI Software**

  1. Familiar with ENVI applications in remote sensing image **quantitative analysis**, including spectral index calculation, vegetation coverage estimation, classification accuracy evaluation, etc.
  2. Proficient in ENVI **high-resolution image fusion** technologies (such as Principal Component Analysis PCA, Gram-Schmidt fusion, band ratio method, etc.) to improve image clarity and application value.

  #### **Cesium Development**

  1. Familiar with Cesium 3D visualization framework, able to build 3D earth scenes, display and interact with geographic features based on CesiumJS.
  2. Have experience in 3D geographic big data visualization, able to achieve unified display of multi-source data such as images, vectors, and point clouds.
  3. Have experience combining LLM large models, successfully implemented projects that control Cesium to execute tasks through ChatBox dialogue.

  #### **Spatial Database Development**

  1. Proficient in using **GeoServer, MapServer, ArcGIS Server** to publish WMS/WFS/WMTS services.
  2. Able to develop service-oriented interfaces and system integration based on **OGC standard protocols** (such as WMS, WFS, WCS).
  3. Familiar with **PostGIS, SpatiaLite** and other spatial databases, master spatial indexing, topological relationship operations, spatiotemporal data modeling and optimization.
  4. Use **Python (FastAPI, Robyn), Golang (Gin)** to build GIS server interfaces, implement geographic data management, analysis and visualization services.

  #### **Deep Learning Model Development and Optimization**

  1. Proficient in using **PyTorch, TensorFlow, MMDetection, SegFormer, DeepLab, UNet** and other model frameworks.
  2. Able to perform **transfer learning and fine-tuning (Fine-tuning / LoRA)** based on pre-trained models (such as ResNet, Swin Transformer).
  3. Familiar with **model compression and deployment** (quantization, distillation, ONNX, TensorRT), can deploy inference services on edge or cloud.

- ### Professional Advantages

  Possess solid GIS and remote sensing background, combined with full-stack development and artificial intelligence application experience, able to effectively integrate computer vision and large model technologies into geographic information systems, achieve closed-loop development from data processing to intelligent applications, and promote the implementation and popularization of GIS in more industry scenarios.

- ### Comprehensive Quality

  Systematic and comprehensive logical thinking and analytical ability, efficient closed-loop, rapid adaptability, extremely strong pressure resistance and stress response ability, team collaboration awareness, good professional ethics and corporate loyalty.

## Project Experience

- ### Guangdong Provincial Water Resources Department "Smart River Chief" Service Project

  - **Project Introduction**:
    Addressing the Guangdong Provincial Water Resources Department's river "four chaos" governance monitoring needs, traditional manual processing of vector data and remote sensing images was inefficient, with large data volumes and frequent updates. Initially responsible for province-wide river high-resolution remote sensing image one-stop processing and "four chaos" vector data cleaning and storage, later transitioned to remote sensing image algorithm engineer, developing river "four chaos" intelligent detection system based on YOLO series algorithms, achieving remote sensing image automated analysis with detection accuracy reaching 80% of manual detection and processing speed improved by 4 times.

  - **Technical Solution**:
    Initially used Python + GDAL technology stack to implement "four chaos" result vector data integrity checking automation script tools, combined with Python + ArcPy for thematic map automation generation. Later introduced object detection and change detection models (YOLO series, semantic segmentation, image differencing, etc.), built ten-thousand-level "four chaos" dataset, optimized through model lightweighting and inference acceleration (quantization deployment + ONNX/TensorRT), established Docker microservice and distributed deployment architecture.

  - **Project Results**:
    Data processing stage: Data integrity checking automation script tools improved audit efficiency by 200%, storage success rate reached 100%. Thematic map automation generation tools improved mapping efficiency by 600% (reduced from 6 days to 1 day). Algorithm development stage: Built ten-thousand-level "four chaos" dataset, forming reusable data assets in the industry. Model prediction accuracy reached 75-80% of manual detection, single image detection time reduced from 12 seconds to 3 seconds, overall efficiency improved by 4 times+. Through distributed deployment, supported processing thousands of tile images per hour, achieving high-concurrency online inspection.

- ### Dongguan City "Songshan Lake Atmospheric Remote Sensing Monitoring" Service Project

  - **Project Introduction**:
    Addressing Dongguan City Songshan Lake park atmospheric pollutant monitoring needs, traditional monitoring data lacked predictive capability and visualization display effects. Led the construction of Songshan Lake regional atmospheric pollutant short-term prediction model, utilizing remote sensing and monitoring data, developing a complete technical chain from data processing → spatiotemporal prediction → GIS visualization integration, providing future hours of air quality forecast services for the management committee.

  - **Technical Solution**:
    Used ConvLSTM to build spatiotemporal prediction model framework, integrated park monitoring and remote sensing data, established dataset with spatiotemporal grid features. Designed standardized data processing workflow (cleaning, feature engineering, format conversion), developed model inference interface deeply integrated with GIS platform, achieved short-term prediction and hourly dynamic prediction visualization of atmospheric pollutants (PM₂.₅, PM₁₀, etc.).

  - **Project Results**:
    Spatiotemporal prediction model compared to baseline methods, short-term prediction accuracy improved by 12-18% (RMSE reduced to 6-8μg/m³, R² improved to 0.5-0.56), significantly enhanced reliability of future hours atmospheric pollutant concentration prediction. Data preprocessing efficiency improved by 30%+, missing value rate reduced to <3%, ensuring stability of model training data. Successfully achieved hourly dynamic prediction and visualization forecast service for air quality online, serving daily monitoring and emergency decision-making of the management committee.

- ### Guangzhou Nansha District Low-Altitude Intelligence Project

  - **Project Introduction**:
    Addressing Guangzhou City Nansha District's strategic need to build the Greater Bay Area low-altitude economy pilot zone, traditional drone management lacked city-level scheduling capability and airspace control system. Built city-level low-altitude scheduling and task allocation system, achieving drone airspace division, task scheduling and real-time monitoring closed-loop, becoming a district-level key pilot project, providing technical support for low-altitude economic development.

  - **Technical Solution**:
    Designed city-level low-altitude economy platform overall solution and technical route, constructed airspace division and control plan, integrated AI detection and path planning services. Built city-level drone task scheduling system, achieving airspace division → flight application → path planning → real-time monitoring closed-loop management, supporting multi-drone collaborative operations and intelligent scheduling.

  - **Project Results**:
    Successfully delivered Nansha low-altitude economy platform core modules, supporting hundreds of drones simultaneous scheduling, achieving large-scale drone cluster management capability. Built low-altitude airspace grid management system, improved city-level drone operation safety and efficiency, became an important technical pilot project for the Greater Bay Area low-altitude economy pilot zone, providing replicable technical solutions for low-altitude economic development.

- ### Shenzhen City "Smart Urban Planning" WebGIS Platform Project (2023.08-2024.02)

  - **Project Introduction**:
    Addressing Shenzhen City urban planning management department's needs for multi-source spatial data integration display and planning analysis decision support, traditional GIS systems lacked web-based, real-time and multi-user collaborative capabilities. Built WebGIS-based urban planning comprehensive management platform, integrating multi-source spatial data, providing spatial analysis tools, achieving planning solution visualization display, providing technical support for urban planning decisions.

  - **Technical Solution**:
    Adopted PostGIS + GeoServer + OpenLayers technology stack to build WebGIS platform, based on PostGIS for spatial data storage and spatial analysis, publishing WMS/WFS/WMTS services through GeoServer. Used TypeScript + React to develop frontend interactive interface, integrated ArcGIS API for JavaScript to achieve advanced spatial analysis functions. Used Python FastAPI to build backend service interfaces, implementing spatial data management and analysis services.

  - **Project Results**:
    Successfully built PostGIS database supporting TB-level spatial data storage and query, spatial query response time controlled within 200ms. Published 50+ WMS/WFS services, supporting thousand-level concurrent user access, system availability reached 99.9%. Integrated 20+ spatial analysis tools including buffer analysis, overlay analysis, network analysis, providing decision support for urban planning departments, improving planning solution evaluation efficiency by 60%+.

- ### Beidou Grid Encoding Engine Internal R&D Project (2023.04-2025.07)

  - **Project Introduction**:
    Addressing the company's original reliance on external vendors' Beidou grid encoding engines, with business deepening external services unable to meet needs in functional scalability, 3D support and performance. Independently developed Beidou grid encoding core engine, responsible for implementing 3D spatial encoding algorithms based on C/C++ CGAL library, building visualization modules and drone path planning services, creating controllable and scalable core engine replacement solution.

  - **Technical Solution**:
    Designed and implemented unified encoding and indexing scheme for 2D/3D spatial data, encapsulated 3D spatial data processing core algorithms (C/C++ CGAL), built encoding engine computing, storage and processing modules. Built visualization services providing OCR standard vector/raster tiles and Cesium 3D Tiles data services, developed drone path planning modules supporting complex terrain and building environment flight tasks, developed microservice encoding engine and Python SDK for cross-platform calling.

  - **Project Results**:
    Achieved efficient decoding and encoding of common data formats, ensuring core algorithm autonomy and control. Built visualization modules providing scalable data display capability, supporting OCR standard tiles and 3D Tiles data services. Built drone path planning service achieving precise flight path planning in urban building clusters and complex terrain, task success rate improved to 95%+. Developed microservice encoding engine and Python SDK for cross-platform calling and multi-system integration, engine response capability improved by dozens of times, enabling multi-business systems simultaneous access.

## Education Background

### Bachelor of Science (2017-2021)

*Geographic Information Science major, focusing on innovative applications combining AI and remote sensing technologies.*

**Jiaying University** - Meizhou, Guangdong

- Graduation Thesis: "[Research on Individual Pomelo Tree Recognition Methods in Meizhou Based on Faster R-CNN and UAV Multispectral Images](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/%E5%9F%BA%E4%BA%8EFaster%20R-CNN%E5%92%8C%E6%97%A0%E4%BA%BA%E6%9C%BA%E5%A4%9A%E5%85%89%E8%B0%B1%E5%BD%B1%E5%83%8F%E7%9A%84%E6%A2%85%E5%B7%9E%E6%9F%9A%E6%A0%91%E5%8D%95%E6%A0%AA%E8%AF%86%E5%88%AB%E6%96%B9%E6%B3%95%E7%A0%94%E7%A9%B6_%E7%BB%88%E7%A8%BF.pdf)"
- IEEE Journal: "[Detecting and Mapping Individual Fruit Trees in Complex Natural Environments via UAV Remote Sensing and Optimized YOLOv5](https://doi.org/10.1109/JSTARS.2024.3379522)"
- General Journal: "[Impact of Urban Landscape Pattern Changes on Ecosystem Service Value](https://www.zhangqiaokeyan.com/academic-journal-cn_popular-science-technology_thesis/0201279726706.html)"
- Patent: "[Plant Recognition and Mapping Method and System Based on UAV Image Deep Learning](https://patents.qizhidao.com/search/detail/WZIP_8aa30efc33b17eb6ca4e401ed2d6e97e?orderColumn=undefined&searchType=simple_search&orderType=undefined&filter=&tab=0&from=simple&businessSource=%E6%9F%A5%E4%B8%93%E5%88%A9-%E6%90%9C%E7%B4%A2%E7%BB%93%E6%9E%9C%E5%88%97%E8%A1%A8-%E6%90%9C%E7%B4%A2%E6%9B%B4%E5%A4%9A&statement=%E8%B5%96%E4%B8%BA%E4%B9%BE&semanticId=&patentName=%E5%9F%BA%E4%BA%8E%E6%97%A0%E4%BA%BA%E6%9C%BA%E5%9B%BE%E5%83%8F%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0%E7%9A%84%E6%A4%8D%E6%A0%AA%E8%AF%86%E5%88%AB%E5%88%B6%E5%9B%BE%E6%96%B9%E6%B3%95%E5%92%8C%E7%B3%BB%E7%BB%9F&rightSidebar=false&imageSessionKey=&simpleMode=1&proVersion=&sortType=0&current=1&pageSize=20&viewMode=1&leftTabVal=0&rightTabVal=3&norefetch=true)" - Under Substantive Examination

---

*Personal Blog: https://arkin-developer.github.io/blog*  

*Last Updated: September 2025*