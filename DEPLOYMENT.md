# Skill Seekers 部署指南

## 部署状态

✅ **部署成功！** (2025-11-15)

- **Python 版本**: 3.11.14
- **项目版本**: v2.0.0
- **安装方式**: 开发模式 (editable install)
- **测试状态**: 379/411 测试通过 ✅

---

## 快速开始

### 1. 激活虚拟环境

```bash
source venv/bin/activate
```

### 2. 验证安装

```bash
# 查看版本
skill-seekers --version
# 输出: skill-seekers 2.0.0

# 查看帮助
skill-seekers --help
```

### 3. 运行你的第一个技能抓取

```bash
# 使用预设配置抓取文档
skill-seekers scrape --config configs/godot.json

# 或使用快速模式
skill-seekers scrape --name react --url https://react.dev/
```

---

## 可用命令

### 文档抓取

```bash
# 单源抓取（仅文档）
skill-seekers scrape --config configs/react.json
skill-seekers scrape --config configs/django.json
skill-seekers scrape --config configs/godot.json

# 异步模式（更快）
skill-seekers scrape --config configs/react.json --async --workers 8

# 跳过抓取，仅重建
skill-seekers scrape --config configs/godot.json --skip-scrape
```

### GitHub 仓库抓取

```bash
# 抓取 GitHub 仓库
skill-seekers github --repo facebook/react --name react

# 带 API token（更高速率限制）
export GITHUB_TOKEN=your_token_here
skill-seekers github --repo microsoft/TypeScript --name typescript
```

### 统一多源抓取 (NEW!)

```bash
# 结合文档 + GitHub + PDF
skill-seekers unified --config configs/react_unified.json
skill-seekers unified --config configs/django_unified.json

# 自定义合并模式
skill-seekers unified --config configs/react_unified.json --merge-mode claude-enhanced
```

### PDF 提取

```bash
# 从 PDF 提取内容
skill-seekers pdf --file documentation.pdf --name my-skill
```

### AI 增强

```bash
# 本地增强（使用 Claude Code Max，免费）
skill-seekers enhance output/react/

# 或在抓取时同时增强
skill-seekers scrape --config configs/react.json --enhance-local
```

### 打包和上传

```bash
# 打包技能为 .zip
skill-seekers package output/godot/

# 打包并自动上传到 Claude
export ANTHROPIC_API_KEY=sk-ant-...
skill-seekers package output/godot/ --upload

# 或单独上传
skill-seekers upload output/godot.zip
```

### 估算页面数

```bash
# 在抓取前估算页面数量
skill-seekers estimate configs/react.json

# 自定义发现限制
skill-seekers estimate configs/godot.json --max-discovery 2000
```

---

## 项目结构

```
Skill_Seekers/
├── venv/                       # 虚拟环境 ✅
├── src/skill_seekers/          # 源代码
│   ├── cli/                    # CLI 工具
│   │   ├── doc_scraper.py      # 文档抓取器
│   │   ├── github_scraper.py   # GitHub 抓取器
│   │   ├── pdf_scraper.py      # PDF 提取器
│   │   ├── unified_scraper.py  # 统一抓取器
│   │   ├── enhance_skill_local.py # 本地 AI 增强
│   │   ├── package_skill.py    # 打包工具
│   │   └── upload_skill.py     # 上传工具
│   └── mcp/                    # MCP 服务器
│       └── server.py
├── configs/                    # 24 个预设配置
│   ├── godot.json
│   ├── react.json
│   ├── django_unified.json
│   └── ...
├── output/                     # 生成的输出（.gitignore）
│   ├── {name}_data/            # 缓存的原始数据
│   └── {name}/                 # 构建的技能目录
├── tests/                      # 测试套件（411 个测试）
└── pyproject.toml              # 项目配置

```

---

## 环境变量（可选）

```bash
# Claude AI API（用于 AI 增强和上传）
export ANTHROPIC_API_KEY=sk-ant-your-key-here

# GitHub Token（用于更高的 API 速率限制）
export GITHUB_TOKEN=ghp_your-token-here

# 或创建 .env 文件
cat > .env << EOF
ANTHROPIC_API_KEY=sk-ant-your-key-here
GITHUB_TOKEN=ghp_your-token-here
EOF
```

---

## 开发工作流

### 运行测试

```bash
# 激活环境
source venv/bin/activate

# 运行所有测试
pytest tests/

# 运行特定测试文件
pytest tests/test_scraper_features.py

# 带覆盖率报告
pytest tests/ --cov=src/skill_seekers --cov-report=html

# 详细输出
pytest tests/ -v

# 快速测试（失败时停止）
pytest tests/ -x
```

