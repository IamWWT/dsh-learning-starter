# MANUAL — dsh-learning-starter 使用手册

## 1. 安装

```bash
scripts/install-dsh.sh                 # preset → $DSH_HOME/.agent-presets/learning/
scripts/install-dsh.sh --uninstall     # 卸载（保留备份）
```

## 2. 新建学习项目

```bash
scripts/init-learn.sh ~/learn/dba --subject 数据库
```

生成 AGENTS.md + profile 三件套 + materials/exercises/错题本/specs 目录。

## 3. 外部仓库学习（repo-study）

workspace 指向别人 git 仓库（如开源项目），学习模式按 repo-study skill 执行：

- 原仓库**只读**（read/git log/diff/fetch），绝不 write/edit/commit 原仓库文件；
- 学习进度/笔记/练习存 **sidecar 学习区**（默认仓库同级 `<仓库名>.learn/`）：progress.md / notes/ / exercises/ / baseline.txt / updates.md；
- 说「看下这项目更新了什么」→ 自动 fetch + 对比 baseline，列出新提交/变更文件，提示你学过哪些笔记受影响；
- git pull 由你自己执行（或明确授权），学习区与 git 完全隔离，永不冲突。

或用 init 生成学习区骨架：
```bash
scripts/init-learn.sh <学习区目录> --name <名> --repo <外部仓库路径>
```

## 4. 日常使用

- 首次：AI 完成画像问卷（profile.md §2）再开始。
- 学习中：讲→练→出题→错题本。
- 收尾：progress.md + session-log.md 更新。
- 多模态：语音 → 转写；视频 → 链接+顺序；图片 → 视觉+OCR。

## 4. 常见问题

| 问题 | 答案 |
|---|---|
| 画像放哪？ | 工作区 `profile/profile.md`（个人化不写框架） |
| 教学协议优先？ | 工作区教学协议 > 通用 teaching-method |
| 代理/源配置？ | 工作区 profile/ 环境备忘；国内源先 unset 代理 |
| 需要重启？ | 不需要，新会话生效 |
