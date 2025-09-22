---
title: "NYC出租车乘客上下车流量时空预测模型案例"
description: "基于空间PatchTST的城市交通需求时空预测"
date: 2025-01-27
tags: ["时序预测", "PatchTST", "交通预测", "时空数据", "深度学习"]
categories: ["notebooks"]
github: "https://github.com/arkin-developer/notebooks/blob/main/spatiotemporal-forecasting/spatiotemporal-forecasting.ipynb"
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/spatiotemporal-forecasting/spatiotemporal-forecasting.ipynb"
modelscope: "https://modelscope.cn/notebook/share/ipynb/394bec82/spatiotemporal-forecasting.ipynb"
colab: "https://drive.google.com/file/d/1XSU_cRrz3Afg-fv1N-BJHx1Rk59pqnQ-/view?usp=drive_link"
---

{{< lead >}}
🚀[ModelScope](https://modelscope.cn/notebook/share/ipynb/394bec82/spatiotemporal-forecasting.ipynb) 🚀[Colab](https://drive.google.com/file/d/1XSU_cRrz3Afg-fv1N-BJHx1Rk59pqnQ-/view?usp=drive_link) 🚀[Github](https://github.com/arkin-developer/notebooks/blob/main/spatiotemporal-forecasting/spatiotemporal-forecasting.ipynb)
{{< /lead >}}


## Jupyter Notebook 预览
<iframe 
  src="https://modelscope.cn/notebook/share/ipynb/394bec82/spatiotemporal-forecasting.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>

[*新标签页打开notebooks*](https://modelscope.cn/notebook/share/ipynb/394bec82/spatiotemporal-forecasting.ipynb)


## 项目概述

> 说明：本项目基于真实的NYC出租车GPS轨迹数据，利用空间PatchTST深度学习模型，实现对城市交通需求时空分布的预测。模型能够根据过去6小时（12个时间步）的交通流量数据，预测未来3小时（6个时间步）的流量分布情况。

**目标**：构建一个现代化的时空序列预测模型，用于城市交通调度优化和需求预测。模型采用Transformer架构，具有参数高效、训练快速的特点，能够处理32×32栅格规模的时空数据。
**硬件建议**：支持Apple Silicon MPS或CUDA的设备（推荐4GB+内存）；
**软件建议**：Python 3.8+、PyTorch 2.0+、支持MPS或CUDA。

------

## ✅ 本教程包括

1. 环境配置与硬件检测
2. 真实空间时序数据集下载
3. 数据集展示与分析
4. 空间PatchTST神经网络构建
5. 数据集处理与训练准备
6. 模型训练与监控
7. 模型评估与可视化
8. 项目总结与展望


## 🔬 技术特点

- **现代架构**：采用2023年SOTA的PatchTST Transformer架构
- **参数高效**：~93K参数，比传统ConvLSTM减少81%
- **时空建模**：同时处理空间（32×32栅格）和时间（6小时→3小时）维度
- **真实数据**：基于NYC出租车GPS轨迹的真实交通数据
- **双通道预测**：同时预测流入量和流出量
- **跨平台支持**：支持Apple Silicon MPS、CUDA和CPU
- **业务导向**：面向实际交通调度和运营优化场景

## 📊 模型架构

- **输入**：`(batch_size, 12, 2, 32, 32)` - 过去6小时的双通道空间数据
- **输出**：`(batch_size, 6, 2, 32, 32)` - 未来3小时的预测
- **核心组件**：时间Patch嵌入 + 空间位置编码 + Transformer编码器
- **预测头**：多层感知机 + 输出投影层
- **特征维度**：d_model=64, n_heads=4, n_layers=2（轻量级配置）

## 🎓 你将学会

### **1. 时空数据处理技术**
- **🗺️ 空间网格化**：将GPS轨迹数据转换为规则网格格式
- **⏰ 时间序列构建**：按时间间隔聚合空间数据，构建时空序列
- **📊 数据预处理**：标准化、归一化、数据清洗技术
- **🔄 数据增强**：时空数据的增强和扩充方法

### **2. PatchTST神经网络架构（2023 SOTA）**
- **🧩 Patch化技术**：将时间序列分割为patches进行并行处理
- **🎯 通道独立建模**：每个空间位置独立处理，避免信息干扰
- **🔗 Transformer编码器**：自注意力机制在时序预测中的应用
- **📍 位置编码**：时间和空间位置信息的编码方法
- **⚡ 轻量级设计**：如何设计高效的时空预测模型

### **3. 深度学习工程实践**
- **🍎 Apple Silicon优化**：MPS加速在深度学习中的应用
- **📱 设备管理**：智能选择CPU/GPU/MPS计算设备
- **🔄 训练流程**：完整的模型训练、验证、测试流程
- **📈 性能监控**：损失函数、早停机制、学习率调度
- **💾 模型保存**：最佳模型保存和加载策略

### **4. 时空预测业务应用**
- **🚕 交通流量预测**：城市交通需求的时空分布预测
- **📊 业务指标设计**：如何设计符合业务需求的预测指标
- **🎯 模型评估**：MSE、MAE等评估指标的实际意义
- **💼 商业价值**：预测模型在调度优化、动态定价中的应用
- **🔮 未来扩展**：如何将模型扩展到其他时空预测场景

### **5. 可视化与分析技术**
- **📊 时空数据可视化**：热力图、时序图、误差分析图
- **🔍 模型解释性**：理解模型预测结果和决策过程
- **📈 训练过程监控**：训练曲线、验证曲线分析
- **🎨 结果展示**：如何清晰展示预测结果和业务价值


## 🙏 支持作者

如果您觉得这个项目对您有帮助，可以请博主喝杯瑞幸 ☕️

<div style="text-align: center; margin: 2rem 0;">
  <!-- <img src="/img/reward.jpg" alt="打赏二维码" style="width: 100%; max-width: 400px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
  <p style="margin-top: 1rem; color: #666; font-size: 0.9rem;">扫码支持作者</p> -->

  <!-- 移动端友好的支付链接 -->
  <div style="display: flex; justify-content: center; gap: 2rem; margin-top: 1.5rem; flex-wrap: wrap;">
    <a href="https://arkin-developer.github.io/blog/img/zhifubao-reward.jpg" target="_blank" rel="noopener" style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #1677ff; color: white; text-decoration: none; border-radius: 8px; font-size: 0.9rem; transition: all 0.3s ease; box-shadow: 0 2px 4px rgba(22,119,255,0.3);">
      <span style="font-size: 1.2rem;">🩵</span>
      <span>支付宝打赏¥9.9</span>
    </a>
    <a href="https://arkin-developer.github.io/blog/img/wechat-reward.png" target="_blank" rel="noopener" style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #07c160; color: white; text-decoration: none; border-radius: 8px; font-size: 0.9rem; transition: all 0.3s ease; box-shadow: 0 2px 4px rgba(7,193,96,0.3);">
      <span style="font-size: 1.2rem;">💚</span>
      <span>微信打赏¥9.9</span>
    </a>
  </div>

  <p style="margin-top: 1rem; color: #999; font-size: 0.8rem;">点击按钮可查看二维码，方便手机扫码</p>
</div>

---

*你可以从导航栏跳转到对应的 Jupyter Notebook 的云服务平台进行尝试，抑或是下载 Notebook文件到本地运行。*
