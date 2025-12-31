# Phase 0: Context (上下文准备)

> **Level**: SHOULD  
> **Version**: 2.0.0

## 目标

准备开发上下文，理解项目规范。

## 活动清单

### 1. 阅读核心规范
- [ ] `../core/project-charter.md`
- [ ] `../core/tech-stack.md`
- [ ] `../core/workflow.md`

### 2. 了解相关规范
- [ ] `../architecture/layered-architecture.md`
- [ ] `../architecture/dual-orm-pattern.md`
- [ ] `../coding-standards/go-style-guide.md`

### 3. 准备环境
- [ ] 代码已clone
- [ ] 依赖已安装
- [ ] 数据库已启动
- [ ] AI工具已配置

## AI 工具使用

**Cursor**:
```
@sdd_doc/spec/core/project-charter.md
请总结IDRM项目的核心规范
```

**Claude CLI**:
```bash
claude --files "sdd_doc/spec/core/*.md" \
  "总结项目规范要点"
```

## 检查清单
- [ ] 理解分层架构
- [ ] 理解双ORM模式
- [ ] 熟悉编码规范
- [ ] 开发环境就绪

---

## ⚠️ 人工检查点

> **AI MUST STOP HERE**

完成 Phase 0 后：
1. 向用户汇报已阅读的规范和理解的要点
2. 等待用户确认后再继续 Phase 1
3. **禁止自动进入 Phase 1**

**输出示例**:
```
✅ Phase 0: Context 完成

已阅读规范:
- project-charter.md: 项目使用 Go-Zero 微服务架构
- layered-architecture.md: 遵循 Handler→Logic→Model 三层
- dual-orm-pattern.md: 使用 GORM + SQLx 双 ORM

是否继续执行 Phase 1: Specify？
```

---

## 下一步
→ Phase 1: Specify (需用户确认)
