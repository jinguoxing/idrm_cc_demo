# IDRM 技术栈

> **Version**: 3.0.0  
> **Last Updated**: 2025-12-31

---

## 核心技术

| 组件 | 版本 | 用途 |
|------|------|------|
| Go | 1.21+ | 编程语言 |
| Go-Zero | 1.9+ | 微服务框架 |
| MySQL | 8.0 | 主数据存储 |
| Redis | 7.0 | 缓存/分布式锁 |
| Kafka | 3.0 | 消息队列 |

---

## ORM 选择

| ORM | 适用场景 |
|-----|----------|
| **GORM** | 复杂查询、关联预加载、事务 |
| **SQLx** | 简单 CRUD、性能敏感、原生 SQL |

详见：`../architecture/dual-orm-pattern.md`

---

## 数据库规范

| 项目 | 规范 |
|------|------|
| 表名 | 复数小写 (categories) |
| 字段名 | 下划线分隔 (created_at) |
| 字符集 | utf8mb4 |

---

## Redis 规范

| 项目 | 规范 |
|------|------|
| Key 命名 | `{project}:{module}:{type}:{id}` |
| 过期时间 | 必须设置 |
| 序列化 | JSON |

---

## 必需工具

| 工具 | 用途 |
|------|------|
| goctl | Go-Zero 代码生成 |
| golangci-lint | 代码检查 |
| go test | 单元测试 |
| go-swagger | API 文档生成 |

---

## Go 依赖管理

```bash
# 初始化模块
go mod init {module-name}

# 整理依赖（删除未用、添加缺失）
go mod tidy

# 更新所有依赖
go get -u ./...

# 更新指定依赖
go get -u github.com/xxx/xxx

# 下载依赖到本地缓存
go mod download

# 查看依赖关系
go mod graph
```

---

**Version**: 3.0.0
