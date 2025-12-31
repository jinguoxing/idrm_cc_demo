# Phase 1: Specify (需求规范)

> **Level**: MUST  
> **Version**: 2.1.0  
> **Aligned with**: GitHub Spec Kit

## 目标

定义清晰的**业务需求**，聚焦"做什么"和"为什么"，不涉及技术实现细节。

**核心原则**：
> "Focus on the what and why, not the tech stack"

## 输出模板

`specs/features/{name}/requirements.md`：

```markdown
# Requirements: {功能名}

## Overview
功能概述（1-2句话）

## User Stories
AS a {角色}
I WANT {功能}
SO THAT {价值/目标}

## Acceptance Criteria (EARS)
WHEN {条件}
THE SYSTEM SHALL {期望行为}

## Business Rules
业务规则和约束（非技术实现）

## Open Questions
待澄清的问题
```

## EARS Notation

**格式**：
```
WHEN [condition/event] THE SYSTEM SHALL [expected behavior]
```

**示例**：
```
WHEN 用户提交有效数据
THE SYSTEM SHALL 保存数据并返回成功状态

WHEN 用户提交无效数据
THE SYSTEM SHALL 返回验证错误信息
```

**详细参考**：[ears-notation-guide.md](ears-notation-guide.md) - 包含5种EARS模式、实战示例、常见错误、质量标准等完整说明

## Business Rules说明

**包含**：
- ✅ 业务规则（如：层级不超过3层）
- ✅ 数据约束（如：名称唯一）
- ✅ 业务流程限制（如：删除前检查依赖）

**不包含**：
- ❌ 技术架构（Handler/Logic/Model）
- ❌ 编码规范（函数行数、注释）
- ❌ ORM选择（GORM/SQLx）
- ❌ 数据库表结构

## AI 工具使用

- **Cursor**: @spec 对话生成
- **Claude CLI**: 批量生成

**Prompt 示例**：
```
@spec/workflow/phase1-specify.md

描述功能：{功能描述}

Phase 1: 生成Requirements
要求：
- 聚焦业务需求，不涉及技术实现
- 使用EARS notation
- 包含Business Rules
```

## 质量门禁 (Gate 1)

- [ ] 用户故事完整（AS/I WANT/SO THAT）
- [ ] 使用EARS notation
- [ ] Business Rules明确
- [ ] **不包含技术实现细节**

参考：`../quality/quality-gates.md#gate-1`

---

## ⚠️ 人工检查点

> **AI MUST STOP HERE**

完成 Phase 1 后：
1. 向用户展示生成的 `requirements.md` 内容
2. 等待用户审批后再继续 Phase 2
3. **禁止自动进入 Phase 2**

---

## 下一步
→ Phase 2: Design (需用户确认)
