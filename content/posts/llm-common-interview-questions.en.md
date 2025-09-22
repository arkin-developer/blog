---
title: "LLM Interview Questions - Fundamentals（1）"
description: "LLM Interview Questions - Fundamentals（1）"
keywords: ["LLM", "Interview"]
author: "Arkin"
date: 2025-08-04T17:45:10+08:00
lastmod: 2025-09-19T17:45:10+08:00
draft: false
tags: ["", "What is a Large Language Model?"]
categories: ["Interview Questions", "Large Language Models"]
aliases: []
image: "img/featured-image.jpg"
toc: true
readingTime: true
showWordCount: true
showDateUpdated: true
---

> A weak foundation leads to instability. Many people are busy developing large language models, but lack a comprehensive understanding of the most core concepts. Fundamental questions represent industry-validated consensus and are the essential underlying logic that must be mastered. Only by thoroughly understanding these can you remain invincible in complex applications.

## Q&A

- ### 1. Briefly introduce Large Language Models (LLMs)?

  Large Models: Generally refer to models with **100 million** or more parameters, but this standard has been continuously evolving. Currently, models with trillions of parameters (e.g., MinMax abab6.5) have also emerged. Large Language Models (LLMs) are large models specifically for language.

  Key characteristics of Large Language Models include:

  - **Large-scale parameters**: LLMs possess a vast number of parameters (such as GPT-3's 175B or PaLM's 540B). The more parameters, the stronger the model's ability to capture language patterns, enabling better understanding of context and generating fluent language.
  - **Multi-task processing capability**: After training, LLMs demonstrate good performance across various language tasks, such as text summarization, sentiment analysis, machine translation, etc. This is because they have learned to generalize various language patterns and rules from large datasets.
  - **Context understanding**: LLMs can generate logical and coherent responses based on context, making them particularly suitable for dialogue and content creation tasks. Models can "remember" important details from a conversation and maintain consistency in subsequent interactions.
  - **Self-supervised learning**: Large language models primarily rely on self-supervised learning, using unlabeled data for training, learning language structure through predicting the next word, filling in blanks, or matching sentences.
  - **Generalization and scalability**: LLMs can be transferred to various tasks and domains, and with minimal fine-tuning, they can be effective in specialized tasks (such as medical text analysis or legal document summarization).

  Despite their excellent performance in many tasks, large language models also have some limitations, such as generating incorrect information, bias issues, and requiring high computational resources.

  *Reference: Comprehensive evaluation of large models of different sizes in Chinese, currently covering 115 large models, including commercial models like ChatGPT, GPT-4o, Baidu ERNIE Bot, Alibaba Tongyi Qianwen, iFLYTEK Spark, SenseChat, Minimax, as well as open-source models like Baichuan, Qwen2, GLM4, Yi, InternLM2, LLaMA3, with multi-dimensional capability assessment.*

  *Reference link: https://github.com/jeinlee1991/chinese-llm-benchmark*

  ![Chinese Language Large Model Comprehensive Capability Benchmark Ranking 0921](https://github.com/jeinlee1991/chinese-llm-benchmark/blob/main/pic/%E6%80%BB%E5%88%86.png?raw=true)

- ### 2. What do the numbers like 175B, 60B, 540B following Large Language Models (LLMs) refer to?

  The numbers following large language model names like "175B", "60B", or "540B" refer to the model's parameter count (Parameters), where "B" typically represents "billion". These parameter counts directly affect the model's complexity and computational capability:

  - **175B**: Refers to 175 billion parameters, such as OpenAI's GPT-3.
  - **60B**: Refers to 60 billion parameters, such as one version of Meta's LLM models.
  - **540B**: Refers to 540 billion parameters, such as Google's Pathways Language Model (PaLM) larger version.

  The more parameters, the richer the language patterns and semantic information the model can learn and capture, but the computational resource requirements also increase accordingly. Larger parameter scales typically improve model performance, especially when handling complex tasks or generating high-quality text. However, increasing parameters doesn't always directly equate to better results; model optimization, data quality, and training methods are equally important.

- ### 3. What are the advantages and disadvantages of Large Language Models (LLMs)?

  - **Advantages**:
    - **Strong language understanding and generation capability**: Large language models can be trained on massive text data, demonstrating excellent performance in natural language understanding and generation. For example, they can generate coherent articles, answer questions, and even simulate conversations, making them very suitable for casual dialogue, writing assistance, and other scenarios.
    - **Wide cross-domain knowledge**: Large language models can provide knowledge support across multiple domains such as medicine, law, and engineering. This benefits from their training on massive datasets, accumulating certain cross-domain knowledge, allowing users to consult various professional or non-professional questions.
    - **Multi-language support**: Many large language models have multi-language capabilities, able to process and understand multiple languages, which is particularly practical in multinational companies or multi-language customer service. For example, GPT-3 and GPT-4 support understanding and generation in multiple languages including English, Chinese, French, etc.
    - **Rapid deployment and adaptability**: Since large language models can be fine-tuned based on pre-trained models to adapt to different task requirements. For example, specific domain data can be fine-tuned on the model foundation to make it suitable for specific domains, such as legal assistants, medical consultation, etc.
  - **Disadvantages**:
    - **Lack of factual accuracy**: Large language models may generate seemingly reasonable but inaccurate information when answering questions. This is because models are essentially based on pattern matching and probability distribution for generation, not truly understanding facts, so they are also prone to lag in knowledge updates.
    - **High computational resource consumption**: Large language models typically require massive computational resources for training and operation. For example, GPT-3 model training consumed enormous amounts of electricity and hardware resources, and the cost in practical applications is also very high, especially in real-time response scenarios where model inference speed is also limited by hardware.
    - **Potential bias generation**: Large language models are trained on massive internet data and may reflect biases in the data, such as issues related to gender, race, and region. These biases manifest in model outputs and may affect the model's fairness and applicability.
    - **Privacy and security issues**: During training, models may come into contact with some sensitive or personal information. If this information is inadvertently exposed during model content generation, it may bring privacy leakage risks, especially in application scenarios handling sensitive data.

- ### 4. What are the common classifications of Large Language Models (LLMs)?

  Large models can be classified in many ways, as long as the content is self-consistent.

  - **Classification by input content**:
    - **Language Large Models (NLP)**:
      - Refers to a class of large models in the Natural Language Processing (NLP) field, typically used for processing text data and understanding natural language. The main characteristic of these large models is that they are trained on large-scale corpora to learn various grammatical, semantic, and contextual rules of natural language.
      - Examples: GPT series (OpenAI), Bard (Google), ERNIE Bot (Baidu), Qwen (Alibaba).
    - **Vision Large Models (CV)**:
      - Refers to large models used in the Computer Vision (CV) field, typically for image processing and analysis. These models achieve various visual tasks through training on large-scale image data, such as image classification, object detection, image segmentation, pose estimation, face recognition, etc.
      - Examples: VIT series (Google), ERNIE UFO, Huawei Pangu CV, INTERN (SenseTime-InternLM).
    - **Multimodal Large Models**:
      - Refers to large models capable of processing multiple different types of data, such as text, images, audio, and other multimodal data. These models combine NLP and CV capabilities to achieve comprehensive understanding and analysis of multimodal information, enabling more comprehensive understanding and processing of complex data.
      - Examples: DALL-E (OpenAI), Midjourney.
  - **Classification by pre-training tasks**:
    - **Autoregressive Language Model**:
      - Such as GPT series models, only predict the next word through preceding text, suitable for generation tasks.
      - **Example**:
        - **Input**: `"The cat sat on the"`
        - **Output (target)**: `"mat"`
    - **Autoencoding Language Model**:
      - Such as BERT, predict masked words through masked language modeling, suitable for understanding and classification tasks.
      - **Example**:
        - **Input (with mask)**: `"The cat [MASK] on the mat."`
        - **Output (target)**: `"sat"`
    - **Sequence-to-Sequence Language Model**:
      - Such as T5, BART, etc., can both generate text and complete understanding tasks, widely used in machine translation and text generation scenarios.
      - **Example**:
        - **Input (corrupted sentence)**: `"The [MASK] sat [MASK] the mat."`
        - **Output (target, complete sentence)**: `"The cat sat on the mat."`
  - **Classification by model scale**:
    - **Small-scale models**:
      - Such as BERT Base, GPT-2 Small, etc., with parameters typically in the tens of millions to hundreds of millions range, suitable for resource-limited devices or edge computing.
    - **Medium-scale models**:
      - Such as BERT Large, GPT-2 Medium, with parameters typically in the hundreds of millions to billions range, balancing performance and computational overhead.
    - **Large-scale models**:
      - Such as GPT-3, PaLM, LLaMA, etc., with parameters reaching hundreds of billions to trillions, excellent performance but extremely high resource requirements, suitable for tasks requiring complex reasoning.

- ### 5. What are the current mainstream open-source LLM model architectures? (What are the differences between Prefix Decoder, Causal Decoder, and Encoder-Decoder?)

  In the **pre-trained language model** era, the natural language processing field widely adopted the **pre-training + fine-tuning** paradigm, giving birth to large-scale pre-trained language models represented by BERT's encoder-only architecture, **GPT's decoder-only architecture, and T5's encoder-decoder architecture**.
  
  With the **successful development of the GPT series models**, the current natural language processing field has moved toward generative large language models, with decoder architecture becoming the mainstream architecture for current large language models. Further, decoder architecture can be subdivided into two variant architectures, including **Causal Decoder** architecture and **Prefix Decoder** architecture. It's worth noting that when academia refers to decoder architecture, it usually refers to causal decoder architecture.
  
  The following diagram compares the three architectures (Causal Decoder, Prefix Decoder, and Encoder-Decoder):
  
  ![image-20250922122538906](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250922122538906.png)
  
  ##### **Encoder-Decoder**
  
  - Encoder-Decoder architecture is a classic model structure in the natural language processing field, widely used in various tasks such as machine translation. The original Transformer model also used this architecture, combining two Transformer modules serving as encoder and decoder respectively.
  - As shown in the figure below, this architecture uses bidirectional self-attention mechanism on the encoder side to encode input information, while on the decoder side it uses cross-attention and masked self-attention mechanisms, then generates output through autoregressive methods.
  - Pre-trained language models based on encoder-decoder design have shown excellent performance in numerous natural language understanding and generation tasks, but currently only a few large language models like FLAN-T5 are built on encoder-decoder architecture.
  
  ![image-20250922123112350](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250922123112350.png)
  
  **Causal Decoder**
  
  - Causal LM is a causal language model. Most popular models currently use this structure, for no other reason than that the GPT series models' internal structure is this, and open-source models like LLaMA also use it. **The classic representative of Causal Decoder architecture is the GPT series models, using unidirectional attention masking to ensure each input token can only attend to past tokens and itself, with input and output tokens processed through the Decoder in the same way.**
  - In the figure below, gray represents that the corresponding two tokens cannot see each other, otherwise they can see each other. For example, "Survey" can see the preceding "A" but cannot see the following "of". Causal Decoder's sequence mask matrix is a classic lower triangular matrix.
  - In causal decoder architecture, the most representative model is OpenAI's GPT series. With the success of GPT-3, causal decoders have been widely adopted in various large language models, including BLOOM, LLaMA (Meta), etc.
  
  ![image-20250922124434537](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250922124434537.png)
  
  ##### **Prefix Decoder**
  
  - Prefix Decoder architecture is also known as non-causal decoder architecture, modifying the masking mechanism of causal decoders. This architecture, like causal decoders, only uses decoder components.
  - The difference is that this architecture references encoder-decoder design, providing specific processing for input and output parts. As shown in the figure below, prefix decoders use bidirectional attention for encoding the input (prefix) part, while for the output part they use unidirectional masked attention to autoregressively predict using the token itself and preceding tokens.
  - Unlike encoder-decoder, prefix decoders share parameters during encoding and decoding processes, without dividing into independent decoders and encoders.
  - Currently, representative large language models based on prefix decoder architecture include GLM-130B and U-PaLM (Google).
  
  ![image-20250922125902376](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250922125902376.png)
  
  ##### **Summary**
  
  The differences between Prefix Decoder, Causal Decoder, and Encoder-Decoder lie in different attention masks.
  
  - Encoder-Decoder (Representative: T5):
    - Uses bidirectional attention mechanism on input, providing more comprehensive encoding and understanding of questions.
    - Usage: Better performance on understanding-oriented NLP tasks.
    - Poor performance on long text generation tasks, low training efficiency.
  - Causal Decoder (Representative: GPT series):
    - Autoregressive language model, where pre-training and downstream applications are completely consistent, strictly following the rule that only subsequent tokens can see preceding tokens.
    - Applicable tasks: Good performance on text generation tasks.
    - High training efficiency, stronger zero-shot capability, with emergent abilities.
  - Prefix Decoder (Representative: GLM):
    - Feature: Tokens in the prefix part can see each other.
    - Usage: Good performance on text generation tasks.



## Related Links

- [Original Bilibili Video](https://www.bilibili.com/video/BV1E4bczRES9?spm_id_from=333.788.videopod.episodes&vd_source=baf08b4f56da32601c712e9657f34742&p=2)

---

*Last updated: 2025-09-19T17:45:10+08:00*
