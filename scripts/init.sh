#!/bin/bash

# IDRM AI Template 初始化脚本
# 用法: ./scripts/init.sh <project_name> <module_path>
# 示例: ./scripts/init.sh my-project github.com/myorg/my-project

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 默认值
OLD_PROJECT="idrm-ai-template"
OLD_MODULE="idrm-ai-template"

# 参数检查
if [ -z "$1" ]; then
    echo -e "${YELLOW}用法: ./scripts/init.sh <project_name> [module_path]${NC}"
    echo -e "示例: ./scripts/init.sh my-project github.com/myorg/my-project"
    exit 1
fi

NEW_PROJECT=$1
NEW_MODULE=${2:-$1}

echo -e "${GREEN}🚀 初始化项目...${NC}"
echo -e "项目名称: ${YELLOW}$NEW_PROJECT${NC}"
echo -e "模块路径: ${YELLOW}$NEW_MODULE${NC}"

# 1. 替换 go.mod 中的模块路径
echo -e "\n${GREEN}[1/4] 更新 go.mod...${NC}"
if [ -f "go.mod" ]; then
    sed -i '' "s|module $OLD_MODULE|module $NEW_MODULE|g" go.mod
    echo "✅ go.mod 已更新"
else
    echo -e "${YELLOW}⚠️ go.mod 不存在，创建新文件...${NC}"
    cat > go.mod << EOF
module $NEW_MODULE

go 1.21

require (
    github.com/zeromicro/go-zero v1.9.0
    gorm.io/gorm v1.25.0
    gorm.io/driver/mysql v1.5.0
)
EOF
    echo "✅ go.mod 已创建"
fi

# 2. 替换所有 Go 文件中的 import 路径
echo -e "\n${GREEN}[2/4] 更新 import 路径...${NC}"
find . -name "*.go" -type f | while read file; do
    sed -i '' "s|\"$OLD_MODULE/|\"$NEW_MODULE/|g" "$file"
done
echo "✅ Go 文件 import 已更新"

# 3. 更新配置文件中的项目名
echo -e "\n${GREEN}[3/4] 更新配置文件...${NC}"
if [ -f "api/etc/api.yaml" ]; then
    sed -i '' "s|Name: $OLD_PROJECT|Name: $NEW_PROJECT|g" api/etc/api.yaml
    echo "✅ api.yaml 已更新"
fi

# 4. 更新 Makefile 中的项目名
echo -e "\n${GREEN}[4/4] 更新 Makefile...${NC}"
if [ -f "Makefile" ]; then
    sed -i '' "s|PROJECT_NAME := $OLD_PROJECT|PROJECT_NAME := $NEW_PROJECT|g" Makefile
    echo "✅ Makefile 已更新"
fi

# 5. 安装依赖
echo -e "\n${GREEN}[5/5] 安装依赖...${NC}"
go mod tidy

echo -e "\n${GREEN}✅ 项目初始化完成！${NC}"
echo -e "\n下一步:"
echo -e "  1. 编辑 api/etc/api.yaml 配置数据库等信息"
echo -e "  2. 运行 ${YELLOW}make api${NC} 生成 API 代码"
echo -e "  3. 运行 ${YELLOW}make run${NC} 启动服务"
