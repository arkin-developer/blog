---
title: "NYC Taxi Spatiotemporal Traffic Flow Prediction Model"
description: "Urban traffic demand spatiotemporal prediction based on spatial PatchTST"
date: 2025-01-27
tags: ["time series forecasting", "PatchTST", "traffic prediction", "spatiotemporal data", "deep learning"]
categories: ["notebooks"]
github: "https://github.com/arkin-developer/notebooks/blob/main/spatiotemporal-forecasting/spatiotemporal-forecasting.ipynb"
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/spatiotemporal-forecasting/spatiotemporal-forecasting.ipynb"
modelscope: "https://modelscope.cn/notebook/share/ipynb/b0611913/spatiotemporal-forecasting.ipynb"
colab: "https://colab.research.google.com/drive/1Gm6qFfewcYPnKB3QODzIADQuhnJI7cDX?usp=sharing"
---

{{< lead >}}
🚀[ModelScope](https://modelscope.cn/notebook/share/ipynb/b0611913/spatiotemporal-forecasting.ipynb) 🚀[Colab](https://colab.research.google.com/drive/1Gm6qFfewcYPnKB3QODzIADQuhnJI7cDX?usp=sharing) 🚀[Github](https://github.com/arkin-developer/notebooks/blob/main/spatiotemporal-forecasting/spatiotemporal-forecasting.ipynb)
{{< /lead >}}


## Jupyter Notebook Preview
<iframe 
  src="https://modelscope.cn/notebook/share/ipynb/b0611913/spatiotemporal-forecasting.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>

[*Open notebooks in new tab*](https://modelscope.cn/notebook/share/ipynb/b0611913/spatiotemporal-forecasting.ipynb)


## Project Overview

> Note: This project is based on real NYC taxi GPS trajectory data, utilizing a spatial PatchTST deep learning model to predict the spatiotemporal distribution of urban traffic demand. The model can predict traffic flow distribution for the next 3 hours (6 time steps) based on the past 6 hours (12 time steps) of traffic flow data.

**Objective**: Build a modern spatiotemporal sequence prediction model for urban traffic scheduling optimization and demand forecasting. The model adopts Transformer architecture with parameter efficiency and fast training characteristics, capable of handling 32×32 grid-scale spatiotemporal data.
**Hardware Requirements**: Devices supporting Apple Silicon MPS or CUDA (recommended 4GB+ memory);
**Software Requirements**: Python 3.8+, PyTorch 2.0+, with MPS or CUDA support.

------

## ✅ What This Tutorial Includes

1. Environment setup and hardware detection
2. Real spatial time series dataset download
3. Dataset visualization and analysis
4. Spatial PatchTST neural network construction
5. Dataset processing and training preparation
6. Model training and monitoring
7. Model evaluation and visualization
8. Project summary and future prospects


## 🔬 Technical Features

- **Modern Architecture**: Uses 2023 SOTA PatchTST Transformer architecture
- **Parameter Efficient**: ~93K parameters, 81% reduction compared to traditional ConvLSTM
- **Spatiotemporal Modeling**: Simultaneously processes spatial (32×32 grid) and temporal (6h→3h) dimensions
- **Real Data**: Based on real traffic data from NYC taxi GPS trajectories
- **Dual-Channel Prediction**: Simultaneously predicts inflow and outflow
- **Cross-Platform Support**: Supports Apple Silicon MPS, CUDA, and CPU
- **Business-Oriented**: Targeted at real traffic scheduling and operational optimization scenarios

## 📊 Model Architecture

- **Input**: `(batch_size, 12, 2, 32, 32)` - Past 6 hours of dual-channel spatial data
- **Output**: `(batch_size, 6, 2, 32, 32)` - Future 3 hours prediction
- **Core Components**: Temporal Patch embedding + Spatial position encoding + Transformer encoder
- **Prediction Head**: Multi-layer perceptron + Output projection layer
- **Feature Dimensions**: d_model=64, n_heads=4, n_layers=2 (lightweight configuration)

## 🎯 Application Scenarios

- 🚗 Taxi driver navigation optimization
- 📊 Urban traffic scheduling systems
- 💰 Dynamic pricing strategy development
- 🏙️ Urban traffic planning
- 📈 Demand forecasting and capacity allocation
- 🚦 Intelligent traffic management systems

## 🙏 Support the Author

If you find this project helpful, you can buy the author a Luckin Coffee ☕️

<div style="text-align: center; margin: 2rem 0;">
  <!-- <img src="/img/reward.jpg" alt="Reward QR Code" style="width: 100%; max-width: 400px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
  <p style="margin-top: 1rem; color: #666; font-size: 0.9rem;">Scan to support the author</p> -->
  
  <!-- Mobile-friendly payment links -->
  <div style="display: flex; justify-content: center; gap: 2rem; margin-top: 1.5rem; flex-wrap: wrap;">
    <a href="https://arkin-developer.github.io/blog/img/zhifubao-reward.jpg" target="_blank" rel="noopener" style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #1677ff; color: white; text-decoration: none; border-radius: 8px; font-size: 0.9rem; transition: all 0.3s ease; box-shadow: 0 2px 4px rgba(22,119,255,0.3);">
      <span style="font-size: 1.2rem;">🩵</span>
      <span>Alipay Tip ¥9.9</span>
    </a>
    <a href="https://arkin-developer.github.io/blog/img/wechat-reward.png" target="_blank" rel="noopener" style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #07c160; color: white; text-decoration: none; border-radius: 8px; font-size: 0.9rem; transition: all 0.3s ease; box-shadow: 0 2px 4px rgba(7,193,96,0.3);">
      <span style="font-size: 1.2rem;">💚</span>
      <span>WeChat Tip ¥9.9</span>
    </a>
  </div>
  
  <p style="margin-top: 1rem; color: #999; font-size: 0.8rem;">Click buttons to view QR codes for mobile scanning</p>
</div>

---

*You can navigate from the menu bar to the corresponding Jupyter Notebook cloud service platforms to try it out, or download the Notebook file to run locally.*
