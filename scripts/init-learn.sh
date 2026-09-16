#!/usr/bin/env bash
# ============================================================================
# init-learn.sh — 生成一个新的学习项目骨架
# 用法: scripts/init-learn.sh <目标目录> [--name "名称"] [--subject "学科"]
# 生成: AGENTS.md / profile/{profile.md,progress.md,session-log.md} / templates/ /
#       学习区（sync 按画像）/ 错题本
# 自包含：任何 Agent 打开即用。
# ============================================================================
set -euo pipefail
TARGET="${1:-}"; [ -n "$TARGET" ] || { echo "用法: scripts/init-learn.sh <目标目录> [--name 名称] [--subject 学科] [--repo 外部仓库路径]" >&2; exit 1; }
NAME="$(basename "$(realpath -m "$TARGET")")"; SUBJECT=""; REPO=""
[ "$#" -ge 3 ] && [ "$2" = "--name" ] && NAME="$3"
[ "$#" -ge 5 ] && [ "$4" = "--subject" ] && SUBJECT="$5"
[ "$#" -ge 7 ] && [ "$6" = "--repo" ] && REPO="$7"
[ -d "$TARGET" ] && [ -n "$(ls -A "$TARGET")" ] && { echo "错误: 目标目录非空" >&2; exit 1; }
mkdir -p "$TARGET"/{profile,templates,materials,exercises,错题本,specs}

cat > "$TARGET/AGENTS.md" <<AG
# AGENTS.md — 学习项目（$NAME）

> 学习模式工作区契约。本文件是 agent 行为唯一真源；profile/ 是学习者画像。

## 1. 会话开场
1. 先读 profile/progress.md（上次进度 + 复习计划）与 profile/profile.md（画像）。
2. 先复习上次错题本抽查项，再进新内容。

## 2. 教学原则（随包 skill teaching-method）
AI 讲你答 / 因果链 / 出处强制 / 输出式学习 / 反馈闭环；记忆弱则启用 memory-compensation。

## 3. 材料与产出
| 内容 | 放哪 |
|---|---|
| 学习材料（文档/转写/截图） | materials/ |
| 练习与测验 | exercises/ |
| 错题与复盘 | 错题本/ |
| 考试/真题资产 | specs/ |
| 画像/进度/会话记录 | profile/ |

## 4. 收尾
更新 profile/progress.md（学了什么/卡在哪/下轮调整）、错题本；git commit（中文信息）。
AG

cat > "$TARGET/profile/profile.md" <<PF
# 学习画像（Learning Profile）

> AI 助教对学习者的持续认识；每次会话结束更新。

## 1 基本信息
| 项目 | 记录 |
|---|---|
| 语言偏好 | 中文 |
| 学习主题 | ${SUBJECT:-（待填）} |
| 知识自评 | （待填） |
| 目标/考试 | （待填：考什么、目标、日期） |
| 可投入时间 | （待填） |

## 2 认知画像（第一次会话由 AI 施测）
- 记忆 vs 推理：直接背 or 先懂再记？
- 领域熟悉度自评：
- 学习偏好（图/文/例子/公式）：

## 3 风格信号（从行为推断，持续追加）
| 信号 | 推断 | 教学应对 |
|---|---|---|
| （待填） | （待填） | （待填） |
PF

cat > "$TARGET/profile/progress.md" <<PG
# 学习进度 — $NAME

## 上次会话
- 学了什么：
- 卡在哪：
- 待复习：

## 进行中
| 模块 | 状态 | 复习计划 | 下一步 |
|---|---|---|---|
| （暂无） | — | — | — |
PG

cat > "$TARGET/profile/session-log.md" <<SL
# 会话记录

| 日期 | 内容 | 测验结果 | 新画像信息 |
|---|---|---|---|
| （暂无） | — | — | — |
SL

# ---- 外部仓库学习模式（--repo）----
if [ -n "$REPO" ]; then
  mkdir -p "$TARGET"/{notes,exercises}
  {
    echo "# Repo Study 学习区"
    echo
    echo "学习目标仓库: $REPO"
    echo "铁律: 原仓库只读，本学习区所有产物不进入原仓库。"
  } > "$TARGET/notes/README.md"
  cat > "$TARGET/baseline.txt" <<BL
（首次进入时由学习会话写入原仓库当前 HEAD commit hash）
BL
  cat > "$TARGET/updates.md" <<UP
# 上游更新记录

| 时间 | 新提交 | 变更文件 | 影响笔记 | 建议动作 |
|---|---|---|---|---|
| （暂无） | — | — | — | — |
UP
  echo "  - 外部仓库学习模式：原仓库只读，进度/笔记存本学习区（repo-study skill）。"
fi

echo ""
echo "✅ 学习项目初始化完成: $TARGET"
echo "  - workspace 指向该目录，DSH 选「学习模式」即可开始。"
echo "  - 首次会话：AI 先完成画像（profile/profile.md 第 2 节）再开始教学。"
