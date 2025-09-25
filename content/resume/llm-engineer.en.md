---
layout: resume/single.profile
title: "LLM Application Engineer Resume"
avatar: "https://github.com/arkin-developer/blog/raw/main/assets/img/author-offical.jpg"
draft: false
basic_info:
  name: "Lai Weiqian"
  target_position: "AI/LLM Application Development Engineer"
  email: "arkin-dev@qq.com"
  phone: "13430147593"
  city: "Dongguan, Shenzhen"
---

## Self-Evaluation

- ### Professional Background

  4 years of computer vision and LLM large model development experience, with professional growth capabilities in the computer software industry, small technical team management experience, familiar with project development processes, proficient in Python, Golang, TypeScript, C/C++ software development languages.

- ### Technical Skills

  1. Have successful experience in computer vision and LLM large model R&D cases, with independent project development practical experience.
  2. Understand machine learning algorithms such as Naive Bayes, SVM, understand the basic principles and architectures of attention mechanisms, Embedding, Transformer, BERT, GPT and other models.
  3. Familiar with detection algorithms such as YOLO series, Mobilenet series, SSD.
  4. Familiar with using LangChain, Eino, VLLM and other large model frameworks, convolutional neural networks and PyTorch deep learning framework.
  5. Master model compression and quantization methods, LoRA, QLoRA and other fine-tuning techniques, master long text training, and customized output.

  #### **OpenAI Development**

  1. Proficient in using OpenAI API for calling and customized development, including model selection, parameter tuning, and combination of language and multimodal
  2. Developed an AI Chatbot App supporting multimodal input based on OpenAI API.

  #### LangChain Development

  1. Familiar with Prompt Engineering techniques: Zero-shot, Few-shot, COT, ReAct, Reflexion, Prompt Chaining, etc.
  2. Master the use of components such as LLM, Chat, Models, PromptTemplates, OutputParse, Chains.
  3. Familiar with Verbose logging, Debug mode and LangSmith platform debugging and monitoring techniques.
  4. Able to build services based on LangServe, extend APIs for client calls.
  5. Able to use LangChain Chat History component to implement chat history persistence.
  6. Able to customize FunctionTool, implement synchronous and asynchronous tool calls. Implement Agent calling functions for chat, weather query and web search.
  7. Proficient in using LangChain to build local vector databases, implement storage and query. Proficient in using vector databases such as Chroma to implement Similarity Search, RAG enhanced retrieval.
  8. Able to use components such as Streamlit, Loader, Splitter, Embedding, Vector Store, Retrievers to develop RAG Q&A robots with memory capabilities. Implement historical record awareness and conversation history state management.

  #### **Hugging Face Model Training and Fine-tuning**

  1. Familiar with using Hugging Face API to call models, implement NLP tasks such as text generation, text classification and text Q&A.
  2. Proficient in using local models to design targeted models for downstream tasks, and train, evaluate and test.
  3. Master the three basic modes of model fine-tuning (full/incremental/partial), used BERT to fine-tune Chinese sentiment analysis datasets.
  4. Master the method of implementing ultra-long text training by changing model configuration information and initializing models, implement text multi-classification tasks.
  5. Proficient in designing corresponding models by adding fully connected layers to the top output category number according to downstream tasks. Master freezing encoding layers, only training embedding layers and fully connected layers.
  6. Proficient in using remote servers to fine-tune, test and evaluate DeepSeek with LoRA, model merging and quantization, deploy quantized models.
  7. Proficient in using ModelScope online training platform for data download and model calling, online training of GPT2 models.
  8. Understand the basic principles of LoRA fine-tuning, able to use LLaMA-Factory for fine-tuning training based on custom datasets.

- ### Professional Advantages

  Advocate lifelong learning and self-empowerment, have computer vision model and current popular large model application development capabilities, actively combine mature GIS systems with LLM large models to achieve more intelligent geographic information systems, allowing non-professionals to use them proficiently. Hope to have landing projects in more industries.

- ### Comprehensive Qualities

  Systematic and comprehensive logical thinking and analytical abilities, efficient closed-loop, rapid adaptability, extremely strong pressure resistance and stress response capabilities, team collaboration awareness, good professional ethics and corporate loyalty.

## Project Experience

