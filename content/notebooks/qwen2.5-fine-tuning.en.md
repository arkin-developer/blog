---
title: "Qwen2.5 Model Fine-tuning Case"
description: "On a single A10 (24GB) card, using a *small parameter* model as an example (this case uses ModelScope to replace HuggingFace), use **LoRA/QLoRA** to run through a complete *instruction fine-tuning* (Instruction Tuning) process."
date: 2025-08-20
tags: ["LLM Model Fine-tuning", "ModelScope", "Notebook", "LoRA/QLoRA"]
categories: ["notebooks"]
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb"
---

{{< lead >}}
🚀[Alibaba Cloud](https://gallery.pai-ml.com/#/import/https://dsw-share.oss-cn-beijing.aliyuncs.com/1189516462147384/dsw-p7b6usueey5pxo2vcy_2025-08-26T18%3A08%3A34.770973Z/qwen2.5-fine-tuning.ipynb?Expires=1756318158&OSSAccessKeyId=LTAI5tDqiodkPVXWZzJ1h92J&Signature=lmoHZHPN0lLsGSom0pBgnZcfmCU%3D) 🚀[Colab](https://colab.research.google.com/drive/1ncpNySba_USsDaKDmeJfG_WLBHBxIx9R?usp=sharing)
{{< /lead >}}


## Jupyter Notebook Preview
<iframe 
  src="https://nbviewer.org/github/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>



## Project Overview

> Note: First use a compatible small model (e.g., `Qwen/Qwen2.5-1.5B-Instruct`) to run through the process, then replace the `MODEL_ID` with the DeepSeek model repository name you find, no code changes needed.

**Objective**: On a single A10 (24GB) card, using a *small parameter* model as an example (this case uses ModelScope to replace HuggingFace), use **LoRA/QLoRA** to run through a complete *instruction fine-tuning* (Instruction Tuning) process.
**Hardware Recommendation**: A10 24GB;
**Software Recommendation**: Python 3.10+, CUDA 12.x, PyTorch 2.3+.

------

### ✅ This Tutorial Includes

1. LoRA/QLoRA Introduction
2. Hardware Detection and Environment Configuration
3. Model and Dataset Download
4. Data Preprocessing
5. LoRA Fine-tuning
6. Model Testing and Evaluation

## 🙏 Support the Author

If you find this project helpful, you can buy the author a cup of Luckin Coffee ☕️

<div style="text-align: center; margin: 2rem 0;">
  <!-- <img src="/img/reward.jpg" alt="Reward QR Code" style="width: 100%; max-width: 400px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
  <p style="margin-top: 1rem; color: #666; font-size: 0.9rem;">Scan to support the author</p> -->
  
  <!-- Mobile-friendly payment links -->
  <div style="display: flex; justify-content: center; gap: 2rem; margin-top: 1.5rem; flex-wrap: wrap;">
    <a href="https://arkin-developer.github.io/blog/img/zhifubao-reward.jpg" target="_blank" rel="noopener" style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #1677ff; color: white; text-decoration: none; border-radius: 8px; font-size: 0.9rem; transition: all 0.3s ease; box-shadow: 0 2px 4px rgba(22,119,255,0.3);">
      <span style="font-size: 1.2rem;">🩵</span>
      <span>Alipay Reward ¥9.9</span>
    </a>
    <a href="https://arkin-developer.github.io/blog/img/wechat-reward.png" target="_blank" rel="noopener" style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #07c160; color: white; text-decoration: none; border-radius: 8px; font-size: 0.9rem; transition: all 0.3s ease; box-shadow: 0 2px 4px rgba(7,193,96,0.3);">
      <span style="font-size: 1.2rem;">💚</span>
      <span>WeChat Reward ¥9.9</span>
    </a>
  </div>
  
  <p style="margin-top: 1rem; color: #999; font-size: 0.8rem;">Click buttons to view QR codes</p>
</div>

---

*You can navigate to the corresponding Jupyter Notebook cloud platform from the navigation bar to try it out, or download the Notebook file to run locally.*
