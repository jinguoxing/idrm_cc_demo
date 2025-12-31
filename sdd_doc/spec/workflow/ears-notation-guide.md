# EARS Notation 详解指南

> **Level**: SHOULD  
> **Version**: 2.1.0  
> **Purpose**: EARS (Easy Approach to Requirements Syntax) 完整参考指南

## 📚 什么是 EARS？

**EARS** = **E**asy **A**pproach to **R**equirements **S**yntax

EARS 是一种结构化的需求编写方法，由英国罗罗公司（Rolls-Royce）开发，专门用于编写清晰、可测试的需求规范。

## 💡 为什么使用 EARS？

### 传统需求描述的问题

```markdown
❌ "系统应该能够创建分类"
   问题：什么时候创建？什么条件下？如何验证？

❌ "用户可以查询数据"
   问题：查询什么数据？返回什么格式？失败了怎么办？
```

### EARS 的优势

- ✅ **清晰度**：明确触发条件和期望行为
- ✅ **可测试性**：每条 EARS 都可以直接转化为测试用例
- ✅ **完整性**：覆盖正常、异常、边界所有场景
- ✅ **无歧义**：减少理解偏差，AI 和人类都能准确理解

---

## 📝 EARS 五种模式

### 1️⃣ Ubiquitous（普遍性）

**适用于**：始终成立的需求

**格式**：
```
THE SYSTEM SHALL [行为]
```

**示例**：
```markdown
THE SYSTEM SHALL 记录所有API调用日志

THE SYSTEM SHALL 使用UTF-8编码存储数据

THE SYSTEM SHALL 在每次数据修改时更新updated_at字段
```

---

### 2️⃣ Event-driven（事件驱动）⭐ 最常用

**适用于**：在特定条件/事件发生时的行为

**格式**：
```
WHEN [事件/条件]
THE SYSTEM SHALL [行为]
```

**示例**：
```markdown
WHEN 用户提交有效的分类创建请求
THE SYSTEM SHALL 保存分类到数据库并返回201状态码和分类ID

WHEN 用户提交的分类名称为空
THE SYSTEM SHALL 返回400错误和"名称不能为空"的错误信息

WHEN 用户查询不存在的资源ID
THE SYSTEM SHALL 返回404错误和"资源不存在"的提示
```

---

### 3️⃣ State-driven（状态驱动）

**适用于**：在特定系统状态下的持续行为

**格式**：
```
WHILE [状态条件]
THE SYSTEM SHALL [行为]
```

**示例**：
```markdown
WHILE 用户处于登录状态
THE SYSTEM SHALL 在每次API请求时验证token有效性

WHILE 数据库连接处于断开状态
THE SYSTEM SHALL 每30秒尝试重新连接

WHILE 系统处于维护模式
THE SYSTEM SHALL 对所有请求返回503状态码
```

---

### 4️⃣ Unwanted behavior（不期望行为）

**适用于**：系统应该避免或防御的行为

**格式**：
```
IF [不期望的条件]
THEN THE SYSTEM SHALL [保护性行为]
```

**示例**：
```markdown
IF 用户连续3次输入错误密码
THEN THE SYSTEM SHALL 锁定账户15分钟

IF 接收到的JSON数据格式无效
THEN THE SYSTEM SHALL 返回400错误并拒绝处理

IF 检测到SQL注入攻击
THEN THE SYSTEM SHALL 拒绝请求并记录安全日志
```

---

### 5️⃣ Optional features（可选特性）

**适用于**：可配置的功能

**格式**：
```
WHERE [配置条件]
THE SYSTEM SHALL [行为]
```

**示例**：
```markdown
WHERE 管理员启用了审计日志功能
THE SYSTEM SHALL 记录所有数据修改操作

WHERE 部署环境为生产环境
THE SYSTEM SHALL 启用SSL加密

WHERE 用户启用了邮件通知
THE SYSTEM SHALL 在任务完成时发送邮件
```

---

## 🎨 完整实战示例

### 示例：创建资源分类

#### ✅ 正常流程

```markdown
WHEN 用户提交有效的分类创建请求
THE SYSTEM SHALL 保存分类到数据库并返回201状态码和分类ID

WHEN 用户提交的分类数据包含name、code、parent_id
THE SYSTEM SHALL 验证name长度1-50字符，code符合编码规范[a-z0-9_-]

WHEN 分类创建成功
THE SYSTEM SHALL 返回包含id、name、code、parent_id、created_at的JSON对象
```

#### ❌ 异常流程

```markdown
WHEN 用户提交的分类名称为空
THE SYSTEM SHALL 返回400错误和"名称不能为空"的错误信息

WHEN 用户提交的分类名称与已存在分类重复
THE SYSTEM SHALL 返回409错误和"分类名称已存在"的错误信息

WHEN 用户提交的parent_id不存在
THE SYSTEM SHALL 返回404错误和"父分类不存在"的错误信息

WHEN 用户提交的编码格式不符合规范
THE SYSTEM SHALL 返回400错误和"编码只能包含小写字母、数字、下划线和连字符"的错误信息
```

