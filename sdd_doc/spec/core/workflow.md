# 统一工作流定义

> **Version**: 2.0.0  
> **Last Updated**: 2025-12-26  
> **Status**: Approved

---

## 概述

IDRM采用**5阶段标准工作流**，适用于所有开发场景，兼容所有AI工具。

---

## 5阶段工作流

```
Phase 0: Context (上下文准备)
   ↓ ⚠️ 人工检查点
Phase 1: Specify (需求规范)
   ↓ ⚠️ 人工检查点
Phase 2: Design (技术方案)
   ↓ ⚠️ 人工检查点
Phase 3: Tasks (任务拆分)
   ↓ ⚠️ 人工检查点
Phase 4: Implement (实施验证)
```

---

## ⚠️ AI Agent 行为规则

> **CRITICAL FOR AI TOOLS**: 以下规则必须严格遵守

### 规则 1: 单阶段执行
- **每次对话只执行一个 Phase**
- 完成当前 Phase 后必须停止
- 等待用户明确确认后才能继续下一个 Phase

### 规则 2: 人工检查点
- 每个 Phase 结束后，必须展示输出物并等待用户审批
- **禁止自动进入下一个 Phase**
- 即使用户说"开始开发XXX功能"，也只执行 Phase 0

### 规则 3: 明确输出
- 完成 Phase 后，明确告知用户当前阶段已完成
- 列出本阶段的输出物
- 询问用户是否继续下一阶段

### 示例对话
```
用户: 开始开发标签管理功能

AI: 好的，我将执行 **Phase 0: Context**。

[执行 Phase 0 内容...]

✅ **Phase 0 完成**

**输出物**:
- 已阅读项目规范
- 已了解架构要求
- 开发环境已就绪

**下一步**: Phase 1: Specify
是否继续执行 Phase 1？请确认。
```

---

## Phase 0: Context

### 目标
准备开发上下文，理解项目规范

### 输入
- 功能需求描述
- 相关背景信息

### 活动
1. 阅读项目规范 (`project-charter.md`)
2. 理解技术栈 (`tech-stack.md`)
3. 熟悉架构规范 (`../architecture/`)
4. 了解编码标准 (`../coding-standards/`)

### 输出
- 对项目规范的理解
- 准备好的开发环境

### 工具
- Cursor: `@sdd_doc/spec/core/`
- Claude CLI: `--files "sdd_doc/spec/**/*.md"`

### 检查清单
- [ ] 已阅读project-charter
- [ ] 已了解相关架构规范
- [ ] 已熟悉编码标准
- [ ] 开发环境就绪

---

## Phase 1: Specify

### 目标
定义清晰的需求和验收标准

### 输入
- Phase 0的理解
- 功能需求

### 活动
1. 编写用户故事
2. 定义验收标准 (EARS notation)
3. 明确业务规则
4. 列出不确定项

### 输出
`specs/features/{feature-name}/requirements.md`

**格式**:
```markdown
# Feature: {Name}

## User Stories
AS a {role}
I WANT {feature}
SO THAT {benefit}

## Acceptance Criteria (EARS)
WHEN {condition}
THE SYSTEM SHALL {behavior}

## Business Rules
- 业务规则和约束（非技术实现）
- 数据约束（唯一性、范围等）

## Data Considerations
需要持久化的数据描述（不是表结构）

## Open Questions
...
```

### 工具
- **Cursor**: 对话式编写 requirements
- **Claude CLI**: 批量生成 requirements

### 质量门禁
参考：`../quality/quality-gates.md#gate-1`

- [ ] 用户故事完整
- [ ] 使用EARS notation
- [ ] 业务规则明确
- [ ] 数据考量清晰
- [ ] **不包含技术实现细节**

---

## Phase 2: Design

### 目标
创建详细的技术方案

### 输入
- Phase 1的requirements.md

