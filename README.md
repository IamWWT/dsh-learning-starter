# dsh-learning-starter — 学习模式框架（DSH）

> 通用学习教练 Agent 框架。与 dsh-engineering-starter / dsh-research-starter 同族：DSH 专属 preset + 随包 skills + 一键安装，通用化、无机器路径、无个人画像（画像归工作区）。

## 快速开始

```bash
scripts/install-dsh.sh                    # 装 preset → $DSH_HOME/.agent-presets/learning/
scripts/init-learn.sh <目录> --subject dba   # 生成学习项目骨架（可选）
# DSH 新会话 → 选「学习模式」→ workspace 指向项目 → 开始学习
```

## 设计要点

- **外部仓库学习**（repo-study）：学别人的 GitHub 项目时原仓库只读，学习进度/笔记存 sidecar 学习区，git pull 不覆盖，自动检测上游更新并提示重看。
- **AI 讲你答**：讲解 + 提问 + 确认；术语先定义；答对理由错也纠正。
- **因果链**：现象→问题→原理→例外；每个数字给公式，每条规则讲为什么。
- **记忆补偿法**：推理补偿记忆、间隔复习、词→画面映射、去重速查表。
- **输出式学习**：每节出题，收尾更新进度 + 错题本。
- **画像与进度三件套**：profile/{profile,progress,session-log}.md，工作区持有，框架不携带个人数据。

## License

Apache-2.0
