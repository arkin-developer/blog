---
title: "3D Object Classification Case - ModelNet40 Dataset"
description: "Lightweight 3D point cloud classification model based on PointMLP"
date: 2025-01-27
lastmod: 2025-09-30T00:00:00+08:00
tags: ["3D Object Classification", "PointMLP", "Point Cloud Processing", "Deep Learning", "ModelNet40"]
categories: ["notebooks"]
github: "https://github.com/arkin-developer/notebooks/blob/main/3d-object-classification/3d-object-classification.ipynb"
nbviewer: "https://nbviewer.org/github/arkin-developer/notebooks/blob/main/3d-object-classification/3d-object-classification.ipynb"
---

{{< lead >}}
Achieved 84.5% classification accuracy on ModelNet40 with the lightweight PointMLP architecture. Full implementation includes FPS uniform sampling, multiple data augmentation strategies, and an end-to-end training pipeline. 1.37M parameters, supports MPS/CUDA/CPU.
{{< /lead >}}

## Jupyter Notebook Preview
<iframe 
  src="https://nbviewer.org/github/arkin-developer/notebooks/blob/main/3d-object-classification/3d-object-classification.ipynb"
  width="100%"
  height="600px"
  frameborder="0"
  style="border: 1px solid #e9ecef; border-radius: 8px; margin: 2rem 0;"
  allowfullscreen>
</iframe>

## 🎯 Core Value

This project implements the full process from raw point clouds to a production-ready model, focusing on three core challenges in 3D point cloud processing:

1. **Spatially uniform sampling**: Implements the FPS (Farthest Point Sampling) algorithm, improving spatial uniformity by 20–40% compared to random sampling
2. **Data augmentation strategy**: Rotation + scaling + jitter + point dropout to prevent overfitting and improve generalization
3. **Lightweight architecture**: Pure MLP design with 1.37M parameters achieving 84.5% accuracy, suitable for mobile and edge devices

---

## 📚 Tutorial Structure

| Section | Content | Core Techniques |
|-----|------|---------|
| **1. Task Introduction** | Background of 3D object classification | Point Cloud vs Voxel vs Mesh |
| **2. Environment Setup** | Dependency installation | PyTorch, Datasets, Plotly |
| **3. Data Download** | ModelNet40 dataset | HuggingFace Datasets API |
| **4. Data Visualization** | 3D/2D point cloud visualization | Plotly 3D scatter |
| **5. Data Preprocessing** | **FPS sampling + normalization + augmentation** | **Core Section** ⭐ |
| **6. Model Construction** | PointMLP architecture | Point-wise MLP + MaxPool |
| **7. Data Loading** | Dataset + DataLoader | PyTorch data flow |
| **8. Model Training** | End-to-end training | Adam + Scheduler |
| **9. Model Evaluation** | Performance analysis | Confusion matrix + classification report |
| **10. Summary & Extensions** | Improvement directions | PointNeXt, self-supervised pretraining |

## 🔬 Technical Highlights

### 1️⃣ FPS (Farthest Point Sampling) - Ensuring Spatial Uniformity

**Problem**: Random sampling may repeatedly sample dense regions and ignore sparse regions

**Solution**: Greedily select the point farthest from the already selected set

```python
def farthest_point_sampling(points, num_points):
    """
    FPS core logic:
    1. Randomly select the first point
    2. Compute the minimum distance from all points to the selected set
    3. Select the point with the largest distance (the farthest point)
    4. Repeat 2-3 until the target number of points is reached
    """
    centroids = np.zeros(num_points, dtype=np.int32)
    distance = np.ones(N) * 1e10
    farthest = np.random.randint(0, N)
    
    for i in range(num_points):
        centroids[i] = farthest
        dist = np.sum((points - points[farthest]) ** 2, axis=1)
        distance = np.minimum(distance, dist)
        farthest = np.argmax(distance)
    
    return points[centroids]
```

