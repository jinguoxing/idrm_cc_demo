# 质量门禁

> **Version**: 2.0.0

## Gate 1: Specify阶段

**验收标准**：
- [ ] 用户故事完整
- [ ] EARS notation格式正确
- [ ] 技术约束明确

## Gate 2: Design阶段

**验收标准**：
- [ ] 符合分层架构
- [ ] 文件清单完整
- [ ] 接口定义清晰

## Gate 3: Tasks阶段

**验收标准**：
- [ ] 每个task <50行
- [ ] 依赖关系清晰
- [ ] 验收标准明确

## Gate 4: Implement阶段

**验收标准**：
- [ ] 编译通过 (`go build ./...`)
- [ ] 测试通过 (`go test -cover ./...` >80%)
- [ ] Lint无错误 (`golangci-lint run`)
- [ ] Review通过

## CI/CD集成

```yaml
# .github/workflows/quality-gate.yml
on: [pull_request]
jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - name: Build
        run: go build ./...
      - name: Test
        run: go test -cover ./...
      - name: Lint
        run: golangci-lint run
```
