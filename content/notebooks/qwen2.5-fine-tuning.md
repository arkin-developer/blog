---
title: "Qwen2.5模型微调案例"
description: "在单卡 A10（24GB）上，以 *小参数量* 的模型为例（本案例采用ModelScope来替换HuggingFace），用 **LoRA/QLoRA** 跑通一次完整的 *指令微调*（Instruction Tuning）流程。"
date: 2025-08-20
tags: ["LLM模型微调", "ModelScope", "Notebook", "LoRA/QLoRA"]
categories: ["notebooks"]
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb"
aliyun: "https://gallery.pai-ml.com/#/import/https://dsw-share.oss-cn-beijing.aliyuncs.com/1189516462147384/dsw-p7b6usueey5pxo2vcy_2025-08-26T18%3A08%3A34.770973Z/qwen2.5-fine-tuning.ipynb?Expires=1756318158&OSSAccessKeyId=LTAI5tDqiodkPVXWZzJ1h92J&Signature=lmoHZHPN0lLsGSom0pBgnZcfmCU%3D"
colab: "https://colab.research.google.com/drive/1ncpNySba_USsDaKDmeJfG_WLBHBxIx9R?usp=sharing"
---

{{< lead >}}
🚀[阿里云](https://gallery.pai-ml.com/#/import/https://dsw-share.oss-cn-beijing.aliyuncs.com/1189516462147384/dsw-p7b6usueey5pxo2vcy_2025-08-26T18%3A08%3A34.770973Z/qwen2.5-fine-tuning.ipynb?Expires=1756318158&OSSAccessKeyId=LTAI5tDqiodkPVXWZzJ1h92J&Signature=lmoHZHPN0lLsGSom0pBgnZcfmCU%3D) 🚀[Colab](https://colab.research.google.com/drive/1ncpNySba_USsDaKDmeJfG_WLBHBxIx9R?usp=sharing)
{{< /lead >}}


## Jupyter Notebook 预览
<iframe 
  src="https://nbviewer.org/github/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>



## 项目概述

> 说明：先用一个兼容的小模型（例如 `Qwen/Qwen2.5-1.5B-Instruct`）跑通流程，后续将 `MODEL_ID` 替换为你找到的 DeepSeek 模型仓库名即可，代码无需改动。

**目标**：在单卡 A10（24GB）上，以 *小参数量* 的模型为例（本案例采用ModelScope来替换HuggingFace），用 **LoRA/QLoRA** 跑通一次完整的 *指令微调*（Instruction Tuning）流程。
**硬件建议**：A10 24GB；
**软件建议**：Python 3.10+、CUDA 12.x、PyTorch 2.3+。

### ✅ 本教程包括

1. LoRA/QLoRA 简介
2. 硬件检测与配置环境
3. 模型与数据集下载
4. 数据预处理
5. LoRA微调
6. 模型测试评估

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