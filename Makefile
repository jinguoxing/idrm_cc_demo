.PHONY: init api lint test build clean

# 项目名称（可通过 init.sh 替换）
PROJECT_NAME := idrm-ai-template

# 初始化项目
init:
	@./scripts/init.sh

# 生成 API 代码
api:
	goctl api go -api api/doc/api.api -dir api/ --style=go_zero --type-group

# 格式化代码
fmt:
	gofmt -w .
	goimports -w .

# 代码检查
lint:
	golangci-lint run ./...

# 运行测试
test:
	go test -v -cover ./...

# 编译
build:
	go build -o bin/$(PROJECT_NAME) ./api/api.go

# 运行
run:
	go run api/api.go

# 清理
clean:
	rm -rf bin/
	go clean

# 安装依赖
deps:
	go mod tidy
	go mod download

# 帮助
help:
	@echo "Available commands:"
	@echo "  make init   - Initialize project"
	@echo "  make api    - Generate API code with goctl"
	@echo "  make fmt    - Format code"
	@echo "  make lint   - Run linter"
	@echo "  make test   - Run tests"
	@echo "  make build  - Build binary"
	@echo "  make run    - Run server"
	@echo "  make clean  - Clean build artifacts"
	@echo "  make deps   - Install dependencies"
