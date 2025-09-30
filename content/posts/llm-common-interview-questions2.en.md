---
title: "📝 LLM Interview Questions - Fundamentals (2)"
description: "LLM Interview Questions - Fundamentals (2)"
keywords: ["LLM", "Interview"]
author: "Arkin"
date: 2025-08-07T17:45:10+08:00
lastmod: 2025-09-24T01:30:00+08:00
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

    ![image-20250924182710505](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250924182710505.png)
  - In daily life, there are also emergent phenomena, such as snowflake formation, traffic jams, animal migration, vortex formation, etc.
  - Taking snowflakes as an example: snowflakes are composed of water molecules. Water molecules are very small, but when a large number of water molecules interact under changing external temperature conditions, they form very regular, symmetrical, and beautiful snowflakes at the macroscopic level.

  #### Hypothesis 1: Task evaluation metrics are not smooth enough

  - One hypothesis is that the emergence phenomenon we observe now is due to insufficient smoothness in many task evaluation metrics.

    ![image-20250924182733308](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250924182733308.png)

  - Regarding this point, we use the Emoji_movie task as an example. The Emoji_movie task inputs emoji images and requires the LLM to provide completely correct movie names, with only perfect matches considered correct.

  - As shown in the figure above, the input emoji is a girl's smiling face, followed by three fish images. You can guess what movie this is. The 2m on the left represents a model with 2 million parameters and the corresponding model's response. It can be seen that only when the model size increases to 128B can the LLM completely guess the movie name correctly, but when the model reaches 125m and 4B, the model is actually slowly approaching the correct answer.

    ![image-20250924182832292](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250924182832292.png)

  - If the evaluation metric requires strict accuracy (perfect match), then we see the emergence phenomenon in the Emoji_movie task, as shown in the left figure above. However, if we change the problem format to multiple choice, giving several candidate answers for the LLM to choose from, then as the model size increases, the task performance improves steadily, but the emergence phenomenon disappears, as shown in the right figure above. This indicates that insufficient smoothness in evaluation metrics is at least one reason why some tasks show emergence phenomena.

  #### Hypothesis 2: Complex tasks vs. subtasks

  - Tasks that show emergence have a commonality: they are often complex tasks composed of multiple subtasks.

  - That is, the final task is too complex. If analyzed carefully, it can be seen that it is composed of multiple subtasks. At this time, subtask performance often follows the Scaling Law as the model size increases, while the final task shows emergence phenomena.

  - This is actually easy to understand. For example, suppose a certain task T is composed of 5 subtasks Sub-T. Each Sub-T improves from 40% to 60% as the model size increases, but the final task metric only improves from 1.1% to 7%, meaning that emergence is observed macroscopically, but subtask performance actually grows smoothly.

    ![image-20250924183256952](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250924183256952.png)

  Taking the international chess task as an example, as shown in the figure above, let the language model predict the next move. The final evaluation metric is only winning by "checkmate". If evaluated by "checkmate" (red line), it is found that as the model size increases, the model slowly rises, conforming to emergence behavior. If we evaluate the LLM's legal moves (green line), and making correct choices among legal moves is a subtask before finally achieving "checkmate", this is actually a simpler subtask than checkmate. We see that legal moves improve continuously with model scale. At this time, we cannot see emergence phenomena.

  #### Summary

  - Regarding hypotheses about emergent abilities, the current mainstream hypotheses are:
    - Task evaluation metrics are not smooth enough
    - Complex tasks vs. subtasks

    *Content reference source: Teacher Zhang Junlin's "Emergent Abilities of Large Language Models: Phenomena and Explanations"*