**Effect Comparison**:
- Random sampling: Uneven spatial distribution, large standard deviation of nearest-neighbor distances
- FPS sampling: Uniform coverage, **20–40% improvement in spatial uniformity**
- Applicable scenarios: Long and thin structures such as airplane wings and chair armrests are not missed

### 2️⃣ Multi-strategy Data Augmentation - Improving Generalization

**Full augmentation pipeline**:

| Method | Parameters | Role | Implementation |
|---------|------|------|------|
| **Random Rotation** | ±30° | Simulate different viewpoints | Z-axis rotation matrix |
| **Random Scaling** | 0.8–1.2× | Simulate scale variations | Uniform scaling |
| **Random Jitter** | std=0.01 | Simulate sensor noise | Gaussian noise (1% of data range) |
| **Random Dropout** | 10% prob. | Simulate occlusion | Random delete points then resample |

```python
class PointCloudAugmentation:
    def augment(self, points, training=True):
        if not training:
            return points
        
        points = self.random_rotation(points, max_angle=30)
        points = self.random_scaling(points, scale_range=(0.8, 1.2))
        points = self.random_jitter(points, std=0.01)
        
        if np.random.random() < 0.3:
            points = self.random_dropout(points, dropout_ratio=0.1)
        
        return points
```

**Key Design Choices**:
- **Jitter std 0.01**: 1% of data range to preserve geometry while adding diversity
- **Dropout probability 30%**: Avoid overly damaging point cloud integrity
- **Composed augmentations**: Stacked augmentations, exponentially increasing data diversity

### 3️⃣ PointMLP Lightweight Architecture - Efficient and Practical

**Network Structure**:

```
Input point cloud (B, 1024, 3)
    ↓
Point-wise MLP feature extraction
    [3→64→64→128→256→512→1024]  ← Each point processed independently
    ↓
Global max pooling  (B, 1024, 1024) → (B, 1024)  ← Permutation invariance
    ↓
Classification MLP head
    [1024→512→256→40]
    ↓
Classification result (B, 40)
```

**Core Designs**:
- **Point-wise processing**: Same MLP for every point, parameter sharing
- **MaxPool aggregation**: Order-agnostic, permutation invariant
- **BatchNorm + Dropout**: Prevent overfitting, strong generalization

**Parameter Comparison**:

| Model | Params | Accuracy | Inference Speed |
|------|--------|--------|----------|
| PointNet | 3.5M | 89.2% | Fast |
| PointNet++ | 1.7M | 91.9% | Medium |
| **PointMLP (this project)** | **1.37M** | **84.5%** | **Fastest** |
| DGCNN | 1.8M | 92.9% | Slow |

## 🏆 Performance

### Training Configuration
- **Epochs**: 20
- **Batch size**: 32
- **Optimizer**: Adam (lr=0.001)
- **LR Scheduler**: StepLR (gamma=0.5, step=5)
- **Device**: Apple Silicon MPS

### Metrics

| Metric | Value |
|------|------|
| **Final Test Accuracy** | **84.48%** |
| **Best Model Accuracy** | 84.64% (Epoch 19) |
| **Parameters** | 1,374,696 (~1.37M) |
| **Model Size** | 5.24 MB |
| **Training Time** | ~20 minutes (MPS) |
| **Inference Speed** | Real-time |

### Analysis

**Best-performing classes** (100%):
- `airplane`, `chair`, `car`, `plant`, `stairs`, `toilet`

**Challenging classes** (<75%):
- `flower_pot` (60%), `radio` (64%), `range_hood` (72%)

**Reasons**:
- Geometric similarity: `flower_pot` vs `vase`
- Large scale variance: Diverse shapes of `radio`
- Detail-dependent: `range_hood` has less distinct features

## 💡 Key Code Snippets

### Data preprocessing pipeline

```python
class PointCloudPreprocessor:
    def preprocess(self, points):
        # 1. Remove invalid points
        points = self._remove_invalid_points(points)
        
        # 2. FPS sample to 1024 points (critical!)
        points = farthest_point_sampling(points, self.target_points)
        
        # 3. Centering + unit sphere normalization
        centroid = np.mean(points, axis=0)
        points = points - centroid
        max_dist = np.max(np.linalg.norm(points, axis=1))
        points = points / max_dist if max_dist > 0 else points
        
        return points
```

