# 架构文档

> **Version**: 3.0.0  
> **Last Updated**: 2025-12-31

---

## 📚 文档清单

| 文档 | 说明 |
|------|------|
| [分层架构](./layered-architecture.md) | Handler → Logic → Model 职责和目录结构 |
| [双ORM模式](./dual-orm-pattern.md) | GORM + SQLx 实现规范 |
| [API服务指南](./api-service-guide.md) | goctl 代码生成 + 配置规范 |

---

## 🎯 核心原则

| 原则 | 说明 |
|------|------|
| 分层清晰 | Handler → Logic → Model |
| 接口抽象 | 面向接口编程 |
| 单向依赖 | 上层依赖下层，禁止反向 |

---

## 📖 阅读顺序

1. [分层架构](./layered-architecture.md)
2. [双ORM模式](./dual-orm-pattern.md)
3. [API服务指南](./api-service-guide.md)

---

**Version**: 3.0.0