#### ⚠️ 边界情况

```markdown
WHEN 用户创建的分类层级超过3层
THE SYSTEM SHALL 返回400错误和"分类层级不能超过3层"的错误信息

WHEN 用户提交的分类名称长度超过50字符
THE SYSTEM SHALL 返回400错误和"名称长度不能超过50字符"的错误信息

WHEN 同一用户在1秒内提交10次以上创建请求
THE SYSTEM SHALL 返回429错误和"请求过于频繁"的提示
```

#### 🔒 安全控制

```markdown
IF 用户未登录
THEN THE SYSTEM SHALL 返回401错误和"请先登录"的提示

IF 用户没有分类管理权限
THEN THE SYSTEM SHALL 返回403错误和"权限不足"的提示
```

#### 📊 审计日志（可选）

```markdown
WHERE 管理员启用了审计日志功能
THE SYSTEM SHALL 记录分类创建的操作人、时间、操作内容

THE SYSTEM SHALL 记录所有分类创建操作到audit_log表
```

---

## 📋 EARS 编写清单

### 必须覆盖的场景 ✅

#### 正常流程（Happy Path）
- [ ] 所有主要业务流程
- [ ] 标准输入产生的标准输出
- [ ] 成功的状态转换

#### 参数验证
- [ ] 必填参数为空
- [ ] 参数格式错误
- [ ] 参数超出范围
- [ ] 参数类型不匹配

#### 业务规则
- [ ] 违反唯一性约束
- [ ] 违反层级限制
- [ ] 违反状态转换规则
- [ ] 违反业务逻辑

#### 权限和安全
- [ ] 未登录访问
- [ ] 权限不足
- [ ] Token过期/无效

#### 资源状态
- [ ] 资源不存在
- [ ] 资源已被删除
- [ ] 资源状态不匹配

### 应该考虑的场景 ⚡

- [ ] 并发冲突
- [ ] 网络超时
- [ ] 依赖服务不可用
- [ ] 数据库连接失败

### 可选的场景 💡

- [ ] 性能要求（如响应时间 < 200ms）
- [ ] 容量限制（如单次查询最多返回1000条）
- [ ] 审计日志（可配置）

---

## ⚠️ 常见错误与修正

### ❌ 错误 1：没有明确触发条件

**错误写法**：
```markdown
THE SYSTEM SHALL 保存分类
```
**问题**：什么时候保存？什么条件触发？

**✅ 正确写法**：
```markdown
WHEN 用户提交有效的分类创建请求
THE SYSTEM SHALL 保存分类到数据库并返回分类ID
```

---

### ❌ 错误 2：行为不够具体

**错误写法**：
```markdown
WHEN 用户提交无效数据
THE SYSTEM SHALL 报错
```
**问题**：什么是无效？报什么错？怎么报错？

**✅ 正确写法**：
```markdown
WHEN 用户提交的分类名称为空
THE SYSTEM SHALL 返回400状态码和JSON格式的错误信息
{
  "code": "INVALID_PARAM",
  "message": "名称不能为空",
  "field": "name"
}
```

---

### ❌ 错误 3：包含技术实现细节

**错误写法**（Phase 1不应该包含这些）：
```markdown
WHEN 用户点击保存按钮
THE SYSTEM SHALL 调用CreateCategory API，使用GORM插入MySQL数据库的categories表，
并使用Redis缓存结果
```
**问题**：过于技术化，这是实现细节，应该在Phase 2

**✅ 正确写法（Phase 1）**：
```markdown
WHEN 用户提交分类创建请求
THE SYSTEM SHALL 保存分类信息并返回分类ID
```

---

### ❌ 错误 4：多个行为混在一起

**错误写法**：
```markdown
WHEN 用户提交创建请求
THE SYSTEM SHALL 验证数据、保存到数据库、发送通知、记录日志并返回结果
```
**问题**：太复杂，不易测试

**✅ 正确写法（拆分成多条）**：
```markdown
WHEN 用户提交分类创建请求
THE SYSTEM SHALL 验证所有必填字段不为空

WHEN 用户提交的分类数据通过验证
THE SYSTEM SHALL 保存分类到数据库

WHEN 分类创建成功
THE SYSTEM SHALL 返回201状态码和分类ID

THE SYSTEM SHALL 记录所有分类创建操作的审计日志
```

---

### ❌ 错误 5：使用模糊的量词

**错误写法**：
```markdown
WHEN 用户提交的名称太长
THE SYSTEM SHALL 返回错误
```
**问题**："太长"不明确

**✅ 正确写法**：
```markdown
WHEN 用户提交的分类名称长度超过50字符
THE SYSTEM SHALL 返回400错误和"名称长度不能超过50字符"的错误信息
```

---

## 🎯 EARS 与测试用例的对应

每条 EARS 都可以直接转化为测试用例：

### EARS 需求
```markdown
WHEN 用户提交的分类名称为空
THE SYSTEM SHALL 返回400错误和"名称不能为空"的错误信息
```

