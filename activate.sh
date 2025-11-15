#!/bin/bash
# Skill Seekers 快速激活脚本

echo "🚀 激活 Skill Seekers 虚拟环境..."

# 激活虚拟环境
source venv/bin/activate

echo "✅ 虚拟环境已激活！"
echo ""
echo "可用命令:"
echo "  skill-seekers --help          查看帮助"
echo "  skill-seekers --version       查看版本"
echo "  skill-seekers scrape ...      抓取文档"
echo "  skill-seekers unified ...     多源抓取"
echo "  skill-seekers package ...     打包技能"
echo ""
echo "运行 'skill-seekers --help' 查看所有命令"
echo ""