### 活动
1. 设计系统架构
2. 定义文件结构
3. 设计接口
4. 绘制序列图
5. 考虑实现细节

### 输出
`specs/features/{feature-name}/design.md`

**格式**:
```markdown
# Design: {Name}

## Architecture
遵循分层架构...

## File Structure
\`\`\`
model/...
logic/...
handler/...
\`\`\`

## Interface Definitions
\`\`\`go
type Model interface { ... }
\`\`\`

## Sequence Diagrams
...

## Implementation Considerations
...
```

### 工具
- **Cursor**: 引用 architecture 规范设计
- **Claude CLI**: 批量生成设计文档

### 质量门禁
参考：`../quality/quality-gates.md#gate-2`

- [ ] 符合分层架构
- [ ] 文件清单完整
- [ ] 接口定义清晰
- [ ] 序列图完整

---

## Phase 3: Tasks

### 目标
将设计拆分为可执行的小任务

### 输入
- Phase 2的design.md

### 活动
1. 拆分为小任务 (<50行)
2. 明确依赖关系
3. 定义验收标准
4. 估算工作量

### 输出
`specs/features/{feature-name}/tasks.md`

**格式**:
```markdown
# Tasks: {Name}

## Task 1: {Description}
**Status**: Not Started
**Depends on**: -
**Files**:
- path/to/file1.go
- path/to/file2.go

**Acceptance Criteria**:
- [ ] Criterion 1
- [ ] Criterion 2

**Estimated Lines**: 50

---

## Task 2: ...
```

### 工具
- **Cursor**: 手动拆分任务
- **Claude CLI**: 批量生成 tasks

### 质量门禁
参考：`../quality/quality-gates.md#gate-3`

- [ ] 每个task <50行
- [ ] 依赖关系清晰
- [ ] 验收标准明确

---

## Phase 4: Implement

### 目标
实施、测试、验证

### 输入
- Phase 3的tasks.md

### 活动
1. **生成 API 代码框架**
   ```bash
   goctl api go -api api/doc/{module}/{feature}.api -dir api/ --style=goZero
   ```
   - 生成 handler、types、routes 等基础代码
   - 不要手动修改 `types.go`（由 goctl 管理）

2. **生成 Model 代码**
   ```bash
   goctl model mysql ddl -src migrations/{module}/{table}.sql -dir model/{module}/{name}/ --style=goZero
   ```
   - 生成基础的 CRUD 代码
   - 如需自定义，在生成的文件基础上扩展

3. 逐个实施task (Logic 层业务逻辑)
4. 编写测试
5. Code Review
6. 验证功能

### 输出
- 完整的代码实现
- 单元测试
- 集成测试

### 工具
- **Cursor**: 快速编码和测试
- **Claude CLI**: 批量生成测试

### 质量门禁
参考：`../quality/quality-gates.md#gate-4`

- [ ] 编译通过
- [ ] 测试通过 (>80%)
- [ ] Lint无错误
- [ ] Review通过

---

## 阶段映射

| 阶段 | 说明 |
|------|------|
| Phase 0 | 上下文准备 |
| Phase 1 | 需求规范 |
| Phase 2 | 技术设计 |
| Phase 3 | 任务拆分 |
| Phase 4 | 实施验证 |

---

## 变更历史

| Version | Date | Changes |
|---------|------|---------|
| 2.0.0 | 2025-12-26 | 新增Phase 0，标准化5阶段 |
| 1.0.0 | 2025-12-24 | 初始4阶段版本 |

---

## 功能优化

对于已存在功能的优化，根据变更规模选择方案：

| 方案 | 规模 | 目录结构 |
|------|------|---------|
| 增量版本 | 大型 | `{name}-v2/` |
| 原地更新 | 小型 | 直接修改原spec |
| 优化子目录 | 中型 | `{name}/optimizations/` |

**详细参考**: `../workflow/phase-optimization.md`

---

**详细指南请参考：`../workflow/`目录**
