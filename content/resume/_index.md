---
layout: resume/list.overview
title: "个人简历"
description: "我的技能和工作经历"
avatar: "/img/author-offical.jpg"
---

 

## 👤 基本信息

- **姓名**：赖为乾（Arkin）
- **职位**：Web全栈开发者 / AI应用全栈 / GIS开发
- **邮箱**：arkin-dev@qq.com
- **GitHub**：https://github.com/arkin-developer

## 技术栈

### 编程语言
- **Python（熟练）**
- **Golang（熟练）**
- **JavaScript/TypeScript（熟悉）**
- **C++（Native 库二次封装 / Python/Golang 扩展封装）**
- **ArkTS（学习中）**

### AI&大模型应用开发 · [查看岗位版简历](/resume/llm-engineer/)
- **计算机视觉**
  - **任务类型**：目标检测、图像分类、语义分割
  - **方法与框架**：YOLO 系列（YOLOv5/YOLOv8）、CNN（ResNet、EfficientNet）、U-Net、DeepLab
  - **工具/库**：PyTorch、OpenCV、Albumentations
  - **工程化能力**：数据集整理、模型训练、模型部署、接口封装
- **大模型（LLM & Multi-modal AI）**
  - **任务类型**：文本生成与摘要、问答系统、视频/音频文本处理、多模态数据处理
  - **框架与平台**：OpenAI API、LangChain、Golang Eino
  - **协议**：MCP（模型上下文协议）
  - **微调能力**：LoRA、PEFT、Prompt Tuning
  - **工程化能力**：数据整理、上下文管理、服务化封装（API/Agent）、容器化部署
- **智能体开发**
  - **任务类型**：问答智能体、RAG（检索增强生成）、多模态交互、任务自动化
    **方法与框架**：LangChain、LlamaIndex、AutoGPT、BabyAGI、Custom Toolchains
    **能力点**：
    - 上下文管理与多轮对话
    - 知识检索与动态信息注入（RAG）
    - 多模态数据处理（文本 + 图像 + 音频）
    - Agent 流程设计与任务调度
    **工程化能力**：服务化封装（API/Agent）、容器化部署（Docker/K8s）、日志与监控、性能优化

### Web全栈开发
- **前端开发（Frontend）**
  - **基础语言**：HTML、CSS、JavaScript、TypeScript
  - **框架与库**：React、Vue、Svelte、Next.js、Nuxt.js
  - **UI 框架**：TailwindCSS、Bootstrap、Ant Design、ShadCN UI
  - **地图/可视化**：OpenLayers、Leaflet、ECharts
  - **前端工程化**：Webpack、Vite、ESBuild、模块化开发、组件化开发
- **后端开发（Backend）**
  - **开发语言**：Python（FastAPI、Flask、Django）、Golang（Gin、Echo、Fiber）、Node.js（Express、NestJS）、Java（Spring Boot）
  - **API 开发**：RESTful API、GraphQL、gRPC
  - **业务逻辑与微服务**：微服务架构设计、消息队列（RabbitMQ、Kafka）、任务调度（Celery、Go Cron）
  - **安全与鉴权**：JWT、OAuth2、RBAC、ACL
- **数据库与存储**
  - **关系型数据库**：PostgreSQL（PostGIS）、MySQL、SQLServer
  - **非关系型数据库**：MongoDB（GeoJSON 支持）、Redis、ElasticSearch
  - **缓存与索引**：Redis、Memcached、ElasticSearch Geo/Fulltext
- **DevOps 与工程化能力**
  - **版本管理**：Git、GitHub/GitLab
  - **容器与部署**：Docker、Docker Compose、Kubernetes
  - **CI/CD 工具**：GitHub Actions、GitLab CI、Jenkins
  - **日志监控**：Prometheus + Grafana、ELK（Elasticsearch + Logstash + Kibana）
- **前后端协作与优化**
  - **数据接口设计**：OpenAPI、Swagger
  - **状态管理**：Redux、Pinia、React Query
  - **性能优化**：前端懒加载、SSR/CSR、服务端缓存、数据库索引优化
  - **测试**：单元测试（Jest、PyTest、Go Test）、集成测试、端到端测试（Cypress、Playwright）

### GIS开发 · [查看岗位版简历](/resume/gis-engineer/)
- **数据预处理** 
  - **工具**：ArcGIS、ENVI、QGIS 软件熟练使用，Python GDAL、Rasterio 工具库熟练使用
  - **影像预处理**：辐射校正、大气校正、几何校正、正射校正、全色锐化（Pan-Sharpening）、批量裁剪、重采样、拼接和镶嵌
  - **矢量数据处理**：矢量数据清理、拓扑修正、投影变换、缓冲区生成、面/线/点计算、矢量与栅格融合
  - **坐标系统**：WGS84、CGCS2000、UTM、国家2000坐标系（常用投影及转换）、坐标投影和坐标系统一
