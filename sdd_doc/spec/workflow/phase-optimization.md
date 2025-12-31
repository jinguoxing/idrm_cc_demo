# 功能优化工作流 (Feature Optimization)

> **Level**: SHOULD  
> **Version**: 1.0.0  
> **适用场景**: 对已存在功能进行优化、增强或重构

---

## 概述

当需要优化已存在的功能时，根据**变更规模**选择合适的方案：

| 方案 | 规模 | 目录结构 | 适用场景 |
|------|------|---------|----------|
| **A. 增量版本** | 大型 | `{name}-v2/` | 架构重构、大规模改动 |
| **B. 原地更新** | 小型 | 直接修改原spec | Bug修复、小功能调整 |
| **C. 优化子目录** | 中型 | `{name}/optimizations/` | 功能增强、性能优化 |

---

## 方案 A：增量版本

### 适用场景
- ✅ 架构级别重构
- ✅ 破坏性变更 (Breaking Changes)
- ✅ 需要保留原版本作为对照
- ✅ 变更代码量 > 200行

### 目录结构

```
specs/features/
├── tag-management/           # 原版本 v1 (保留不动)
│   ├── requirements.md
│   ├── design.md
│   └── tasks.md
└── tag-management-v2/        # 新版本 v2
    ├── requirements.md       # 描述变更需求
    ├── design.md             # 新架构设计
    ├── tasks.md
    └── tag-management-v2.api
```

### 工作流程

#### Phase 0: Context
```
1. 阅读原版本 specs/features/{name}/ 所有文档
2. 分析现有实现的问题和限制
3. 明确优化目标和范围
```

#### Phase 1: Specify (变更需求)
创建 `specs/features/{name}-v2/requirements.md`：

```markdown
# Requirements: {功能名} v2

## 版本信息
- **基于版本**: v1.0.0
- **目标版本**: v2.0.0
- **变更类型**: 重构/增强

## 变更背景
描述为什么需要 v2 版本

## 原版本问题
- 问题1: ...
- 问题2: ...

## 优化目标
- 目标1: ...
- 目标2: ...

## User Stories (新增/变更)
AS a ...
I WANT ...
SO THAT ...

## Acceptance Criteria (新增/变更)
WHEN ...
THE SYSTEM SHALL ...

## 兼容性考虑
- 向后兼容: 是/否
- 迁移方案: ...
```

#### Phase 2-4: 完整流程
按照标准 Phase 2-4 流程执行，在 `{name}-v2/` 目录下生成所有文档。

#### 代码生成
```bash
# API
goctl api go -api specs/features/{name}-v2/{name}-v2.api -dir api/ --style=goZero

# Model (如有表结构变更)
goctl model mysql ddl -src migrations/{module}/{table}_v2.sql -dir model/{module}/{name}/ --style=goZero
```

---

## 方案 B：原地更新

### 适用场景
- ✅ Bug 修复
- ✅ 小功能调整
- ✅ 性能微调
- ✅ 变更代码量 < 50行

### 目录结构

```
specs/features/tag-management/
├── requirements.md    # 直接修改，添加修订记录
├── design.md          # 直接修改
└── tasks.md           # 直接修改
```

### 工作流程

#### Step 1: 添加修订记录
在 `requirements.md` 头部添加：

```markdown
## Revision History
| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | 2025-12-01 | - | 初始版本 |
| **1.0.1** | **2025-12-30** | **-** | **修复标签名称验证** |
```

#### Step 2: 标记变更内容
使用 `<!-- v1.0.1 -->` 注释标记变更：

```markdown
## Acceptance Criteria

<!-- v1.0.1 新增 -->
### 标签名称验证
WHEN 用户创建标签时输入特殊字符
THE SYSTEM SHALL 返回400错误并提示"标签名称只能包含中英文和数字"
<!-- /v1.0.1 -->
```

#### Step 3: 简化 Phase 流程
```
Phase 1: 更新 requirements.md (仅变更部分)
Phase 2: 更新 design.md (仅变更部分)
Phase 3: 添加新 task 到 tasks.md
Phase 4: 实现并测试
```

#### Step 4: 提交
```bash
git commit -m "fix(tag): 修复标签名称验证 (v1.0.1)"
```

