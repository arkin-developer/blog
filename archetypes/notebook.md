---
title: "{{ replace .Name "-" " " | title }}"
description: "{{ .Name | title }} 项目描述"
date: {{ .Date }}
tags: ["标签1", "标签2"]
categories: ["notebooks"]
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/{{ .Name }}/{{ .Name }}.ipynb"
---

{{< lead >}}
[阿里云](your-aliyun-url) [Colab]({{ .Params.colab_url }})
{{< /lead >}}

## Jupyter Notebook预览
<iframe 
  src="https://nbviewer.org/github/arkin-developer/notebooks/blob/main/{{ .Name }}/{{ .Name }}.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>

## 项目概述

在这里描述您的项目概述、目标、技术栈等信息。

### 项目目标

- 目标1
- 目标2
- 目标3

### 技术栈

- 技术1
- 技术2
- 技术3

### 主要功能

- 功能1
- 功能2
- 功能3

---

*您可以从导航栏跳转到对应的 Jupyter Notebook 的云服务平台进行尝试，抑或是下载 Notebook文件到本地运行。*
