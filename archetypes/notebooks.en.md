---
title: "{{ replace .Name "-" " " | title }}"
description: "{{ .Name | title }} project description"
date: {{ .Date }}
tags: ["tag1", "tag2"]
categories: ["notebooks"]
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/{{ .Name }}/{{ .Name }}.ipynb"
github: "your-github-url"
modelscope: "your-modelscope-url"
colab: "your-colab-url"
---

{{< lead >}}
🚀[ModelScope](your-modelscope-url) 🚀[Colab](your-colab-url) 🚀[Github](your-github-url)
{{< /lead >}}

## Jupyter Notebook Preview
<iframe 
  src="https://nbviewer.org/github/arkin-developer/notebooks/blob/main/{{ .Name }}/{{ .Name }}.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>

## Project Overview

Describe your project overview, objectives, tech stack and other information here.

### Project Objectives

- Objective 1
- Objective 2
- Objective 3

### Tech Stack

- Technology 1
- Technology 2
- Technology 3

### Main Features

- Feature 1
- Feature 2
- Feature 3


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