- **遥感影像图像分类识别**
  - **传统方法**：监督分类（SVM、RF、最大似然）、非监督分类（K-means、ISODATA）
  - **深度学习方法**：CNN 分类（ResNet、EfficientNet）、语义分割（U-Net、DeepLab、SegFormer）、目标检测（YOLO、Mask R-CNN）
  - **特征提取**：纹理分析（GLCM、LBP）、光谱指数（NDVI、NDWI、NDBI）
  - **工具/框架**：ArcGIS Pro、QGIS、Scikit-learn、TensorFlow、PyTorch
- **遥感影像变化检测**
  - **传统方法**：图像差分、比值法、PCA 差分、分类后比较
  - **深度学习方法**：Siamese Network、FC-Siam 系列、基于 Transformer 的时序变化检测
  - **多源融合**：光学 + SAR + LiDAR
  - **工具/框架**：PyTorch、TensorFlow、OpenCV、ChangeDetectionNet
- **WebGIS全栈开发**
  - **前端**：OpenLayers、Leaflet、Cesium
  - **后端**：GeoServer、MapServer、PostGIS、Tile38
  - **接口服务**：OGC 标准（WMS、WFS、WMTS、WCS）、RESTful API、GraphQL
  - **架构**：微服务 + 容器化（Docker、Kubernetes）、云原生 GIS 部署
  - **开发语言**：Python（FastAPI）、Golang（Gin）、JavaScript（Node.js、TypeScript）
- **GIS空间计算**
  - **空间数据结构**：R-Tree、QuadTree、GeoSOT
  - **空间分析**：缓冲区、叠加分析、网络分析、空间插值
  - **数据库**：PostGIS、MongoDB（GeoJSON）、ClickHouse-GIS、ElasticSearch Geo
  - **工具/库**：Shapely、GEOS、GDAL/OGR、CGAL

### 鸿蒙开发
- **北向开发**
  - HarmonyOS NEXT 5 开发

## 工作经历

### AI应用开发工程师（主管） (2022.04-2025.07)
**中科云遥（东莞）科技有限公司** - 东莞

- 1）参与广东省水利厅“广东智慧河长”服务项目（）

  - 角色：图像算法工程师
  - 背景：面向河道“四乱”治理（乱占、乱采、乱堆、乱建）的智能巡查与检测需求。
  - 任务/目标：
    - 基于历史业务影像，构建“四乱”遥感图像检测数据集（标注+清洗+增强）。
    - 使用 **YOLOv5/YOLOv8** 进行目标检测训练，并进行迁移学习与推理加速（TensorRT/ONNX）。
    - 开发数据预处理与推理脚本（Python + PyTorch + GDAL），提升自动化程度。
  - 关键贡献/成果
    - 准确率达到人工巡检的80%，并成功落地在“智慧河长”平台，实现河道巡查影像的自动化检测。
    - 将单次影像检测处理速度从 **12s 缩短到 3s**，大幅提升业务可用性。

- 2）北斗网格编码引擎内部研发项目

  - 角色：团队负责人
  - 背景：公司原先依赖外部厂商提供的北斗网格编码引擎，但由于业务深入后外部服务无法满足需求，因此决定自主研发可替代的核心引擎。
  - 任务/目标：
    - 研究核心的编码算法
    - 利用开源组件+编码算法搭建自主可控的网格编码引擎
    - 解决引擎在三维空间的编码、存储、计算和可视化的能力
  - 关键贡献/成果：
    - 利用C/C++ 的CGAL库封装对于常见的三维数据格式的解码和编码接口
    - 搭建引擎的可视化模块，通过OCR标准完成矢量、栅格的瓦片服务和Cesium的3dtiles数据瓦片服务
    - 搭建基于网格的无人机飞行路径规划服务，支持

- 3）东莞市松山湖公安项目

  - 角色：无人机AI检测方案负责人
  - 背景：松山湖公安部门面临低空交通与治安巡查需求，但现有系统无法支持多架无人机实时监控，因此需要研发支持百架次并发的无人机AI检测系统。
  - 职责：
    - 分析目前无人机AI进行城市管理的技术方案
    - 训练交通事故检测模型、夜间异常人员检测模型
    - 解决私有化部署以及实时（300ms以内）的检测方案
  - 关键贡献：
    - 利用TensorRT完成模型量化与加速，将单帧检测延迟优化至 **<280ms**，满足公安部门实时性要求。
    - 构建百架次无人机的并发检测架构，支持事件级别的唯一性识别与存储。

