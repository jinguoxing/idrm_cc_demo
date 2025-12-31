# Plan Prompt

请根据 IDRM 项目规范生成技术设计文档。

## 参考文档
- @.specify/memory/constitution.md
- @sdd_doc/spec/architecture/layered-architecture.md
- @sdd_doc/spec/architecture/dual-orm-pattern.md
- @sdd_doc/spec/workflow/phase2-design.md

## 要求
1. 遵循分层架构 (Handler → Logic → Model)
2. 选择 GORM 或 SQLx 并说明理由
3. 列出完整的文件结构
4. 定义 Model 接口
5. 绘制 Mermaid 序列图
6. 包含 DDL 和 Go Struct 定义
7. 说明 API Contract（go-zero .api 格式）

## 技术约束
- Functions MUST be < 50 lines
- MUST use Chinese comments
- Test coverage MUST be > 80%

## 输出格式
使用 `.specify/templates/plan-template.md` 模板格式
