---
title: "🔧 Qwen2.5 Model Fine-tuning Case"
description: "On a single A10 (24GB) card, using a *small parameter* model as an example (this case uses ModelScope to replace HuggingFace), use **LoRA/QLoRA** to run through a complete *instruction fine-tuning* (Instruction Tuning) process."
date: 2025-08-20
lastmod: 2025-09-19T17:45:10+08:00
tags: ["LLM", "Fine-tuning", "ModelScope", "LoRA", "QLoRA", "Artificial Intelligence"]
categories: ["Artificial Intelligence"]
github: "https://github.com/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb"
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb"
modelscope: "https://modelscope.cn/notebook/share/ipynb/f98b76de/qwen2.5-fine-tuning.ipynb"
colab: "https://drive.google.com/file/d/13lMw_lEE5uTNId8AuvvCtT7tmzAbeLWO/view?usp=drive_link"
---

> Note: First use a compatible small model (e.g., `Qwen/Qwen2.5-1.5B-Instruct`) to run through the process, then replace the `MODEL_ID` with the DeepSeek model repository name you find, no code changes needed.

## Jupyter Notebook Preview
<iframe 
  src="https://nbviewer.org/github/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>

{{< lead >}}
🚀[ModelScope](https://modelscope.cn/notebook/share/ipynb/cfc09818/qwen2.5-fine-tuning.ipynb) 🚀[Colab](https://drive.google.com/file/d/13lMw_lEE5uTNId8AuvvCtT7tmzAbeLWO/view?usp=drive_link) 🚀[Github](https://github.com/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb)
{{< /lead >}}


[*Open notebooks in new tab*](https://nbviewer.org/github/arkin-developer/notebooks/blob/main/qwen2.5-fine-tuning/qwen2.5-fine-tuning.ipynb)

## Project Overview

**Objective**: On a single A10 (24GB) card, using a *small parameter* model as an example (this case uses ModelScope to replace HuggingFace), use **LoRA/QLoRA** to run through a complete *instruction fine-tuning* (Instruction Tuning) process.
**Hardware Recommendation**: A10 24GB;
**Software Recommendation**: Python 3.10+, CUDA 12.x, PyTorch 2.3+.

### ✅ This Tutorial Includes

1. LoRA/QLoRA Introduction
2. Hardware Detection and Environment Configuration
3. Model and Dataset Download
4. Data Preprocessing
5. LoRA Fine-tuning
6. Model Testing and Evaluation

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