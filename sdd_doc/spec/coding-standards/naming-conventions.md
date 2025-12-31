# 命名规范

> **Version**: 3.0.0  
> **Last Updated**: 2025-12-31

---

## 文件命名

### Handler/Logic 文件（go_zero 风格）

```
{action}_{resource}_handler.go
{action}_{resource}_logic.go

示例:
create_category_handler.go
get_category_logic.go
list_category_logic.go
```

### Model 文件

| 文件 | 用途 |
|------|------|
| `interface.go` | 接口定义 |
| `types.go` | 数据结构 |
| `vars.go` | 常量和错误 |
| `factory.go` | ORM 工厂 |
| `gorm_dao.go` | GORM 实现 |
| `sqlx_model.go` | SQLx 实现 |

---

## 包命名

| 规则 | 示例 |
|------|------|
| 全小写 | `category`, `middleware` |
| 简短有意义 | `validator`, `response` |
| ❌ 避免泛化 | ~~utils~~, ~~common~~ |

---

## 类型命名

| 类型 | 规范 | 示例 |
|------|------|------|
| 结构体 | PascalCase | `CategoryModel`, `UserInfo` |
| 接口 | PascalCase | `Model`, `Repository` |
| 缩写 | 全大写 | `HTTPClient`, `UserID` |

---

## 函数命名

| 类型 | 规范 | 示例 |
|------|------|------|
| 公开函数 | PascalCase | `NewCategoryModel()`, `CreateCategory()` |
| 私有函数 | camelCase | `validateInput()`, `buildQuery()` |

---

## 变量命名

| 类型 | 规范 | 示例 |
|------|------|------|
| 局部变量 | camelCase | `category`, `userId` |
| 错误变量 | Err 前缀 | `ErrNotFound`, `ErrInvalidInput` |
| 常量 | PascalCase | `MaxRetry`, `DefaultTimeout` |

---

## 数据库命名

| 类型 | 规范 | 示例 |
|------|------|------|
| 表名 | 复数 + 下划线 | `categories`, `user_profiles` |
| 字段名 | 下划线 | `category_name`, `created_at` |

---

## API 路径

```
/api/v1/catalog/categories
/api/v1/catalog/categories/:id
```

规则：复数、小写、短横线分隔词

---

**Version**: 3.0.0
