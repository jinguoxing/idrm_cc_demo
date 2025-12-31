# 需求描述格式指南

> **Version**: 1.0.0  
> **Last Updated**: 2025-12-31  
> **目的**: 帮助团队选择合适的需求描述格式

---

## 概述

在需求阶段（Phase 1: Specify），有三种主流的需求描述格式：

| 格式 | 全称 | 来源 |
|------|------|------|
| **SDD** | Spec-Driven Development | GitHub Spec Kit |
| **EARS** | Easy Approach to Requirements Syntax | Rolls-Royce |
| **Gherkin** | Given/When/Then | BDD (Cucumber) |

---

## 格式对比

### 1. SDD (User Stories)

**来源**: GitHub Spec Kit

**格式**:
```
AS a [角色]
I WANT [功能]
SO THAT [价值/目标]
```

**适用场景**:
- ✅ 功能概述和业务目标定义
- ✅ 与产品经理沟通
- ✅ 快速描述"谁需要什么"

**示例**:
```
AS a 数据管理员
I WANT 创建资源分类
SO THAT 可以组织和管理数据资源
```

---

### 2. EARS (Acceptance Criteria)

**来源**: Rolls-Royce

**格式**:
```
WHEN [条件/事件]
THE SYSTEM SHALL [期望行为]
```

**五种模式**:
| 模式 | 格式 | 适用场景 |
|------|------|----------|
| Ubiquitous | THE SYSTEM SHALL... | 始终成立的需求 |
| Event-driven | WHEN...THE SYSTEM SHALL... | 特定事件触发 |
| State-driven | WHILE...THE SYSTEM SHALL... | 特定状态下 |
| Unwanted | IF...THEN THE SYSTEM SHALL... | 防御性行为 |
| Optional | WHERE...THE SYSTEM SHALL... | 可配置功能 |

**适用场景**:
- ✅ 定义精确的验收标准
- ✅ 系统行为规范
- ✅ 可直接转化为测试用例

**示例**:
```
WHEN 用户提交有效的分类创建请求
THE SYSTEM SHALL 保存分类并返回 201 状态码

WHEN 用户提交的分类名称为空
THE SYSTEM SHALL 返回 400 错误和"名称不能为空"的错误信息
```

---

### 3. Gherkin (Given/When/Then)

**来源**: BDD (Behavior-Driven Development)

**格式**:
```
GIVEN [前置条件/上下文]
WHEN [动作/事件]
THEN [期望结果]
```

**适用场景**:
- ✅ 描述完整的用户场景
- ✅ 端到端测试用例
- ✅ 需要明确前置条件的场景
- ✅ 与 Cucumber 等 BDD 工具集成

**示例**:
```
Feature: 创建资源分类

Scenario: 成功创建分类
  GIVEN 用户已登录且拥有管理员权限
  AND 数据库中不存在同名分类
  WHEN 用户提交分类创建请求，名称为"数据分析"
  THEN 系统应保存分类到数据库
  AND 返回 201 状态码
  AND 响应包含新创建的分类 ID

Scenario: 重复名称创建失败
  GIVEN 用户已登录
  AND 数据库中已存在名为"数据分析"的分类
  WHEN 用户提交分类创建请求，名称为"数据分析"
  THEN 系统应返回 409 错误
  AND 错误信息包含"分类名称已存在"
```

---

## 使用场景推荐

| 场景 | 推荐格式 | 原因 |
|------|----------|------|
| 功能概述 | **SDD (User Stories)** | 快速表达业务目标 |
| 验收标准 | **EARS** | 简洁、可测试、AI 友好 |
| 复杂场景 | **Gherkin** | 完整上下文，端到端测试 |
| 异常处理 | **EARS** | 清晰的条件-行为映射 |
| BDD 测试 | **Gherkin** | 与测试框架集成 |

---

## IDRM 项目推荐

### 默认组合

```markdown
## User Stories (SDD)
AS a 数据管理员
I WANT 创建资源分类
SO THAT 可以组织数据资源

## Acceptance Criteria (EARS)
WHEN 用户提交有效的分类创建请求
THE SYSTEM SHALL 保存分类并返回 201 状态码

WHEN 用户提交的分类名称为空
THE SYSTEM SHALL 返回 400 错误

## Scenarios (Gherkin) - 可选
GIVEN 用户已登录且拥有管理员权限
WHEN 用户提交分类创建请求
THEN 系统应保存分类
```

### 何时使用 Gherkin

- 需要明确**前置条件**（如：用户已登录、数据库有特定数据）
- 需要描述**多步骤流程**
- 需要与 **BDD 测试工具**集成
- 场景涉及**多个系统交互**

### 何时使用 EARS

- 快速定义**单一行为**
- 标准的 CRUD 操作
- AI 生成代码的主要依据

---

## 格式转换

### Gherkin → EARS

```
Gherkin:
GIVEN 用户已登录
WHEN 用户提交空名称的分类创建请求
THEN 系统应返回 400 错误

EARS:
WHEN 已登录用户提交空名称的分类创建请求
THE SYSTEM SHALL 返回 400 错误
```

### EARS → Gherkin

```
EARS:
WHEN 用户提交有效的分类创建请求
THE SYSTEM SHALL 保存分类并返回 201 状态码

Gherkin:
GIVEN 用户已登录且拥有创建权限
AND 分类名称不重复
WHEN 用户提交有效的分类创建请求
THEN 系统应保存分类到数据库
AND 返回 201 状态码
```

---

## 参考

- [EARS Notation 详解](./ears-notation-guide.md)
- [Phase 1: Specify](./phase1-specify.md)
- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [Gherkin Reference](https://cucumber.io/docs/gherkin/reference/)

---

**选择合适的格式，清晰表达需求，让 AI 更好地理解你的意图！**