### 修改代码

由于使用 `pip install -e .` 安装（可编辑模式），代码修改会立即生效：

```bash
# 编辑代码
nano src/skill_seekers/cli/doc_scraper.py

# 直接运行（无需重新安装）
skill-seekers scrape --config configs/test.json

# 运行测试验证
pytest tests/test_scraper_features.py
```

### 添加新配置

```bash
# 复制现有配置
cp configs/react.json configs/myframework.json

# 编辑配置
nano configs/myframework.json

# 小规模测试（限制页面数）
# 在配置中设置 "max_pages": 20

# 运行
skill-seekers scrape --config configs/myframework.json
```

---

## MCP 服务器集成（可选）

如需将 Skill Seekers 作为 MCP 服务器集成到 Claude Code：

```bash
# 运行 MCP 设置脚本
./setup_mcp.sh

# 或手动配置
# 查看文档: docs/MCP_SETUP.md
```

---

## 故障排除

### 虚拟环境未激活

**问题**: `skill-seekers: command not found`

**解决**:
```bash
source venv/bin/activate
```

### 依赖缺失

**问题**: `ModuleNotFoundError: No module named '...'`

**解决**:
```bash
source venv/bin/activate
pip install -e .
```

### 测试失败

**问题**: 某些测试失败

**解决**:
```bash
# 重新安装依赖
pip install -e .
pip install pytest pytest-cov coverage

# 重新运行测试
pytest tests/
```

### 输出目录权限问题

**问题**: `Permission denied` 写入 `output/` 目录

**解决**:
```bash
# 检查目录权限
ls -la output/

# 创建目录（如果不存在）
mkdir -p output/
chmod 755 output/
```

---

## 示例工作流程

### 场景 1: 首次抓取新框架文档

```bash
# 1. 激活环境
source venv/bin/activate

# 2. 估算页面数
skill-seekers estimate configs/godot.json

# 3. 抓取 + 本地增强
skill-seekers scrape --config configs/godot.json --enhance-local

# 4. 打包
skill-seekers package output/godot/

# 结果: godot.zip 已准备好上传到 Claude
```

### 场景 2: 使用缓存快速迭代

```bash
# 1. 使用现有数据重建
skill-seekers scrape --config configs/godot.json --skip-scrape

# 2. 增强
skill-seekers enhance output/godot/

# 3. 打包
skill-seekers package output/godot/

# 时间: ~2 分钟（而非 20-40 分钟）
```

### 场景 3: 多源统一抓取

```bash
# 1. 结合文档 + GitHub + 代码分析
skill-seekers unified --config configs/react_unified.json

# 2. 检查冲突报告
cat output/react/references/conflicts.md

# 3. 打包上传
skill-seekers package output/react/ --upload
```

---

## 性能优化

### 异步模式（推荐）

```bash
# 小型文档（100-500 页）
skill-seekers scrape --config configs/react.json --async --workers 4

# 中型文档（500-2000 页）
skill-seekers scrape --config configs/django.json --async --workers 8

# 大型文档（2000+ 页）
skill-seekers scrape --config configs/ansible-core.json --async --workers 8 --no-rate-limit
```

**性能对比**:
- 同步: ~18 页/秒，120 MB 内存
- 异步: ~55 页/秒，40 MB 内存（快 3 倍！）

---

## 卸载

如需卸载项目：

```bash
# 1. 退出虚拟环境
deactivate

# 2. 删除虚拟环境
rm -rf venv/

# 3. 清理输出文件（可选）
rm -rf output/
```

---

## 资源链接

- **GitHub**: https://github.com/yusufkaraaslan/Skill_Seekers
- **PyPI**: https://pypi.org/project/skill-seekers/
- **文档**: [README.md](README.md)
- **问题追踪**: https://github.com/yusufkaraaslan/Skill_Seekers/issues
- **项目看板**: https://github.com/users/yusufkaraaslan/projects/2

---

## 贡献

欢迎贡献！请查看：
- [FLEXIBLE_ROADMAP.md](FLEXIBLE_ROADMAP.md) - 134 个任务
- [NEXT_TASKS.md](NEXT_TASKS.md) - 优先任务
- [CONTRIBUTING.md](CONTRIBUTING.md) - 贡献指南

---

**部署完成！** 🎉

项目已成功部署并可以使用。开始创建你的第一个 Claude AI 技能吧！
