---
name: repo-study
description: 从外部 git 仓库（GitHub 他人项目/开源库）学习：原仓库只读不污染，学习进度/笔记存 sidecar 学习区，git pull 不覆盖，能检测上游更新并提示重看。
---

# Repo study（外部仓库学习）

场景：workspace 指向一个**别人的 git 仓库**（开源项目/他人代码），你想读懂它并持续跟踪学习。

## 1. 铁律：原仓库只读

- ✅ 允许：`read` / `grep` / `git log` / `git show` / `git diff` / `git blame` / `git fetch`（只读网络操作）
- ❌ 禁止：对原仓库任何文件 `write` / `edit`；`git commit` / `git push` / `git reset --hard` / `git checkout 覆盖`；新建文件进原仓库目录
- 除非用户显式要求改动并确认，否则**不碰原仓库一个字节**。

## 2. sidecar 学习区（学习产物全放这里）

位置由会话开始时与用户确认（默认建议仓库同级的 `<仓库名>.learn/` 兄弟目录，或用户学习根目录；从 `profile/` 配置读取）。布局：

```
<sidecar>/
  profile.md        # 学习画像（复用学习模式画像）
  progress.md       # 进度：学了哪些模块/文件、理解程度、复习计划
  notes/            # 笔记：按模块组织，每篇引用原文件「路径:行号」，写自己的理解（禁止大段复制原文）
  exercises/        # 练习：针对理解出的自测题
  baseline.txt      # 上次学习时的 commit hash（一行）
  updates.md        # 上游更新检测记录（时间 + 新提交 + 变更文件 + 影响哪些笔记）
```

## 3. 首次进入（初始化 sidecar）

1. 确认原仓库：`git remote -v` / `git log -1 --format=%H`（记录当前 commit）。
2. 创建 sidecar（用户确认位置）；写入 `baseline.txt` = 当前 HEAD；`progress.md` 初始。
3. 询问学习目标（"想搞懂哪部分？"），据此定模块顺序，再开始。

## 4. 更新检测（用户说"看下这项目更新了什么"或每次会话开场）

```bash
git fetch origin                    # 只读，不改工作区
git log --oneline $(cat baseline.txt)..origin/HEAD   # 自上次学习以来的新提交
git diff --stat $(cat baseline.txt)..origin/HEAD     # 变更文件清单
```

1. 列出新提交（作者/时间/消息）与变更文件；
2. **关联笔记**：检查变更文件路径是否在 `notes/` 里被引用 → "你学过的 `<模块>` 有新变化，建议重看"；
3. 汇总写进 `updates.md`（时间 + 变更 + 影响笔记 + 建议动作）；
4. **更新 baseline**：经用户确认后将 `baseline.txt` 改为 `origin/HEAD` 的 hash（防止下次重复报告）。

## 5. 学习循环

1. 按模块精读源码（结构 → 关键文件 → 调用链 → 设计意图）；
2. 笔记写 sidecar（自己的理解 + 原文引用 路径:行号）；讲不清的标 [待核实]；
3. 每模块结束：出 2-3 题自测（exercises/）+ 更新 progress.md；
4. 会话收尾：progress.md + 检查是否有上游更新 + 记 updates.md。

## 6. 边界

- 不修改上游代码除非用户明确要求（此时切换到工程模式走完整流程）。
- 笔记禁止整段复制源码（版权 + 理解无益），只留自己的提炼和引用。
- sidecar 也是 git 仓库的话按普通学习项目管理；不是也不强求。