### 对应测试用例
```go
func TestCreateCategory_EmptyName(t *testing.T) {
    // Arrange - 准备测试数据（对应WHEN条件）
    req := &CreateCategoryRequest{
        Name: "",  // 触发条件：名称为空
        Code: "test",
    }
    
    // Act - 执行操作
    resp, err := CreateCategory(req)
    
    // Assert - 验证期望行为（对应THE SYSTEM SHALL）
    assert.Equal(t, 400, resp.StatusCode)          // 期望：400错误
    assert.Contains(t, resp.Message, "名称不能为空")  // 期望：特定错误信息
}
```

---

## 💡 编写技巧

### 1. 从用户视角出发

**✅ 推荐**：
```markdown
WHEN 用户点击提交按钮
WHEN 用户查询订单列表
WHEN 用户删除分类
```

**❌ 避免**：
```markdown
WHEN 系统接收到POST请求
WHEN SELECT语句执行
WHEN DeleteCategory方法被调用
```

---

### 2. 使用业务语言，避免技术术语

**✅ 推荐**：
```markdown
WHEN 用户查询不存在的订单
WHEN 分类名称重复
WHEN 超过最大层级限制
```

**❌ 避免**：
```markdown
WHEN SELECT语句返回空结果集
WHEN UNIQUE约束冲突
WHEN level字段 > 3
```

---

### 3. 一条 EARS 一个场景

**✅ 推荐**（每条独立）：
```markdown
WHEN 用户提交的名称为空
THE SYSTEM SHALL 返回400错误

WHEN 用户提交的名称过长
THE SYSTEM SHALL 返回400错误

WHEN 用户提交的编码格式错误
THE SYSTEM SHALL 返回400错误
```

**❌ 避免**（混在一起）：
```markdown
WHEN 用户提交的名称为空或过长或编码格式错误
THE SYSTEM SHALL 返回400错误
```

---

### 4. 使用具体的值和范围

**✅ 推荐**：
```markdown
名称长度1-50字符
层级不超过3层
响应时间 < 200ms
```

**❌ 避免**：
```markdown
名称不能太长
层级不能太深
响应要快
```

---

### 5. 明确错误信息

**✅ 推荐**：
```markdown
THE SYSTEM SHALL 返回400错误和"名称不能为空"的错误信息
THE SYSTEM SHALL 返回404错误和"资源不存在"的提示
```

**❌ 避免**：
```markdown
THE SYSTEM SHALL 返回错误
THE SYSTEM SHALL 提示用户
```

---

## 📊 EARS 覆盖度检查

### 自检清单

完成 EARS 编写后，使用此清单验证覆盖度：

```markdown
## 正常流程
- [ ] 主要业务流程的每一步都有EARS
- [ ] 所有成功状态的返回都有明确描述
- [ ] 数据转换规则已明确

## 参数验证
- [ ] 每个输入参数的验证规则都有覆盖
- [ ] 必填、可选字段已明确
- [ ] 数据类型、格式、范围已指定

## 异常处理
- [ ] 每种错误情况都有对应的EARS
- [ ] 错误码和错误信息已明确
- [ ] 错误响应格式已定义

## 边界条件
- [ ] 空值、null的处理
- [ ] 最大最小值的限制
- [ ] 特殊字符的处理

## 安全性
- [ ] 认证失败的处理
- [ ] 授权不足的处理
- [ ] 恶意输入的防御

## 性能和可用性（可选）
- [ ] 性能要求（如有）
- [ ] 并发处理（如有）
- [ ] 限流策略（如有）
```

---

## 🔧 AI 辅助生成 EARS

### Cursor 示例

```
@spec/workflow/ears-notation-guide.md

功能：创建资源分类

Phase 1: 请生成Acceptance Criteria，使用EARS notation

要求：
1. 覆盖正常流程（Happy Path）
2. 覆盖所有参数验证（name, code, parent_id）
3. 覆盖业务规则（层级限制、唯一性）
4. 覆盖异常情况（4xx, 5xx错误）
5. 每条EARS必须可测试
6. 不包含技术实现细节

示例格式参考：
WHEN 用户提交有效的分类创建请求
THE SYSTEM SHALL 保存分类并返回201状态码和分类ID
```

---

## 📚 参考资源

### 项目内文档
- `phase1-specify.md` - Phase 1 规范概览
- `../quality/quality-gates.md#gate-1` - Gate 1 检查标准
- `../../ai-guide-v2/03-workflow/phase1-详细操作.md` - 详细操作指南

### 外部资源
- [EARS 官方介绍](https://www.iaria.org/conferences2012/filesICCGI12/ICCGI_2012_Tutorial_Terzakis.pdf)
- GitHub Spec Kit - Requirements Best Practices

---

## 💯 质量标准

一个好的 EARS 文档应该：

1. **完整性** - 覆盖所有主要场景（正常、异常、边界）
2. **清晰性** - 每条 EARS 都明确、无歧义
3. **可测试性** - 每条 EARS 都可以直接转化为测试用例
4. **业务性** - 使用业务语言，不包含技术实现
5. **一致性** - 格式统一，错误信息格式一致

---

**EARS 是需求规范的基石，写好 EARS，开发一路绿灯！** 📝