- ### 3. What is Scaling Law? Share your understanding of it

  - #### 3.1 Goals of Scaling Law

    - Having a sense of the capabilities of a model before training can improve decisions around alignment, safety, and deployment. —— GPT-4 Technical Report
    - Understanding model capabilities before training can improve decisions about alignment, safety, and deployment of large models. —— GPT-4 Technical Report

    ![image-20250924210440416](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250924210440416.png)

    Image from OpenAI GPT-4 Technical Report https://cdn.openai.com/papers/gpt-4.pdf

    Figure 1. Performance of GPT-4 and smaller models. (Before training, the performance boundaries of GPT-4 were roughly predicted)

    The measurement standard is the final loss on OpenAI's internal codebase-derived dataset. This dataset includes a large number of representative tokens and was not included in the training set. We chose to observe loss because loss is usually more stable than other metrics under different training computational conditions.

    The dashed line represents a power law fit for smaller models (excluding GPT-4); this fit can accurately predict GPT-4's final loss. The horizontal axis is training computation, normalized so that GPT-4 corresponds to a value of 1.

  - #### 3.2 Definition of Scaling Law

    - **Using computational resources, dataset scale, and model scale** to predict the final capabilities of a model. (Usually in the form of relatively simple functions, e.g., linear relationships)

    In large models, we expect the model to understand the general patterns of human language, thereby making expressions similar to humans. By using large amounts of data for training, the model can learn the general patterns behind the data.

    When training pre-trained models, there are usually two options to improve large language model performance: increasing dataset size and increasing the number of parameters in the model. Based on this, there is also a constraint in the training process, which is training cost, such as the number of GPUs and time available for training.

    Therefore, pre-training of large language models is usually accompanied by a three-way trade-off game between training computation, dataset scale, and model scale.

    ![image-20250924212850132](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250924212850132.png)

    But specifically, how does the game between them unfold?

    Can Scaling Laws predict how loss values change when these three factors of training computation, dataset scale, and model scale change?

    This prediction can help with some key design decisions, such as matching the optimal model size and data size under a fixed resource budget without expensive trial and error.

  - #### 3.3 OpenAI vs. DeepMind Views on Scaling Law

    - ##### Company Background

      - DeepMind

        DeepMind, founded in 2010 and acquired by Google in 2015, is a subsidiary of Alphabet Inc. The company focuses on developing AI systems that can mimic human learning and problem-solving abilities. As part of Alphabet Inc., DeepMind maintains high independence while leveraging Google's powerful capabilities to advance AI research.

        DeepMind has achieved significant technical achievements, including developing AlphaGo, an AI system that defeated world Go champion Lee Sedol, demonstrating the potential of deep reinforcement learning and neural networks, and opening an AI era.

      - OpenAI

        After Google acquired DeepMind, to avoid Google's monopoly in the AI field, Elon Musk and other tech industry figures decided to create OpenAI in 2015. As a prestigious non-profit organization, it is committed to developing AI technologies that can promote social progress.

        Unlike DeepMind, which is like a master skilled at solving complex tactical board games, focusing on solving problems with clear rules and goals, OpenAI is more like a poet skilled in language arts, dedicated to making machines understand and generate natural human language.

        From adhering to the initially misunderstood GPT approach faith to the emergence of GPT-3 with 175 billion parameters, OpenAI has demonstrated its unparalleled capabilities in generative models, leading an AI era.

    - ##### OpenAI's Views on Scaling Law

      - In 2020, a team from OpenAI led by Kaplan et al. first proposed modeling the relationship between model performance (Loss) and model size, dataset size, and training computation in the paper "Scaling Laws for Neural Language Models". The team found that when any of the three factors is constrained, there is a power law relationship between Loss and that factor.

        *[Note: Power law refers to one variable being proportional to some power of another variable. When both axes are logarithmic, the graph appears as a straight line]*

        ![image-20250924215647917](https://mr-lai.oss-cn-zhangjiakou.aliyuncs.com/macminim4image-20250924215647917.png)

        *Image from OpenAI published article: Scaling Laws for Neural Language Models*

        *Figure 1 As the computation used for training, dataset scale, and model scale increase, language modeling performance improves steadily. To achieve optimal performance, these three factors must be scaled simultaneously. When not constrained by the other two factors, there is a power law relationship between performance and each factor.*

        The team's research conclusions are summarized as follows:

        1. Among the three factors affecting model performance, **each parameter is influenced by the other two parameters. When there are no bottlenecks from the other two, performance rises sharply, with the impact degree being computation > parameters > dataset size**.
        2. When training under a fixed computational budget, optimal performance can be achieved by training very large models and stopping before convergence (Early Stopping).
        3. Larger models perform better in sample efficiency, achieving the same performance level with fewer optimization steps and less data usage. In practical applications, priority should be given to training larger models.

    - ##### DeepMind's Views on Scaling Law

      - In 2022, a team from DeepMind led by Hoffmann et al. proposed a view completely different from OpenAI in "Training Compute-Optimal Large Language Models".

        OpenAI suggested that when computational budget increases by 10x, if you want to maintain effectiveness, the model size should increase by 5x, while the number of training tokens only needs to increase by 1.8x.

        The DeepMind team believes that both model size and the number of training tokens should be scaled proportionally. The team also suggested that many large language models like GPT-3 with hundreds of billions of parameters are actually over-parameterized, meaning their parameter count exceeds what's needed for good language understanding, and they are under-trained.

        The team's research conclusions are summarized as follows:

        1. For a given FLOP budget, there is a clear valley value for the loss function:
           a. When the model is too small, a larger model on less data will be an improvement;
           b. When the model is too large, a smaller model trained on more data will be an improvement.
           **That is, under a given computational budget, there is an optimal solution for the balance between data volume and model parameter count.**

        2. Under optimal computational cost, model size and training data (tokens) should be scaled proportionally, i.e.: **If the model size doubles, the amount of training data should also double. For a model with a given number of parameters, the optimal training dataset size is approximately 20 times the number of parameters in the model. For example, for a 7B model, the ideal training dataset size should be approximately 140B tokens**.

        3. Large model training needs to pay more attention to dataset expansion, but **the benefits of larger datasets can only be realized when the data is high quality**.

    - ##### Summary

      - Scaling Law Definition:
        - Using computational resources, dataset scale, and model scale to predict the final capabilities of a model.

      - OpenAI's Main Views on Scaling Law:
        - Among the three factors, each parameter is influenced by the other two parameters. When there are no bottlenecks from the other two, performance rises sharply, with the impact degree being **computation > parameters > dataset size**.

      - DeepMind's Main Views on Scaling Law:
        - Among the three factors, they should be scaled proportionally.


## Summary

Write the summary section of the article here.

## Related Links

- [Original Video](https://www.bilibili.com/video/BV1E4bczRES9?spm_id_from=333.788.videopod.episodes&vd_source=baf08b4f56da32601c712e9657f34742&p=3)

---

*Thanks for reading — feedback is welcome.*

*Email📮 arkin-dev@qq.com (feel free to reach out by email).* 