- ### Guangdong Provincial Water Resources Department "Smart River Chief" AI Intelligent Detection System

  - **Project Introduction**:
    Addressing the Guangdong Provincial Water Resources Department's river "four chaos" governance intelligent inspection needs, traditional manual detection was inefficient, detection standards inconsistent, and lacked automated analysis capabilities. Developed river "four chaos" intelligent detection system based on computer vision and deep learning technologies, achieving remote sensing image automated analysis with detection accuracy reaching 80% of manual detection and processing speed improved by 4 times, providing AI technical support for smart water conservancy construction.

  - **Technical Solution**:
    Used YOLO series object detection algorithms and semantic segmentation technology to build intelligent detection models, built ten-thousand-level "four chaos" remote sensing detection dataset from scratch, established standardized data annotation, cleaning, and enhancement processes. Through model lightweighting and inference acceleration optimization (quantization deployment + ONNX/TensorRT), combined with Docker microservice and distributed deployment architecture, achieved efficient processing of large-scale remote sensing images and high-concurrency online detection services.

  - **Project Results**:
    Successfully built ten-thousand-level "four chaos" dataset reusable in the industry, forming standardized data assets. AI detection model prediction accuracy reached 75-80% of manual detection, single image detection time reduced from 12 seconds to 3 seconds, overall efficiency improved by 4 times+. Through distributed deployment, supported processing thousands of tile images per hour, achieving high-concurrency online inspection, providing reliable AI technical support for river governance, significantly improving supervision efficiency and intelligence level.

- ### Songshan Lake Drone Low-Altitude Police Intelligent Application System

  - **Project Introduction**:
    Addressing the Songshan Lake dense road section drone frequent patrol scenarios, traditional manual traffic accident monitoring was inefficient and manpower insufficient. Built hundred-drone concurrent AI detection system based on computer vision and multimodal large model technologies, achieving intelligent identification and automatic evidence collection of traffic accidents and abnormal personnel, providing intelligent solutions for low-altitude economy police applications.

  - **Technical Solution**:
    Used YOLOv8 small model combined with TensorRT inference acceleration to build real-time detection engine, achieving <280ms ultra-low latency traffic accident detection. Based on Beidou grid spatial encoding to achieve multi-drone identification deduplication, ensuring event uniqueness recording. Built intelligent review system based on Qwen2.5-VL multimodal large model, through instruction engineering and vision-text fusion technology, achieving intelligent review and optimization of detection results.

  - **Project Results**:
    Successfully built AI detection system supporting hundred-drone concurrent operation, single frame traffic accident detection latency reduced to <280ms, meeting real-time requirements for continuous patrol. Multimodal large model intelligent review system achieved 60% average accuracy in accident identification, processing efficiency improved to reviewing hundreds of events per hour, significantly reducing manual misdetection processing workload. Beidou grid encoding-based event deduplication mechanism ensured unique recording of each accident, improving event accuracy, providing complete technical solutions for low-altitude police intelligent applications.

- ### GeoAI Intelligent Agent Internal R&D Project

  - **Project Introduction**:
    Addressing traditional GIS systems' complex operation requiring professional technical personnel, developed spatiotemporal intelligent agent system based on large model technology. Combined Beidou grid encoding engine with MCP protocol to achieve natural language instruction-driven GIS system spatiotemporal task automation, including drone scheduling, spatial query and other core functions, promoting product intelligence transformation, enabling non-professionals to interact with GIS systems through natural language.

  - **Technical Solution**:
    Based on DeepSeek large model for instruction fine-tuning and private deployment, learning spatiotemporal grid task concepts and GIS domain knowledge. Designed and implemented MCP services and frontend display interfaces, building seamless connection between intelligent agents and business systems. Developed GIS data parsing and context interfaces, converting complex spatiotemporal data (remote sensing images, vector data, etc.) into structured information processable by models, achieving intelligent agents' deep understanding of spatial data.

  - **Project Results**:
    Successfully achieved natural language-driven spatiotemporal grid task reasoning execution, model task understanding accuracy reached 60%+, first application of large model technology to GIS spatiotemporal task automation field. Developed MCP services supported intelligent agentization of typical tasks such as drone scheduling and spatial query, system could simultaneously respond to hundreds of task requests, achieving high-concurrency intelligent services. GIS data parsing and context interfaces significantly improved task execution accuracy by about 40%, greatly reducing manual intervention requirements, providing complete technical solutions for GIS product intelligence transformation.

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
*Last updated: September 2025*