---

## 方案 C：优化子目录

### 适用场景
- ✅ 功能增强（如：新增批量操作）
- ✅ 性能优化
- ✅ 不影响原有功能的扩展
- ✅ 变更代码量 50-200行

### 目录结构

```
specs/features/tag-management/
├── requirements.md           # 原版本 (不修改)
├── design.md
├── tasks.md
└── optimizations/            # 优化目录
    └── batch-tagging/        # 具体优化项
        ├── requirements.md   # 优化需求
        ├── design.md         # 优化设计
        └── tasks.md
```

### 工作流程

#### Phase 0: Context
```
1. 阅读原版本 specs/features/{name}/ 文档
2. 确定优化范围不影响原有功能
3. 创建优化目录
```

```bash
mkdir -p specs/features/{name}/optimizations/{opt-name}
```

#### Phase 1: Specify (优化需求)
创建 `specs/features/{name}/optimizations/{opt-name}/requirements.md`：

```markdown
# Requirements: {优化名称}

## 优化信息
- **基于功能**: {原功能名}
- **优化类型**: 功能增强/性能优化/其他
- **预计影响**: 低/中/高

## 优化背景
描述为什么需要这个优化

## 优化目标
- 目标1: ...

## User Stories
### Story 1: 批量打标签
AS a 数据管理员
I WANT 一次为多个资源打上相同标签
SO THAT 我可以快速完成大批量数据分类

## Acceptance Criteria
WHEN 用户选择多个资源并提交批量打标签请求
THE SYSTEM SHALL 为所有选中资源添加指定标签

## 与原功能的关系
- 复用: Model层接口
- 新增: 批量Logic
- 扩展: Handler新增批量接口
```

#### Phase 2: Design
创建 `design.md`，引用原版本设计：

```markdown
# Design: 批量打标签

## 与原设计的关系
- 复用原有 Model 接口: `model/resource_catalog/tag/`
- 新增 Logic: `api/internal/logic/resource_catalog/tag/batchassigntaglogic.go`
- 新增 Handler: `api/internal/handler/resource_catalog/tag/batchassigntaghandler.go`

## 接口设计
在原有 `.api` 文件中新增：
\`\`\`api
@handler BatchAssignTag
post /resources/batch-tags (BatchAssignTagReq) returns (BatchAssignTagResp)
\`\`\`

## 序列图
...
```

#### Phase 3-4: 标准流程
按照标准流程执行任务拆分和实现。

#### 代码生成
```bash
# 更新原有 .api 文件后重新生成
goctl api go -api specs/features/{name}/{name}.api -dir api/ --style=goZero
```

---

## 方案选择决策树

```
开始
  │
  ├─ 是否涉及架构重构？
  │    ├─ 是 → 方案 A (增量版本)
  │    └─ 否 ↓
  │
  ├─ 变更代码量 < 50行？
  │    ├─ 是 → 方案 B (原地更新)
  │    └─ 否 ↓
  │
  └─ 是否为独立新功能？
       ├─ 是 → 方案 C (优化子目录)
       └─ 否 → 方案 B (原地更新)
```

---

## 质量门禁

### 所有方案通用
- [ ] 明确说明变更背景和目标
- [ ] 与原功能的关系清晰
- [ ] 兼容性影响评估
- [ ] 测试覆盖变更部分

### 方案 A 专用
- [ ] 原版本保持不变
- [ ] 迁移方案明确

### 方案 B 专用
- [ ] Revision History 更新
- [ ] 变更内容标记清晰

### 方案 C 专用
- [ ] 优化目录结构正确
- [ ] 与原设计的引用关系清晰

---

## AI 工具使用

### Speckit + Claude Code

**方案 A**:
```bash
speckit create feature {name}-v2
speckit generate requirements {name}-v2
speckit generate design {name}-v2
```

**方案 B**:
```text
请更新 specs/features/{name}/requirements.md
添加修订记录 v1.0.1，新增以下需求：
- {需求描述}
```

**方案 C**:
```text
请在 specs/features/{name}/optimizations/ 创建 {opt-name} 目录
并生成完整的 requirements.md 和 design.md
```

---

**参考**: [统一工作流](../core/workflow.md) | [Constitution](../constitution.md)
