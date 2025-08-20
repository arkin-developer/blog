---
title: "项目展示"
description: "交互式项目展示页面"
---

{{< lead >}}
交互式项目展示
{{< /lead >}}

<style>
.project-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
}

.project-card {
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: 1.5rem;
  transition: all 0.3s ease;
  background: var(--color-background);
}

.project-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
  border-color: var(--color-primary);
}

.project-image {
  width: 100%;
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 6px;
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.2rem;
  font-weight: bold;
}

.project-title {
  font-size: 1.3rem;
  font-weight: bold;
  margin-bottom: 0.5rem;
  color: var(--color-text);
}

.project-description {
  color: var(--color-text-secondary);
  margin-bottom: 1rem;
  line-height: 1.6;
}

.project-tech {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.tech-tag {
  background: var(--color-primary);
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 500;
}

.project-links {
  display: flex;
  gap: 1rem;
}

.project-link {
  padding: 0.5rem 1rem;
  border: 1px solid var(--color-primary);
  border-radius: 4px;
  text-decoration: none;
  color: var(--color-primary);
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.project-link:hover {
  background: var(--color-primary);
  color: white;
}

.project-link.primary {
  background: var(--color-primary);
  color: white;
}

.project-link.primary:hover {
  background: var(--color-primary-dark);
}

.status-badge {
  display: inline-block;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 500;
  margin-bottom: 1rem;
}

.status-completed {
  background: #10b981;
  color: white;
}

.status-development {
  background: #f59e0b;
  color: white;
}

.status-planning {
  background: #6b7280;
  color: white;
}

.filter-buttons {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.filter-btn {
  padding: 0.5rem 1rem;
  border: 1px solid var(--color-border);
  background: var(--color-background);
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.filter-btn.active {
  background: var(--color-primary);
  color: white;
  border-color: var(--color-primary);
}

.filter-btn:hover {
  border-color: var(--color-primary);
}
</style>

<div class="filter-buttons">
  <button class="filter-btn active" onclick="filterProjects('all')">全部</button>
  <button class="filter-btn" onclick="filterProjects('web')">Web应用</button>
  <button class="filter-btn" onclick="filterProjects('mobile')">移动应用</button>
  <button class="filter-btn" onclick="filterProjects('tool')">工具库</button>
</div>

<div class="project-grid" id="projectGrid">
  <!-- 项目1 -->
  <div class="project-card" data-category="web">
    <div class="project-image">个人博客系统</div>
    <span class="status-badge status-completed">已完成</span>
    <h3 class="project-title">个人博客系统</h3>
    <p class="project-description">
      基于 Hugo 构建的现代化个人博客，支持多语言、响应式设计和 SEO 优化。
    </p>
    <div class="project-tech">
      <span class="tech-tag">Hugo</span>
      <span class="tech-tag">GitHub Pages</span>
      <span class="tech-tag">CSS3</span>
    </div>
    <div class="project-links">
      <a href="https://github.com/arkin-developer/blog" class="project-link" target="_blank">源码</a>
      <a href="https://arkin-developer.github.io/blog" class="project-link primary" target="_blank">演示</a>
    </div>
  </div>

  <!-- 项目2 -->
  <div class="project-card" data-category="web">
    <div class="project-image">在线笔记应用</div>
    <span class="status-badge status-development">开发中</span>
    <h3 class="project-title">在线笔记应用</h3>
    <p class="project-description">
      支持实时协作的在线笔记应用，具有 Markdown 编辑器和版本控制功能。
    </p>
    <div class="project-tech">
      <span class="tech-tag">React</span>
      <span class="tech-tag">Node.js</span>
      <span class="tech-tag">MongoDB</span>
    </div>
    <div class="project-links">
      <a href="#" class="project-link">源码</a>
      <a href="#" class="project-link primary">演示</a>
    </div>
  </div>

  <!-- 项目3 -->
  <div class="project-card" data-category="mobile">
    <div class="project-image">任务管理 App</div>
    <span class="status-badge status-completed">已完成</span>
    <h3 class="project-title">任务管理 App</h3>
    <p class="project-description">
      跨平台任务管理应用，支持任务创建、分类、提醒和同步功能。
    </p>
    <div class="project-tech">
      <span class="tech-tag">React Native</span>
      <span class="tech-tag">Firebase</span>
      <span class="tech-tag">Redux</span>
    </div>
    <div class="project-links">
      <a href="#" class="project-link">源码</a>
      <a href="#" class="project-link primary">下载</a>
    </div>
  </div>

  <!-- 项目4 -->
  <div class="project-card" data-category="tool">
    <div class="project-image">代码生成器</div>
    <span class="status-badge status-completed">已完成</span>
    <h3 class="project-title">代码生成器</h3>
    <p class="project-description">
      自动化代码生成工具，支持多种项目模板和自定义配置。
    </p>
    <div class="project-tech">
      <span class="tech-tag">Python</span>
      <span class="tech-tag">Jinja2</span>
      <span class="tech-tag">CLI</span>
    </div>
    <div class="project-links">
      <a href="#" class="project-link">源码</a>
      <a href="#" class="project-link primary">文档</a>
    </div>
  </div>

  <!-- 项目5 -->
  <div class="project-card" data-category="web">
    <div class="project-image">电商平台</div>
    <span class="status-badge status-planning">规划中</span>
    <h3 class="project-title">电商平台</h3>
    <p class="project-description">
      全功能电商平台，包含商品管理、订单处理、支付集成等功能。
    </p>
    <div class="project-tech">
      <span class="tech-tag">Vue.js</span>
      <span class="tech-tag">Express</span>
      <span class="tech-tag">PostgreSQL</span>
    </div>
    <div class="project-links">
      <a href="#" class="project-link">规划</a>
      <a href="#" class="project-link primary">原型</a>
    </div>
  </div>

  <!-- 项目6 -->
  <div class="project-card" data-category="tool">
    <div class="project-image">API 测试工具</div>
    <span class="status-badge status-development">开发中</span>
    <h3 class="project-title">API 测试工具</h3>
    <p class="project-description">
      轻量级 API 测试和调试工具，支持多种请求方法和数据格式。
    </p>
    <div class="project-tech">
      <span class="tech-tag">Electron</span>
      <span class="tech-tag">TypeScript</span>
      <span class="tech-tag">SQLite</span>
    </div>
    <div class="project-links">
      <a href="#" class="project-link">源码</a>
      <a href="#" class="project-link primary">下载</a>
    </div>
  </div>
</div>

<script>
function filterProjects(category) {
  const projects = document.querySelectorAll('.project-card');
  const buttons = document.querySelectorAll('.filter-btn');
  
  // 更新按钮状态
  buttons.forEach(btn => btn.classList.remove('active'));
  event.target.classList.add('active');
  
  // 过滤项目
  projects.forEach(project => {
    if (category === 'all' || project.dataset.category === category) {
      project.style.display = 'block';
    } else {
      project.style.display = 'none';
    }
  });
}

// 添加项目卡片点击效果
document.querySelectorAll('.project-card').forEach(card => {
  card.addEventListener('click', function(e) {
    if (!e.target.classList.contains('project-link')) {
      this.style.transform = 'scale(0.98)';
      setTimeout(() => {
        this.style.transform = 'translateY(-5px)';
      }, 150);
    }
  });
});
</script>

## 项目统计

- **总项目数**: 6 个
- **已完成**: 3 个
- **开发中**: 2 个
- **规划中**: 1 个

## 技术栈分布

- **前端框架**: React, Vue.js, React Native
- **后端技术**: Node.js, Python, Express
- **数据库**: MongoDB, PostgreSQL, SQLite
- **云服务**: Firebase, GitHub Pages
- **工具**: Hugo, Electron, TypeScript

---

*这些项目展示了我在不同技术领域的实践经验和学习成果。每个项目都经过精心设计和开发，体现了对用户体验和代码质量的追求。*
