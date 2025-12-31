# Code Review流程

> **Version**: 2.0.0

## Review类型

### 1. Self Review (自己)
**工具**: Cursor或Claude

**检查清单**：
- [ ] 代码符合规范
- [ ] 测试覆盖充分
- [ ] 注释完整
- [ ] 无明显bug

### 2. Peer Review (同事)
**工具**: GitHub PR

**参考**: `../coding-standards/code-review-checklist.md`

### 3. Tech Lead Review
**关注点**：
- 架构合规性
- 设计合理性
- 代码质量

## 自动Review

### CI/CD集成

```yaml
# .github/workflows/auto-review.yml
name: Auto Review
on: [pull_request]
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - name: Claude CLI Review
        run: |
          claude --files "sdd_doc/spec/**/*.md" \
                 --files "${{ github.event.pull_request.changed_files }}" \
                 "Review PR against specs" > review-report.md
```

## Review标准

### MUST Fix
- 违反架构规范
- 安全问题
- 严重bug

### SHOULD Fix
- 代码质量问题
- 性能问题
- 注释缺失

### COULD Fix
- 代码风格
- 命名优化
