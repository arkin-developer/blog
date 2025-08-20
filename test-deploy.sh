#!/bin/bash

# 本地测试 GitHub Actions 部署流程
# 使用方法: ./test-deploy.sh

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# 开始测试
echo "🚀 开始本地测试 GitHub Actions 部署流程..."
echo "=================================================="

# 步骤 1: 检查 Hugo 版本
log_info "步骤 1: 检查 Hugo 版本"
if ! command -v hugo &> /dev/null; then
    log_error "Hugo 未安装，请先安装 Hugo"
    exit 1
fi

HUGO_VERSION=$(hugo version)
log_success "Hugo 版本: $HUGO_VERSION"

# 检查是否为 Extended 版本
if [[ $HUGO_VERSION == *"+extended"* ]]; then
    log_success "✅ Hugo Extended 版本检测通过"
else
    log_warning "⚠️  检测到普通版本，建议使用 Hugo Extended 版本"
fi

# 步骤 2: 检查项目结构
log_info "步骤 2: 检查项目结构"
if [ ! -f "config/_default/hugo.toml" ]; then
    log_error "未找到 hugo.toml 配置文件"
    exit 1
fi

if [ ! -f "content/_index.md" ]; then
    log_warning "未找到首页内容文件 content/_index.md"
fi

if [ ! -f "go.mod" ]; then
    log_warning "未找到 go.mod 文件，可能不是模块项目"
fi

log_success "项目结构检查完成"

# 步骤 3: 安装 Hugo 模块
log_info "步骤 3: 安装 Hugo 模块"
if [ -f "go.mod" ]; then
    log_info "更新 Hugo 模块..."
    hugo mod get -u
    log_info "整理 Hugo 模块..."
    hugo mod tidy
    log_success "Hugo 模块安装完成"
else
    log_warning "跳过模块安装（非模块项目）"
fi

# 步骤 4: 清理之前的构建
log_info "步骤 4: 清理之前的构建"
if [ -d "public" ]; then
    rm -rf public/
    log_success "清理 public 目录完成"
fi

if [ -d "docs" ]; then
    rm -rf docs/
    log_success "清理 docs 目录完成"
fi

# 步骤 5: 构建站点（模拟 GitHub Actions 环境）
log_info "步骤 5: 构建站点"
log_info "设置环境变量: HUGO_ENVIRONMENT=production, HUGO_ENV=production"

# 记录构建开始时间
BUILD_START=$(date +%s)

# 执行构建
HUGO_ENVIRONMENT=production HUGO_ENV=production hugo --gc --minify --logLevel info

# 检查构建结果
if [ $? -ne 0 ]; then
    log_error "构建失败"
    exit 1
fi

# 计算构建时间
BUILD_END=$(date +%s)
BUILD_TIME=$((BUILD_END - BUILD_START))
log_success "构建成功，耗时 ${BUILD_TIME} 秒"

# 步骤 6: 验证构建输出
log_info "步骤 6: 验证构建输出"

# 检查关键文件
if [ ! -f "public/index.html" ]; then
    log_error "index.html 文件不存在"
    exit 1
fi

if [ ! -f "public/404.html" ]; then
    log_warning "404.html 文件不存在"
fi

if [ ! -f "public/sitemap.xml" ]; then
    log_warning "sitemap.xml 文件不存在"
fi

# 统计信息
TOTAL_FILES=$(find public/ -type f | wc -l)
HTML_FILES=$(find public/ -name "*.html" | wc -l)
CSS_FILES=$(find public/ -name "*.css" | wc -l)
JS_FILES=$(find public/ -name "*.js" | wc -l)
INDEX_SIZE=$(ls -lh public/index.html | awk '{print $5}')

log_success "构建验证完成"

# 步骤 7: 生成测试报告
log_info "步骤 7: 生成测试报告"
echo ""
echo "📊 构建统计报告"
echo "=================================================="
echo "📁 总文件数: $TOTAL_FILES"
echo "🌐 HTML 文件: $HTML_FILES"
echo "🎨 CSS 文件: $CSS_FILES"
echo "⚡ JS 文件: $JS_FILES"
echo "📄 首页大小: $INDEX_SIZE"
echo "⏱️  构建时间: ${BUILD_TIME} 秒"
echo ""

# 检查多语言支持
if [ -d "public/zh-hans" ]; then
    log_success "✅ 中文版本检测到"
fi

if [ -d "public/en" ]; then
    log_success "✅ 英文版本检测到"
fi

# 检查主题功能
if grep -q "congo" public/index.html; then
    log_success "✅ Congo 主题检测到"
fi

# 步骤 8: 可选 - 启动本地服务器
echo ""
log_info "步骤 8: 测试选项"
echo "选择要执行的测试："
echo "1) 启动本地服务器预览 (hugo server)"
echo "2) 检查构建文件内容"
echo "3) 退出测试"
echo ""
read -p "请输入选择 (1-3): " choice

case $choice in
    1)
        log_info "启动本地服务器..."
        echo "🌐 服务器将在 http://localhost:1313 启动"
        echo "按 Ctrl+C 停止服务器"
        hugo server --bind 0.0.0.0 --port 1313
        ;;
    2)
        log_info "检查构建文件内容..."
        echo "📄 index.html 前几行："
        head -5 public/index.html
        echo ""
        echo "📄 robots.txt 内容："
        cat public/robots.txt
        ;;
    3)
        log_success "测试完成，退出"
        ;;
    *)
        log_warning "无效选择，退出"
        ;;
esac

# 最终总结
echo ""
echo "🎉 本地测试完成！"
echo "=================================================="
log_success "✅ Hugo 版本: $(hugo version | head -1)"
log_success "✅ 构建成功: 生成了 $HTML_FILES 个 HTML 文件"
log_success "✅ 文件大小: index.html $INDEX_SIZE"
log_success "✅ 构建时间: ${BUILD_TIME} 秒"
echo ""
echo "💡 提示："
echo "- 如果所有检查都通过，你的 GitHub Actions 配置应该能正常工作"
echo "- 要推送到 GitHub 触发真实部署，运行: git add . && git commit -m 'test' && git push"
echo "- 如果遇到问题，请检查 GitHub Actions 日志"
echo ""
log_success "测试脚本执行完成！"
