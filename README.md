# Arkin's Blog

一个基于 Hugo 和 Congo 主题构建的个人博客，支持中英文双语。

## 🌟 特性

- **多语言支持**：中文和英文双语切换
- **现代化设计**：基于 Congo 主题的优雅界面
- **响应式布局**：完美适配各种设备
- **快速加载**：Hugo 静态站点生成器
- **SEO 优化**：内置 SEO 功能
- **暗色模式**：支持明暗主题切换

## 🚀 技术栈

- **静态站点生成器**：[Hugo](https://gohugo.io/)
- **主题**：[Congo](https://github.com/jpanther/congo)
- **样式**：Tailwind CSS
- **部署**：GitHub Pages / Netlify / Vercel

## 📁 项目结构

```
blog/
├── config/                 # 配置文件
│   └── _default/
│       ├── hugo.toml      # Hugo 主配置
│       ├── languages.en.toml  # 英文配置
│       └── languages.zh-Hans.toml  # 中文配置
├── content/               # 内容文件
│   ├── posts/            # 博客文章
│   ├── about.md          # 关于页面
│   └── _index.md         # 首页
├── layouts/              # 自定义布局
├── themes/               # 主题文件
│   └── congo/           # Congo 主题
├── static/              # 静态资源
└── public/              # 构建输出
```

## 🛠️ 本地开发

### 环境要求

- Hugo Extended 版本
- Git

### 安装步骤

1. **克隆仓库**
   ```bash
   git clone https://github.com/arkin-developer/blog.git
   cd blog
   ```

2. **启动开发服务器**
   ```bash
   hugo server --buildDrafts --buildFuture
   ```

3. **访问网站**
   - 打开浏览器访问：`http://localhost:1313`

### 构建生产版本

```bash
hugo --minify
```

## 📝 添加新文章

1. **创建新文章**
   ```bash
   hugo new posts/my-new-post.md
   ```

2. **文章格式**
   ```markdown
   ---
   title: "文章标题"
   date: 2024-01-01
   description: "文章描述"
   tags: ["标签1", "标签2"]
   categories: ["分类"]
   ---

   文章内容...
   ```

## 🌐 多语言支持

项目支持中英文双语：

- **中文**：`/zh-hans/`
- **英文**：`/en/`

### 语言切换

在网站底部可以切换语言，或直接访问对应语言路径。

## 🎨 自定义配置

### 主题颜色

在 `config/_default/params.toml` 中修改：

```toml
colorScheme = "congo"  # 可选：congo, avocado, cherry, fire, ocean, sapphire, slate
```

### 作者信息

在语言配置文件中修改作者信息：

```toml
[params.author]
  name = "ArkinDev"
  image = "img/author.jpg"
  headline = "全栈开发者"
  bio = "专注于Web开发和开源项目"
```

## 📦 部署

### GitHub Pages

1. 在 GitHub 仓库设置中启用 Pages
2. 选择 `main` 分支的 `/docs` 文件夹
3. 构建命令：`hugo --minify --destination docs`

### Netlify

1. 连接 GitHub 仓库
2. 构建命令：`hugo --minify`
3. 发布目录：`public`

### Vercel

1. 导入 GitHub 仓库
2. 框架预设：Hugo
3. 自动部署

## 🔧 自定义开发

### 修改主题

1. 复制主题文件到 `layouts/` 目录
2. 根据需要修改模板文件

### 添加自定义样式

在 `assets/css/custom.css` 中添加自定义样式。

### 添加自定义脚本

在 `layouts/_partials/extend-footer.html` 中添加自定义脚本。

## 📄 许可证

本项目采用 MIT 许可证。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📞 联系

- **GitHub**：[@arkin-developer](https://github.com/arkin-developer)
- **邮箱**：your.email@example.com

---

⭐ 如果这个项目对您有帮助，请给个 Star！