- 4）参与纵向项目民用航天技术预研究项目

  - 角色：团队负责人
  - 背景：在民用航天应用研究背景下，公司承担纵向科研任务，需要探索空间信息智能处理与AI应用的可行性，以服务未来航天产业布局。
  - 职责：
    - 完成项目申报
    - 中期进度报告编写
    - 技术可行性报告
    - 专利论文成果申报
  - 关键贡献：
    - 完成四篇发明专利申请（涵盖时空信息处理、遥感智能解译、网格编码等方向）。

- 5）时空网格智能体内部研发项目

  - 角色：团队负责人（解决方案梳理）

  - 背景：在大模型私有化与 MCP 服务并行发展的趋势下，公司决定研发时空网格智能体，探索将核心时空产品与智能体技术结合的新模式。

  - 任务 ：

    - 国产大模型微调，将DeepSeek模型进行指令微调，学习时空网格智能体的概念
    - 搭建产品的MCP服务
    - 搭建可视化验证方案

  - 关键贡献：

    - 基于DeepSeek大模型完成时空任务场景的指令微调，首次实现时空网格任务在自然语言下的推理执行。

      搭建原型级MCP服务，实现无人机调度、空间查询等典型任务的智能体化。

      在公司内部展示验证系统，推动智能体技术与核心GIS产品的融合

- 6）松山湖低空经济项目

  - 角色：无人机路径规划方案提供者
  - 背景：松山湖正在打造低空经济示范区，但无人机调度与空域管理能力不足，因此需要研发低空智能管理与任务规划系统。
  - 职责：
    - 开发无人机飞行模拟系统
    - 基于此项目开发北斗网格编码引擎的无人机路径规划服务
  - 关键贡献：
    - 无人机路径规划服务支持基于北斗网格的空域划分，极大提升飞行路径规划精度与调度灵活性。
    - 系统成为松山湖低空经济示范区的核心管理模块之一

- 7）南沙低空经济项目

  - 角色：

    - 无人机调度与低空空域管理技术负责人

  - 背景/目标：

    - 南沙区打造粤港澳大湾区低空经济先行区，需要构建覆盖城市级别的低空调度与任务分配系统。

  - 职责：

    - 负责低空经济平台的总体方案设计与技术路线规划；

      基于网格编码和时空数据库构建空域划分与管制方案；

      集成AI检测与路径规划服务，支持低空任务调度。

  - 关键贡献：

    - 成功交付南沙低空经济平台的核心模块，支持百架次无人机任务调度；

      构建低空空域网格化管理系统，实现从空域划分 → 飞行申请 → 路径规划 → 实时监控的闭环；

      方案入选区级重点低空经济试点项目。

### GIS开发工程师(2021.07-2022.03)
**中科云遥（东莞）科技有限公司** - 东莞

- 1）参与广东省水利厅“广东智慧河长”服务项目（2021-2023）

  - 角色：GIS数据处理工程师
  - 背景/目标：广东省水利厅需要对河道进行“四乱”治理监控，但河道数据量大、更新频繁，人工处理矢量数据和遥感影像效率低
  - 职责：
    - 负责河道矢量数据和遥感影像的清洗、入库与空间分析；
    - 负责将数据处理完成专题图制作和
  - 关键贡献：
    - 自动化处理脚本使每期成果数据交付时间缩短 **50%**。
    - 自动制图系统提升制图效率 **300%**，原本需要 3 人完成的任务实现无人操作，显著节省人力成本。

- 2）参与东莞市“松山湖大气监测”服务项目

  - 角色：GIS数据处理与平台开发工程师

  - 背景：松山湖管委会需要对园区空气质量进行监测与空间可视化，但现有数据分散、缺乏统一展示与分析能力。

  - 职责：

    - 从0到1搭建大气监测GIS平台，包括数据采集、清洗、空间入库；

      开发监测点位的动态可视化地图服务；

      支持空气质量的时间序列分析与专题图输出。

  - 关键贡献：

    - 构建首个园区级大气监测GIS系统，实现空气质量的 **分钟级动态可视化**；
    - 将多源监测点位数据整合入库，显著提升管委会的环境监管能力；
    - 平台通过验收并长期运行，成为松山湖生态环境监管的重要工具。



个人独立开发项目

1）bilibili视频总结网站

2）数字平台导游项目



## 教育背景

### 理学学士 (2017-2021)
**嘉应学院** - 梅州, 广东

- 毕业论文《无人机柚树AI统计》

---

*最后更新：2024年1月*