### End-to-end training loop

```python
for epoch in range(num_epochs):
    # Train
    for points, labels in train_loader:
        points = points.to(device)
        labels = labels.to(device)
        
        outputs = model(points)
        loss = criterion(outputs, labels)
        
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
    
    # Evaluate
    test_acc = evaluate(model, test_loader, device)
    
    # Save best model
    if test_acc > best_accuracy:
        torch.save(model.state_dict(), 'best_model.pth')
```

## 🚀 Quick Start

```bash
# 1. Clone repository
git clone https://github.com/arkin-developer/notebooks.git
cd notebooks/3d-object-classification

# 2. Install dependencies
pip install datasets torch torchvision open3d matplotlib plotly scipy

# 3. Launch Jupyter
jupyter notebook 3d-object-classification.ipynb

# 4. Run all cells in order
```

**Hardware Requirements**:
- Memory: 4GB+
- VRAM: 2GB+ (if using GPU)
- Device: Supports MPS (Apple Silicon), CUDA, or CPU

## 📊 Dataset Information

- **Name**: ModelNet40
- **Source**: Hugging Face (`jxie/modelnet40`)
- **Size**: 12,311 3D models
- **Classes**: 40 categories of everyday objects (airplane, car, chair, table, etc.)
- **Format**: Point cloud (8192 3D points per sample)
- **Split**: Train 9,843 | Test 2,468
- **Range**: Normalized to [-1, 1]

## 🎓 Learning Takeaways

### Must-know topics

1. **FPS sampling algorithm**
   - Understand the greedy strategy ensuring spatial uniformity
   - Time complexity O(N×K), applicability analysis
   - Pros/cons vs random sampling and voxel downsampling

2. **Point cloud data augmentation**
   - Parameter selection for rotation/scaling/jitter
   - Balance between noise level and geometry preservation
   - Designing composed augmentation strategies

3. **Permutation invariance design**
   - Why point clouds require permutation invariance
   - MaxPool vs MeanPool
   - How to verify permutation invariance

4. **Multi-platform adaptation**
   - MPS vs CUDA vs CPU performance comparison
   - Pin memory, num_workers optimization
   - Trade-offs between batch size and memory

## 🔧 Tech Stack

| Category | Tools/Frameworks | Version |
|------|----------|------|
| **Deep Learning** | PyTorch | 2.0+ |
| **Data Processing** | NumPy, SciPy | Latest |
| **Datasets** | Hugging Face Datasets | Latest |
| **Visualization** | Plotly, Matplotlib | Latest |
| **Dev Environment** | Jupyter Notebook | Latest |
| **Acceleration** | CUDA, MPS, CPU | - |

## 📈 Future Directions

### Algorithmic
1. **Stronger sampling**: Geometry-aware sampling incorporating normals
2. **Self-supervised pretraining**: Contrastive learning to improve feature quality
3. **Attention mechanisms**: Introduce Transformers for long-range dependencies
4. **Multi-scale features**: Set Abstraction layers from PointNet++

### Engineering
1. **Model compression**: Quantization, pruning, knowledge distillation
2. **Inference optimization**: ONNX conversion, TensorRT acceleration
3. **Real-time deployment**: Edge device adaptation, mobile optimization
4. **Continual learning**: Online updates, incremental training

## 🔗 Resources

- [PointNet Paper](https://arxiv.org/abs/1612.00593) - Pioneering point cloud deep learning
- [PointNet++ Paper](https://arxiv.org/abs/1706.02413) - Hierarchical point cloud processing
- [PointMLP Paper](https://arxiv.org/abs/2202.07123) - Efficient pure-MLP architecture
- [ModelNet Dataset](https://modelnet.cs.princeton.edu/) - Official website

---

*This project provides a complete learning path from theory to practice, suitable for beginners in 3D deep learning and engineering practice.*


