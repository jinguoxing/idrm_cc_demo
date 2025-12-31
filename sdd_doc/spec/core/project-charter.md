# IDRM Project Charter

> **Version**: 3.0.0  
> **Last Updated**: 2025-12-31

---

## 概述

IDRM (Intelligent Data Resource Management) 是一个智能数据资源管理平台，采用 Go-Zero 微服务架构。

---

## 技术栈

| 项目 | 版本 |
|------|------|
| 语言 | Go 1.21+ |
| 框架 | Go-Zero v1.9+ |
| 数据库 | MySQL 8.0 |
| 缓存 | Redis 7.0 |
| 消息队列 | Kafka 3.0 |

详见：`tech-stack.md`

---

## 开发原则

### 架构原则

| 原则 | 说明 |
|------|------|
| 分层架构 | Handler → Logic → Model 严格分离 |
| 接口驱动 | 面向接口编程，便于测试和替换 |
| 双 ORM | GORM + SQLx 灵活选择 |

详见：`../architecture/`

### 编码原则

| 原则 | 说明 |
|------|------|
| 可读性优先 | 清晰命名 + 完整注释 |
| 简单优于复杂 | KISS 原则 |
| 错误处理完整 | 所有 error 必须处理 |

详见：`../coding-standards/`

---

## 5 阶段工作流

```
Phase 0: Context    - 准备上下文，理解规范
Phase 1: Specify    - 定义需求和验收标准
Phase 2: Design     - 技术方案和架构设计
Phase 3: Tasks      - 任务拆分和规划
Phase 4: Implement  - 实施、测试和验收
```

**⚠️ 每阶段完成后必须等待用户确认**

详见：`workflow.md`

---

## 质量标准

### 代码质量

```bash
go build ./...              # 编译检查
go test -cover ./...        # 测试检查 (>80%)
golangci-lint run           # 代码检查
```

### 架构质量

- ✅ 符合分层架构
- ✅ 接口设计合理
- ✅ 依赖关系清晰
- ✅ 函数 ≤50 行

---

**Version**: 3.0.0
