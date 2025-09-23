---
title: "LLM Interview Questions - Fundamentals (2)"
description: "LLM Interview Questions - Fundamentals (2)"
keywords: ["LLM", "Interview"]
author: "Arkin"
date: 2025-08-07T17:45:10+08:00
lastmod: 2025-09-24T01:17:00+08:00
draft: false
tags: ["LLM", "Interview", "Large Language Model", "Artificial Intelligence"]
categories: ["Artificial Intelligence"]
aliases: []
image: "img/featured-image.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> A weak foundation leads to instability. Many people are busy developing large language models, but lack a comprehensive understanding of the most core concepts. Fundamental questions represent industry-validated consensus and are the essential underlying logic that must be mastered. Only by thoroughly understanding these can you remain invincible in complex applications.

{{< katex >}}

## Q&A

- ### 1. What are the common pre-training tasks in LLMs? (What are the training objectives of LLMs?)

  When conducting large-scale pre-training of models, it is often necessary to design appropriate self-supervised pre-training tasks to enable the model to learn broad semantic knowledge and world knowledge from massive unlabeled data.

  Currently, commonly used pre-training tasks are mainly divided into three categories, including **Language Modeling (LM)**, **Denoising Autoencoding (DAE)**, and **Mixture-of-Denoisers (MoD)**.

  The following diagram shows the input and output examples for language modeling and denoising autoencoding respectively.

  ![image-20250923120242372](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250923120242372.png)

  - **Language Modeling (LM)**

    Language modeling is the pre-training task widely adopted by most large language models. The core of this task is "predicting the next token" and is often applied to train decoder-based large language models, such as GPT-3 and PaLM.

    Formally, given a token sequence \\(u = u_1, …, u_T\\), the objective of the language modeling task is defined as a token prediction task: based on the token sequence before the current position in the sequence \\(u_{<t}\\), the target token \\(u_t\\) is predicted in an autoregressive manner. During training, the model is typically optimized using the following likelihood function:
    $$
    L_{LM}(u) = \sum_{t=1}^{T} \log P(u_t \mid u_{<t})
    $$
    The specific meanings are as follows:

    - \\(u\\) represents a sentence containing \\(T\\) words or characters, specifically a sequence.
    - \\(L_{LM}(u)\\) represents the loss function of language modeling for this sentence.
    - \\(P(u_t \mid u_{<t})\\) represents the probability of the \\(t\\)-th token \\(u_t\\) appearing, given the previous \\(t-1\\) tokens.
    - \\(\\log P(u_t \mid u_{<t})\\) represents the logarithm of this conditional probability.
    - The summation of the entire formula represents the sum of logarithmic probabilities of all words in the sequence from \\(t=1\\) to \\(T\\).

    Furthermore, essentially, pre-training based on language modeling can also be viewed as a multi-task learning process. For example:

    - When predicting `good` in the sentence prefix "This movie has a rich plot, the actors perform very well, and it's very good", the model is actually learning semantics for sentiment analysis tasks.
    - When predicting `one candy` in the sentence prefix "Xiaoming has three candies, gave two to Xiaohong, so there's one candy left", it is learning semantics for mathematical arithmetic tasks.

    More similar examples can be listed, covering a wider range of tasks. Therefore, pre-training tasks based on large-scale text corpora can potentially learn relevant knowledge and abilities to solve numerous tasks.

    Training efficiency: **Prefix Decoder < Causal Decoder**

    - **Causal Decoder** structure calculates loss on all tokens, while **Prefix Decoder** only calculates loss on outputs.
  
  - **Denoising Autoencoding (DAE)**
  
    - In addition to traditional language modeling tasks, denoising autoencoding is another common pre-training task for language models, widely used in pre-trained language models such as BERT and T5.
    - In denoising autoencoding tasks, input text undergoes a series of random replacement or deletion operations to form corrupted text \\(\\tilde{u}\\). The model's goal is to recover the replaced or deleted token fragments \\(u\\) from this corrupted text. The training objective of denoising autoencoding can be expressed by the following mathematical formula:
  
    $$
    L_{DAE}(u) = \log P(u \mid \tilde{u})
    $$
  
    - **Compared to language modeling, denoising autoencoding tasks are more complex to implement**, requiring additional optimization strategies such as token replacement strategies, replacement fragment length, replacement token ratio, etc. The choice of these strategies directly affects the training effectiveness of the model. Although denoising autoencoding tasks have been widely applied in many pre-trained language models, compared to language modeling tasks, pure language models that completely use denoising autoencoding for pre-training are still relatively limited. Representative models include FLAN-T5.
  
  - **Mixture-of-Denoisers (MoD)**
  
    - Mixture-of-Denoisers unifies the modeling of pre-training tasks by dividing the objectives of language modeling and denoising autoencoding into different types of denoising tasks.
  
- ### 2. What is emergent ability in LLMs?

  - What is "emergent ability"?
  - When a complex system consists of many tiny individuals, these tiny individuals come together and interact. When there are enough of them, they exhibit special phenomena at the macroscopic level that cannot be explained by individual microscopic entities. This can be called "emergent phenomena."


## Summary

Write the summary section of the article here.

## Related Links

- [Related Article 1](/posts/related-post-1)
- [Related Article 2](/posts/related-post-2)

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
