# GitHub 使い方簡単マニュアル
**描画方法**: このチートシートのMermaidコードを 
以下のサイトとの右上のボックスにコピペして(Render Light) or (Render Dark)ボタンを押すと図が表示されます。
[gr-mm-render](https://goodrelax.github.io/gr_miscellaneous/gr-mm-render.html) 

このマニュアルは、Gitの基礎から実践的なGitHub運用まで、段階的に学べる包括的なガイドです。

---

## 目次

0. [はじめに](#0-はじめに)
1. [初期設定](#1-初期設定)
2. [リポジトリ用語](#2-リポジトリ用語)
3. [基礎の基礎](#3-基礎の基礎)
4. [通常作業（取得から提出まで）](#4-通常作業取得から提出まで)
5. [修正・取り消し](#5-修正取り消し)
6. [ブランチ操作](#6-ブランチ操作)
7. [発展](#7-発展)
8. [デバッグ・調査](#8-デバッグ調査)
9. [高度なトピック](#9-高度なトピック)
10. [GitHub/GitLab ワークフロー](#10-githubgitlab-ワークフロー)
11. [チーム開発ベストプラクティス](#11-チーム開発ベストプラクティス)
12. [よくあるワークフロー](#12-よくあるワークフロー)
13. [トラブルシューティング](#13-トラブルシューティング)
14. [まとめ](#14-まとめ)
15. [付録](#15-付録)

---

## 0. はじめに

### Gitとは

Gitは**分散型バージョン管理システム**です。ファイルの変更履歴を記録し、複数人での共同作業を可能にします。

**主な特徴：**
- ファイルの変更履歴を完全に保存
- 過去の任意の時点に戻れる
- 複数人が同時に作業できる
- ローカルで完結する作業が可能

**GitHubとの違い：**
- **Git**: バージョン管理システム（ソフトウェア）
- **GitHub**: Gitリポジトリをホスティングするサービス（Webサービス）

### このガイドの使い方

- **★★★**: 毎日使う重要コマンド
- **★★**: 週に1回程度使う
- **★**: 月に1回程度、または特定状況で使う

**学習の進め方：**
1. まず「基礎の基礎」を習得
2. 「通常作業」で日々の操作を練習
3. 必要に応じて他の章を参照

### 全コマンド一覧表

| コマンド | 一言説明 | 頻度 |
|---------|---------|------|
| `git init` | 新規リポジトリ作成 | ★ |
| `git clone` | リモートリポジトリを複製 | ★★ |
| `git status` | 現在の状態確認 | ★★★ |
| `git add` | ステージングエリアに追加 | ★★★ |
| `git commit` | 変更を記録 | ★★★ |
| `git push` | リモートに送信 | ★★★ |
| `git pull` | リモートから取得＆統合 | ★★★ |
| `git fetch` | リモートから取得のみ | ★★ |
| `git diff` | 差分を表示 | ★★★ |
| `git log` | コミット履歴表示 | ★★ |
| `git branch` | ブランチ操作 | ★★ |
| `git checkout` | ブランチ切り替え | ★★ |
| `git switch` | ブランチ切り替え（新） | ★★ |
| `git merge` | ブランチを統合 | ★★ |
| `git rebase` | コミット履歴を整理 | ★★ |
| `git stash` | 変更を一時退避 | ★★ |
| `git reset` | コミットを取り消し | ★ |
| `git revert` | コミットを打ち消し | ★ |
| `git restore` | ファイルを復元 | ★★ |
| `git tag` | タグ付け | ★ |
| `git remote` | リモート管理 | ★ |

---

## 1. 初期設定

### 1.1 git config（ユーザー名、メール、エディタ）★★

Gitを使う前に、自分の情報を設定します。

```bash
# ユーザー名の設定
git config --global user.name "Your Name"

# メールアドレスの設定
git config --global user.email "your.email@example.com"

# デフォルトエディタの設定
git config --global core.editor "vim"  # または "nano", "code --wait" など

# 設定確認
git config --list

# 特定の設定を確認
git config user.name
```

**スコープの違い：**
- `--global`: 全リポジトリに適用
- `--local`: 現在のリポジトリのみ（デフォルト）
- `--system`: システム全体（管理者権限必要）

### 1.2 SSH鍵設定 ★

GitHubと安全に通信するためのSSH鍵を設定します。

```bash
# SSH鍵の生成
ssh-keygen -t ed25519 -C "your.email@example.com"

# 鍵の場所（デフォルト）
# 秘密鍵: ~/.ssh/id_ed25519
# 公開鍵: ~/.ssh/id_ed25519.pub

# SSH agentに鍵を追加
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 公開鍵をクリップボードにコピー（Mac）
pbcopy < ~/.ssh/id_ed25519.pub

# 公開鍵をクリップボードにコピー（Linux）
xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# 公開鍵を表示（Windows/その他）
cat ~/.ssh/id_ed25519.pub
```

**GitHubに公開鍵を登録：**
1. GitHubにログイン
2. Settings > SSH and GPG keys
3. "New SSH key"をクリック
4. 公開鍵を貼り付けて保存

**接続テスト：**
```bash
ssh -T git@github.com
```

### 1.3 Personal Access Token (PAT) ★

HTTPS接続でGitHubを使う場合のトークン設定です。

**トークンの作成：**
1. GitHub > Settings > Developer settings
2. Personal access tokens > Tokens (classic)
3. "Generate new token"
リック
4. 必要な権限を選択（repo, workflowなど）
5. トークンをコピー（再表示できないので注意）

**使用方法：**
```bash
# HTTPS URLでclone時にパスワードの代わりに使用
git clone https://github.com/username/repo.git
# Username: あなたのGitHubユーザー名
# Password: 生成したトークン

# 認証情報をキャッシュ（Mac）
git config --global credential.helper osxkeychain

# 認証情報をキャッシュ（Linux）
git config --global credential.helper cache

# 認証情報をキャッシュ（Windows）
git config --global credential.helper wincred
```

### 1.4 .gitignore の書き方 ★★

Gitで追跡しないファイルを指定します。

```bash
# .gitignoreファイルの作成
touch .gitignore
```

**基本的な記法：**
```gitignore
# コメント

# 特定のファイルを無視
secret.txt
config.local.js

# ディレクトリ全体を無視
node_modules/
.vscode/
dist/

# パターンマッチ
*.log          # すべての.logファイル
*.tmp          # すべての.tmpファイル
!important.log # ただしこれは除外しない

# 特定の場所のみ
/TODO          # ルートのTODOのみ
docs/*.pdf     # docs直下の.pdfのみ
**/temp        # すべての階層のtempディレクトリ
```

**よくあるパターン：**
```gitignore
# OS生成ファイル
.DS_Store
Thumbs.db

# エディタ
.vscode/
.idea/
*.swp
*.swo
*~

# 依存関係
node_modules/
vendor/
venv/

# ビルド成果物
dist/
build/
*.o
*.exe

# 環境設定
.env
.env.local
config.local.yml

# ログファイル
*.log
logs/

# 一時ファイル
tmp/
temp/
*.tmp
```

**gitignoreが効かない場合：**
```bash
# すでにGit管理下にあるファイルはキャッシュをクリア
git rm --cached ファイル名
git rm -r --cached ディレクトリ名

# 全キャッシュをクリアして再追加
git rm -r --cached .
git add .
git commit -m "Update .gitignore"
```

**便利なツール：**
- [gitignore.io](https://www.toptal.com/developers/gitignore) - 環境に応じた.gitignoreを自動生成

---

## 2. リポジトリ用語

### 2.1 ローカル/リモート

**ローカルリポジトリ：**
- 自分のPCにあるリポジトリ
- ネットワーク接続なしで作業可能
- commit, branch, mergeなどはローカルで完結

**リモートリポジトリ：**
- サーバー（GitHub等）にあるリポジトリ
- チームメンバーと共有
- push/pullで同期

### 2.2 origin / upstream

**origin：**
- デフォルトのリモートリポジトリ名
- `git clone`時に自動的に設定される
- 通常は自分がpush権限を持つリポジトリ

**upstream：**
- フォーク元のリポジトリ（慣例的な名前）
- 他人のリポジトリをフォークした場合に設定
- 最新の変更を取り込むために使用

```bash
# リモートリポジトリの確認
git remote -v

# upstreamの追加
git remote add upstream https://github.com/original-owner/repo.git

# upstreamから最新を取得
git fetch upstream
```

### 2.3 SSH vs HTTPS

**SSH：**
- 公開鍵認証を使用
- パスワード入力不要
- URL形式: `git@github.com:username/repo.git`

**HTTPS：**
- Personal Access Tokenを使用
- ファイアウォール環境で動作しやすい
- URL形式: `https://github.com/username/repo.git`

```bash
# リモートURLの確認
git remote get-url origin

# HTTPSからSSHに変更
git remote set-url origin git@github.com:username/repo.git

# SSHからHTTPSに変更
git remote set-url origin https://github.com/username/repo.git
```

### 2.4 重要な用語集

- **HEAD**: 現在作業しているコミットへの参照
- **インデックス/ステージングエリア**: コミット前の準備領域
- **ワーキングツリー**: 実際に編集しているファイル群
- **コミットハッシュ**: コミットを識別する40文字の英数字
- **ブランチ**: コミットの系列を指すポインタ
- **マージ**: 複数のブランチを統合すること
- **コンフリクト**: 自動マージできない競合状態
- **Fast-forward**: ブランチポインタを進めるだけのマージ

---

## 3. 基礎の基礎

### 3.1 init - 新規リポジトリ作成 ★

ゼロからGitリポジトリを作成します。

```bash
# 現在のディレクトリをGitリポジトリに
git init

# 新しいディレクトリを作成してGitリポジトリに
git init my-project
cd my-project

# 確認
ls -la  # .gitディレクトリが作成されている
```

**初回コミットの流れ：**
```bash
# ファイルを作成
echo "# My Project" > README.md

# ステージング
git add README.md

# コミット
git commit -m "Initial commit"

# リモートリポジトリを追加（GitHub等で作成済みの場合）
git remote add origin https://github.com/username/repo.git

# プッシュ
git push -u origin main
```

### 3.2 clone - リポジトリを複製 ★★

既存のリポジトリをコピーします。

```bash
# HTTPS
git clone https://github.com/username/repo.git

# SSH
git clone git@github.com:username/repo.git

# 別名でクローン
git clone https://github.com/username/repo.git my-folder

# 特定のブランチをクローン
git clone -b develop https://github.com/username/repo.git

# shallow clone（履歴を浅くする）
git clone --depth 1 https://github.com/username/repo.git
```

**クローン後の確認：**
```bash
cd repo
git remote -v      # リモートリポジトリ確認
git branch -a      # 全ブランチ確認
git log --oneline  # コミット履歴確認
```

### 3.3 status - 現在の状態確認 ★★★

リポジトリの現在の状態を確認します。

```bash
# 詳細表示
git status

# 簡潔表示
git status -s
git status --short

# ブランチ情報も表示
git status -sb
```

**出力の見方：**
```
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:           # ステージング済み（コミット準備完了）
  (use "git restore --staged <file>..." to unstage)
        modified:   file1.txt

Changes not staged for commit:    # 変更あるがステージング未
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   file2.txt

Untracked files:                   # Git管理外のファイル
  (use "git add <file>..." to include in what will be committed)
        file3.txt
```

### 3.4 diff - 差分を表示 ★★★

変更内容を確認します。

```bash
# ワーキングツリーとステージングエリアの差分
git diff

# ステージングエリアと最新コミットの差分
git diff --staged
git diff --cached  # 同じ意味

# 特定のファイルの差分
git diff file.txt

# 2つのコミット間の差分
git diff commit1 commit2

# ブランチ間の差分
git diff main develop

# 統計のみ表示
git diff --stat

# 単語単位の差分
git diff --word-diff
```

**差分の見方：**
```diff
diff --git a/file.txt b/file.txt
index 1234567..abcdefg 100644
--- a/file.txt          # 変更前
+++ b/file.txt          # 変更後
@@ -1,3 +1,4 @@         # 変更箇所の行番号
 既存の行
-削除された行           # - で始まる
+追加された行           # + で始まる
 変更なしの行
```

### 3.5 log - コミット履歴表示 ★★

コミットの履歴を確認します。

```bash
# 基本的な表示
git log

# 1行表示
git log --oneline

# グラフ表示
git log --graph --oneline --all

# 詳細な差分も表示
git log -p

# 最近のN件のみ
git log -n 5
git log -5

# 特定期間のみ
git log --since="2024-01-01"
git log --until="2024-12-31"
git log --since="2 weeks ago"

# 特定の作者のコミット
git log --author="Your Name"

# ファイルの変更履歴
git log -- file.txt

# コミットメッセージで検索
git log --grep="fix"

# 装飾つき表示
git log --graph --decorate --oneline --all
```

**エイリアス設定例：**
```bash
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# 使用
git lg
```

### 3.6 show - コミット詳細表示 ★

特定のコミットの詳細を表示します。

```bash
# 最新コミットの詳細
git show

# 特定のコミット
git show commit-hash
git show HEAD
git show HEAD~2  # 2つ前のコミット

# 特定のファイルの特定バージョン
git show commit-hash:path/to/file.txt

# 統計のみ
git show --stat

# タグの情報表示
git show v1.0.0
```

---

## 4. 通常作業（取得から提出まで）

### 4.1 fetch - リモートから取得のみ ★★

リモートの最新情報を取得します（ローカルブランチは変更しない）。

```bash
# originの全ブランチを取得
git fetch origin

# すべてのリモートから取得
git fetch --all

# 特定のブランチのみ取得
git fetch origin main

# 削除されたリモートブランチを反映
git fetch --prune
git fetch -p
```

**fetchとpullの違い：**
- `fetch`: リモートの情報を取得するのみ
- `pull`: fetch + merge（自動的にマージまで行う）

### 4.2 pull - リモートから取得＆統合 ★★★

リモートの変更を取得してマージします。

```bash
# 現在のブランチに対応するリモートブランチからpull
git pull

# 特定のリモート・ブランチから
git pull origin main

# rebaseでpull（マージコミットを作らない）
git pull --rebase

# Fast-forwardのみ許可（マージコミット不要な場合のみ成功）
git pull --ff-only
```

**コンフリクトした場合：**
```bash
# 1. コンフリクトファイルを編集
# 2. 解決後にステージング
git add conflicted-file.txt

# 3. マージを完了
git commit
```

### 4.3 add - ステージングエリアに追加 ★★★

ファイルをコミット対象に追加します。

```bash
# 特定のファイルを追加
git add file.txt

# 複数ファイルを追加
git add file1.txt file2.txt

# カレントディレクトリ以下すべて
git add .

# リポジトリ全体
git add -A
git add --all

# 対話的に追加（一部だけステージング）
git add -p
git add --patch

# 変更と削除のみ追加（新規ファイルは除く）
git add -u
git add --update
```

**対話モード（-p）の使い方：**
```
y - このハンクをステージング
n - このハンクをスキップ
s - このハンクを分割
e - このハンクを手動編集
q - 終了
```

### 4.4 commit - 変更を記録 ★★★

ステージングされた変更をリポジトリに記録します。

```bash
# 基本的なコミット
git commit -m "コミットメッセージ"

# 詳細なメッセージ（エディタが開く）
git commit

# addとcommitを同時に（追跡済みファイルのみ）
git commit -am "メッセージ"

# 空のコミット
git commit --allow-empty -m "Empty commit"

# 直前のコミットに追加（修正）
git commit --amend

# 作者情報を指定
git commit --author="Name <email@example.com>" -m "メッセージ"
```

**良いコミットメッセージの書き方：**
```
1行目: 変更の要約（50文字以内）

3行目以降: 詳細な説明
- なぜこの変更が必要か
- 何を変更したか
- どのような影響があるか

関連Issue: #123
```

**Conventional Commits形式：**
```
feat: 新機能追加
fix: バグ修正
docs: ドキュメント変更
style: コードスタイル修正（動作に影響なし）
refactor: リファクタリング
test: テスト追加・修正
chore: ビルドプロセス等の変更

例:
feat: ユーザー登録機能を追加
fix: ログイン時のバリデーションエラーを修正
docs: READMEにインストール手順を追加
```

### 4.5 push - リモートに送信 ★★★

ローカルのコミットをリモートに反映します。

```bash
# 現在のブランチをpush
git push

# 初回push（上流ブランチを設定）
git push -u origin main
git push --set-upstream origin feature-branch

# 特定のブランチをpush
git push origin main

# すべてのブランチをpush
git push --all

# タグもpush
git push --tags

# 強制push（危険）
git push -f
git push --force

# より安全な強制push（他の人の変更を上書きしない）
git push --force-with-lease
```

**⚠️ やってはいけないこと：**
- 他の人が使っているブランチに`git push -f`
- mainブランチに直接push（保護されている場合）

### 4.6 stash - 変更を一時退避 ★★

作業中の変更を一時的に保存します。

```bash
# 変更を退避
git stash
git stash save "作業の説明"

# 未追跡ファイルも含めて退避
git stash -u
git stash --include-untracked

# 退避リストを確認
git stash list

# 最新の退避を復元（退避は残る）
git stash apply

# 最新の退避を復元（退避を削除）
git stash pop

# 特定の退避を復元
git stash apply stash@{2}

# 退避の内容を確認
git stash show
git stash show -p  # 差分も表示

# 退避を削除
git stash drop
git stash drop stash@{1}

# すべての退避を削除
git stash clear

# 退避からブランチを作成
git stash branch new-branch-name
```

**使用例：**
```bash
# 作業中に緊急の修正依頼
git stash -u              # 現在の作業を退避
git checkout main         # mainブランチに移動
# 緊急修正作業...
git checkout feature      # 元のブランチに戻る
git stash pop             # 作業を復元
```

### 4.7 remote - リモートリポジトリ管理 ★

リモートリポジトリの追加・削除・確認を行います。

```bash
# リモートリポジトリ一覧
git remote
git remote -v  # URLも表示

# リモートリポジトリを追加
git remote add origin https://github.com/username/repo.git

# upstreamを追加（フォーク時）
git remote add upstream https://github.com/original/repo.git

# リモートリポジトリの詳細情報
git remote show origin

# リモートリポジトリのURLを変更
git remote set-url origin https://new-url.git

# リモートリポジトリを削除
git remote remove origin
git remote rm origin

# リモートリポジトリ名を変更
git remote rename old-name new-name
```

---

## 5. 修正・取り消し

### 5.1 commit --amend - 直前のコミットを修正 ★★

最後のコミットを修正します。

```bash
# コミットメッセージのみ修正
git commit --amend -m "新しいメッセージ"

# ファイルを追加してコミット修正
git add forgotten-file.txt
git commit --amend --no-edit  # メッセージは変更しない

# エディタでメッセージ修正
git commit --amend
```

**⚠️ 注意：**
- すでにpush済みのコミットは修正しない
- やむを得ず修正した場合は`git push --force-with-lease`

### 5.2 reset - コミットを取り消し ★

コミットを取り消します。HEADの位置を移動します。

```bash
# 3つのモード

# 1. soft: コミットのみ取り消し（変更はステージングに残る）
git reset --soft HEAD~1

# 2. mixed（デフォルト）: コミット＆ステージングを取り消し（変更はワーキングツリーに残る）
git reset HEAD~1
git reset --mixed HEAD~1

# 3. hard: すべて取り消し（変更も消える）※危険
git reset --hard HEAD~1

# 特定のコミットまで戻る
git reset --hard abc1234

# 特定のファイルのステージングを取り消し
git reset HEAD file.txt
```

**HEAD~の表記：**
- `HEAD`: 現在のコミット
- `HEAD~1` または `HEAD~`: 1つ前のコミット
- `HEAD~2`: 2つ前のコミット
- `HEAD^`: 1つ前のコミット（親が複数の場合は1番目の親）

### 5.3 revert - コミットを打ち消し ★

新しいコミットを作って過去のコミットを打ち消します。

```bash
# 特定のコミットを打ち消し
git revert abc1234

# 複数のコミットを打ち消し
git revert abc1234 def5678

# コミットメッセージの編集をスキップ
git revert abc1234 --no-edit

# 打ち消しコミットを作らずステージングのみ
git revert -n abc1234
git revert --no-commit abc1234
```

**resetとrevertの違い：**
- `reset`: 履歴を書き換える（push済みには使わない）
- `revert`: 新しいコミットで打ち消す（push済みでも安全）

### 5.4 restore - ファイルを復元 ★★

ファイルやステージングを復元します（Git 2.23以降）。

```bash
# ワーキングツリーの変更を破棄
git restore file.txt
git restore .  # すべてのファイル

# ステージングを取り消し（ワーキングツリーは保持）
git restore --staged file.txt

# 特定のコミットからファイルを復元
git restore --source=HEAD~2 file.txt

# ステージングとワーキングツリー両方を復元
git restore --staged --worktree file.txt
```

**旧コマンドとの対応：**
```bash
# 旧: git checkout -- file.txt
# 新: git restore file.txt

# 旧: git reset HEAD file.txt
# 新: git restore --staged file.txt
```

### 5.5 reflog - 削除したコミット復元 ★

HEADの移動履歴を表示し、削除したコミットを復元します。

```bash
# reflog表示
git reflog
git reflog show

# 特定のブランチのreflog
git reflog show main

# reflogから復元
git reset --hard HEAD@{2}
git checkout HEAD@{3}

# 削除したブランチの復元
git branch deleted-branch HEAD@{10}
```

**使用例（誤ってresetした場合）：**
```bash
git reset --hard HEAD~3  # 誤って3つ戻してしまった
git reflog               # 操作履歴を確認
git reset --hard HEAD@{1}  # reset前の状態に戻す
```

### 5.6 clean - 未追跡ファイル削除 ★

Git管理外のファイルを削除します。

```bash
# 削除されるファイルの確認（実際には削除しない）
git clean -n
git clean --dry-run

# 未追跡ファイルを削除
git clean -f
git clean --force

# ディレクトリも削除
git clean -fd

# .gitignoreで無視されているファイルも削除
git clean -fx

# 対話モード
git clean -i
```

**⚠️ 注意：**
- `-f`（force）が必須
- 削除されたファイルは復元できない
- 必ず`-n`で確認してから実行

### 5.7 rm / mv - ファイル削除・移動 ★

Gitの管理下でファイルを削除・移動します。

```bash
# ファイル削除
git rm file.txt

# ファイルを残してGit管理から除外
git rm --cached file.txt

# ディレクトリごと削除
git rm -r directory/

# ファイル移動・リネーム
git mv old-name.txt new-name.txt

# コミット
git commit -m "ファイルを削除/移動"
```

**通常の削除との違い：**
```bash
# 通常の削除
rm file.txt
git add file.txt  # 削除をステージング

# Git経由の削除（1コマンドで完結）
git rm file.txt
```

---

## 6. ブランチ操作

### 6.1 branch - ブランチ管理 ★★

ブランチの作成・削除・一覧表示を行います。

```bash
# ブランチ一覧
git branch

# リモートブランチも含めて一覧
git branch -a
git branch --all

# リモート追跡ブランチのみ
git branch -r

# 詳細情報表示
git branch -v
git branch -vv  # 上流ブランチも表示

# ブランチ作成
git branch feature-login

# ブランチ作成＆切り替え
git branch feature-login
git checkout feature-login
# または
git checkout -b feature-login

# 特定のコミットからブランチ作成
git branch feature-login abc1234

# ブランチ削除
git branch -d feature-login  # マージ済みのみ
git branch -D feature-login  # 強制削除

# リモートブランチ削除
git push origin --delete feature-login

# ブランチ名変更
git branch -m old-name new-name
git branch -M old-name new-name  # 強制
```

### 6.2 checkout / switch - ブランチ切り替え ★★

ブランチを切り替えます。

```bash
# checkout（従来）
git checkout main
git checkout feature-login

# ブランチ作成＆切り替え
git checkout -b new-feature

# switch（Git 2.23以降、推奨）
git switch main
git switch feature-login

# ブランチ作成＆切り替え
git switch -c new-feature
git switch --create new-feature

# 直前のブランチに戻る
git switch -

# リモートブランチを追跡して切り替え
git switch -c local-branch origin/remote-branch
```

**checkoutとswitchの違い：**
- `checkout`: ブランチ切り替え＋ファイル復元など多機能
- `switch`: ブランチ切り替え専用（明確）

### 6.3 merge - ブランチを統合 ★★

ブランチをマージします。

```bash
# 現在のブランチにfeature-loginをマージ
git merge feature-login

# Fast-forwardしない（マージコミットを必ず作成）
git merge --no-ff feature-login

# マージコミットメッセージを指定
git merge feature-login -m "Merge feature-login into main"

# マージのみ実行（コミットしない）
git merge --no-commit feature-login

# 競合時の対応
git status          # 競合ファイル確認
# ファイル編集...
git add file.txt    # 解決をステージング
git commit          # マージコミット完了

# マージ中止
git merge --abort
```

**マージの種類：**

1. **Fast-forward（早送り）**
```
main:    A---B
              \
feature:       C---D

↓ git merge feature

main:    A---B---C---D
```

2. **3-way merge**
```
main:    A---B---C
              \
feature:       D---E

↓ git merge feature

main:    A---B---C---F (マージコミット)
              \     /
feature:       D---E
```

### 6.4 tag - バージョン管理 ★

特定のコミットにタグをつけます。

```bash
# 軽量タグ作成
git tag v1.0.0

# 注釈付きタグ作成（推奨）
git tag -a v1.0.0 -m "Version 1.0.0"

# 特定のコミットにタグ
git tag v1.0.0 abc1234

# タグ一覧
git tag
git tag -l "v1.*"  # パターンマッチ

# タグの詳細表示
git show v1.0.0

# タグをpush
git push origin v1.0.0

# すべてのタグをpush
git push origin --tags

# タグ削除（ローカル）
git tag -d v1.0.0

# タグ削除（リモート）
git push origin --delete v1.0.0

# タグをチェックアウト
git checkout v1.0.0  # detached HEAD状態になる
```

**セマンティックバージョニング：**
```
v<major>.<minor>.<patch>

v1.0.0 - 初回リリース
v1.0.1 - バグ修正
v1.1.0 - 新機能追加（後方互換性あり）
v2.0.0 - 破壊的変更
```

---

## 7. 発展

### 7.1 rebase - コミット履歴を整理 ★★

コミット履歴を書き換えます。

```bash
# 現在のブランチをmainの最新に乗せ換え
git rebase main

# 対話的rebase（直近3つのコミット）
git rebase -i HEAD~3

# 特定のコミットから
git rebase -i abc1234

# rebase中止
git rebase --abort

# rebase続行（コンフリクト解決後）
git add file.txt
git rebase --continue

# rebase スキップ
git rebase --skip
```

**対話的rebaseのコマンド：**
```
pick   abc1234 コミット1   # そのまま使用
reword abc1234 コミット2   # メッセージ変更
edit   abc1234 コミット3   # コミット自体を編集
squash abc1234 コミット4   # 前のコミットと統合
fixup  abc1234 コミット5   # 前のコミットと統合（メッセージ破棄）
drop   abc1234 コミット6   # コミット削除
```

**使用例：**
```bash
# 複数のコミットを1つにまとめる
git rebase -i HEAD~3
# pickを最初だけ残し、他をsquashに変更

# コミットの順序を入れ替え
git rebase -i HEAD~3
# エディタで行を入れ替え

# コミットを分割
git rebase -i HEAD~3
# editに変更
git reset HEAD~
# ファイルごとにadd & commit
git rebase --continue
```

### 7.2 pull --rebase ★★

pullする際にrebaseを使用します。

```bash
# rebaseでpull
git pull --rebase

# デフォルトでrebaseを使用する設定
git config --global pull.rebase true

# 特定のブランチのみ
git config branch.main.rebase true
```

**mergeとrebaseの違い：**
```
# merge
main:    A---B---C-------F
              \         /
feature:       D---E----

# rebase
main:    A---B---C
                  \
feature:           D'---E'
```

### 7.3 cherry-pick - 特定のコミットを取り込む ★

他のブランチから特定のコミットだけを取り込みます。

```bash
# 特定のコミットを取り込む
git cherry-pick abc1234

# 複数のコミット
git cherry-pick abc1234 def5678

# コミット範囲を指定
git cherry-pick abc1234..def5678

# コミットせずステージングのみ
git cherry-pick -n abc1234
git cherry-pick --no-commit abc1234

# 競合時
git cherry-pick --continue  # 解決後に続行
git cherry-pick --abort     # 中止
```

**使用例：**
```bash
# hotfixブランチから特定の修正だけをmainに取り込む
git checkout main
git cherry-pick hotfix-commit-hash
```

### 7.4 rebase -i の応用（fixup, autosquash） ★

コミットを自動的に統合します。

```bash
# fixup用のコミット作成
git commit --fixup=abc1234

# squash用のコミット作成
git commit --squash=abc1234

# autosquashでrebase
git rebase -i --autosquash HEAD~5

# デフォルトでautosquashを有効に
git config --global rebase.autosquash true
```

**ワークフロー例：**
```bash
# 1. 通常のコミット
git commit -m "feat: 新機能追加"

# 2. 後で修正が必要になった
git commit --fixup=HEAD  # 直前のコミットを修正

# 3. 複数の修正後、まとめてrebase
git rebase -i --autosquash main
# → fixupコミットが自動的に適切な位置に配置される
```

---

## 8. デバッグ・調査

### 8.1 blame - 誰が書いたか ★

各行の最終更新者を表示します。

```bash
# 基本的な使用
git blame file.txt

# 行範囲を指定
git blame -L 10,20 file.txt

# コミットハッシュを短く
git blame -s file.txt

# 作者のメールも表示
git blame -e file.txt

# 特定のコミット時点での情報
git blame abc1234 file.txt

# 行の移動も追跡
git blame -M file.txt

# ファイルのコピーも追跡
git blame -C file.txt
```

**出力の見方：**
```
abc12345 (John Doe 2024-01-15 10:30:00 +0900  1) def function():
def56789 (Jane Smith 2024-01-20 15:45:00 +0900  2)     return True
```

### 8.2 bisect - バグ原因探索 ★

二分探索でバグが混入したコミットを特定します。

```bash
# bisect開始
git bisect start

# 現在のコミットは不良
git bisect bad

# 特定のコミットは正常だった
git bisect good abc1234

# ↑ここから自動的に中間のコミットがチェックアウトされる

# テスト後、good/badを繰り返す
git bisect good  # このコミットは正常
# または
git bisect bad   # このコミットは不良

# 原因コミットが特定されたら終了
git bisect reset
```

**自動化：**
```bash
# テストスクリプトで自動判定
git bisect start HEAD abc1234
git bisect run ./test.sh

# test.shは成功時に0、失敗時に1を返す
```

### 8.3 grep - リポジトリ検索 ★

リポジトリ内のコードを検索します。

```bash
# 基本検索
git grep "search_term"

# 行番号付き
git grep -n "search_term"

# 件数表示
git grep -c "search_term"

# 関数名を表示
git grep -p "search_term"

# 特定のファイルタイプのみ
git grep "search_term" -- "*.js"

# 正規表現
git grep -E "pattern"

# 大文字小文字を区別しない
git grep -i "search_term"

# 特定のコミットで検索
git grep "search_term" abc1234

# AND検索
git grep -e "term1" --and -e "term2"

# OR検索
git grep -e "term1" --or -e "term2"
```

---

## 9. 高度なトピック

### 9.1 submodule - サブモジュール管理 ★

他のリポジトリを自分のリポジトリに含めます。

```bash
# submodule追加
git submodule add https://github.com/user/repo.git path/to/submodule

# submodule初期化
git submodule init

# submodule更新
git submodule update

# 初期化と更新を同時に
git submodule update --init

# 再帰的に（nested submoduleにも対応）
git submodule update --init --recursive

# クローン時にsubmoduleも取得
git clone --recursive https://github.com/user/repo.git

# submodule一覧
git submodule status

# submodule削除
git submodule deinit path/to/submodule
git rm path/to/submodule
rm -rf .git/modules/path/to/submodule
```

### 9.2 subtree - サブツリー管理 ★

submoduleの代替手段です。

```bash
# subtree追加
git subtree add --prefix=path/to/subtree https://github.com/user/repo.git main --squash

# subtree更新
git subtree pull --prefix=path/to/subtree https://github.com/user/repo.git main --squash

# subtree push
git subtree push --prefix=path/to/subtree https://github.com/user/repo.git main
```

**submodule vs subtree：**
- **submodule**: 別リポジトリへの参照（`.gitmodules`で管理）
- **subtree**: 実際のファイルを含む（通常のディレクトリとして扱える）

### 9.3 worktree - 作業ツリー管理 ★

複数のブランチを同時にチェックアウトします。

```bash
# 新しいworktreeを作成
git worktree add ../project-feature feature-branch

# worktree一覧
git worktree list

# worktree削除
git worktree remove ../project-feature

# 孤立したworktreeのクリーンアップ
git worktree prune
```

**使用例：**
```bash
# メインの作業ディレクトリ
cd ~/project

# 緊急修正用に別worktree作成
git worktree add ../project-hotfix hotfix-branch
cd ../project-hotfix
# 修正作業...

# 元のディレクトリに戻る
cd ~/project
# 通常の作業を継続
```

### 9.4 hooks - Git フック ★

特定のGitイベント時に自動実行されるスクリプトです。

**フックの場所：** `.git/hooks/`

**主なフック：**
```bash
pre-commit       # コミット前に実行
prepare-commit-msg  # コミットメッセージ準備時
commit-msg       # コミットメッセージ検証
post-commit      # コミット後に実行
pre-push         # push前に実行
pre-rebase       # rebase前に実行
```

**例：pre-commit（コード整形）**
```bash
#!/bin/sh
# .git/hooks/pre-commit

# JavaScriptファイルをlint
npm run lint

# 失敗したらコミット中止
if [ $? -ne 0 ]; then
    echo "Lint failed. Please fix errors."
    exit 1
fi
```

**フックを実行可能にする：**
```bash
chmod +x .git/hooks/pre-commit
```

### 9.5 shallow clone / sparse checkout ★

大規模リポジトリを効率的に扱います。

**shallow clone（履歴を浅くする）：**
```bash
# 最新のコミットのみ取得
git clone --depth 1 https://github.com/user/repo.git

# 指定した深さまで取得
git clone --depth 10 https://github.com/user/repo.git

# 完全な履歴に変換
git fetch --unshallow
```

**sparse checkout（一部のファイルのみチェックアウト）：**
```bash
# リポジトリをクローン（ファイルはチェックアウトしない）
git clone --filter=blob:none --sparse https://github.com/user/repo.git
cd repo

# sparse checkoutを有効化
git sparse-checkout init --cone

# 特定のディレクトリのみチェックアウト
git sparse-checkout set docs/ src/

# チェックアウト対象を追加
git sparse-checkout add tests/

# 設定確認
git sparse-checkout list

# 通常のcheckoutに戻す
git sparse-checkout disable
```

---

## 10. GitHub/GitLab ワークフロー

### 10.1 Fork & Clone

他人のリポジトリをフォークして作業します。

**手順：**

1. **GitHubでFork**
   - リポジトリページの「Fork」ボタンをクリック

2. **自分のForkをクローン**
```bash
git clone https://github.com/your-username/repo.git
cd repo
```

3. **upstreamを追加**
```bash
git remote add upstream https://github.com/original-owner/repo.git
git fetch upstream
```

4. **最新の変更を同期**
```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

### 10.2 Pull Request / Merge Request の作り方

**基本的な流れ：**

1. **ブランチを作成**
```bash
git checkout -b feature/new-feature
```

2. **変更をコミット**
```bash
git add .
git commit -m "feat: 新機能を追加"
```

3. **自分のリポジトリにpush**
```bash
git push origin feature/new-feature
```

4. **GitHubでPull Requestを作成**
   - リポジトリページに表示される「Compare & pull request」をクリック
   - タイトルと説明を記入
   - レビュアーを指定（任意）
   - 「Create pull request」をクリック

**良いPR（Pull Request）の書き方：**
```markdown
## 概要
この機能について簡潔に説明

## 変更内容
- 変更点1
- 変更点2

## 動作確認
- [ ] ローカルでテスト済み
- [ ] 既存機能に影響なし

## スクリーンショット（該当する場合）
![image](url)

## 関連Issue
Closes #123
```

### 10.3 コードレビュー

**レビュアー側：**
```markdown
# 承認（Approve）
LGTM! (Looks Good To Me)

# 変更依頼（Request Changes）
ここを修正してください：
- 変数名をより明確に
- エッジケースの処理を追加

# コメント（Comment）
質問：この処理の意図は？
```

**作成者側（フィードバック対応）：**
```bash
# 修正を加える
git add .
git commit -m "fix: レビューコメントに対応"
git push origin feature/new-feature
# → PRが自動的に更新される
```

### 10.4 Issue管理

**Issueの作成：**
```markdown
## 問題の説明
バグの詳細や要望を記載

## 再現手順
1. ○○を実行
2. ××を確認
3. エラーが発生

## 期待される動作
正しい動作の説明

## 環境
- OS: macOS 14.0
- ブラウザ: Chrome 120
```

**Issueとコミットの関連付け：**
```bash
git commit -m "fix: ログイン処理を修正 (#42)"

# PRから自動的にIssueをクローズ
git commit -m "feat: 新機能追加

Closes #42
Fixes #43
Resolves #44"
```

### 10.5 Protected Branch

重要なブランチを保護します。

**GitHub設定：**
1. Settings > Branches
2. "Add rule"をクリック
3. Branch name pattern: `main`
4. 以下を設定：
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass
   - ✅ Require branches to be up to date
   - ✅ Include administrators

### 10.6 CODEOWNERS

特定のファイル・ディレクトリのレビュアーを自動指定します。

**`.github/CODEOWNERS`ファイル：**
```
# デフォルトのオーナー
* @global-owner1 @global-owner2

# ドキュメント
docs/ @doc-team

# フロントエンド
src/frontend/ @frontend-team

# バックエンド
src/backend/ @backend-team

# 特定のファイル
package.json @tech-lead
.github/ @devops-team
```

---

## 11. チーム開発ベストプラクティス

### 11.1 コミットメッセージ規則（Conventional Commits）

**基本フォーマット：**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**type（必須）：**
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更（空白、フォーマットなど）
- `refactor`: リファクタリング
- `perf`: パフォーマンス改善
- `test`: テストの追加・修正
- `chore`: ビルドプロセス等の変更
- `ci`: CI設定の変更

**例：**
```
feat(auth): ユーザー登録機能を追加

Google OAuth2.0を使用したソーシャルログインに対応。
既存のメール/パスワード認証も継続してサポート。

Closes #123
```

### 11.2 ブランチ命名規則

**推奨パターン：**
```
<type>/<issue-number>-<short-description>

例：
feature/42-user-registration
fix/84-login-validation
hotfix/critical-security-patch
docs/update-readme
refactor/improve-performance
```

**type：**
- `feature/`: 新機能
- `fix/`: バグ修正
- `hotfix/`: 緊急修正
- `release/`: リリース準備
- `docs/`: ドキュメント
- `refactor/`: リファクタリング
- `test/`: テスト

### 11.3 Git Flow

機能開発からリリースまでの体系的なワークフロー。

**ブランチ構成：**
- `main`: 本番環境（常に安定）
- `develop`: 開発の統合ブランチ
- `feature/*`: 機能開発
- `release/*`: リリース準備
- `hotfix/*`: 緊急修正

**ワークフロー：**

```bash
# 1. 機能開発開始
git checkout develop
git checkout -b feature/new-feature

# 2. 開発作業
git add .
git commit -m "feat: 新機能実装"

# 3. developに統合
git checkout develop
git merge --no-ff feature/new-feature
git branch -d feature/new-feature

# 4. リリース準備
git checkout -b release/1.2.0 develop
# バージョン番号更新、最終テストなど

# 5. mainにマージ
git checkout main
git merge --no-ff release/1.2.0
git tag -a v1.2.0 -m "Release version 1.2.0"

# 6. developにもマージ
git checkout develop
git merge --no-ff release/1.2.0

# 7. リリースブランチ削除
git branch -d release/1.2.0

# 緊急修正（hotfix）
git checkout -b hotfix/1.2.1 main
# 修正作業...
git checkout main
git merge --no-ff hotfix/1.2.1
git tag -a v1.2.1 -m "Hotfix 1.2.1"
git checkout develop
git merge --no-ff hotfix/1.2.1
git branch -d hotfix/1.2.1
```

### 11.4 GitHub Flow

Git Flowよりシンプルなワークフロー。

**ブランチ構成：**
- `main`: 常にデプロイ可能な状態

**ワークフロー：**

```bash
# 1. mainから機能ブランチ作成
git checkout main
git pull
git checkout -b feature/new-feature

# 2. 作業＆コミット
git add .
git commit -m "feat: 新機能追加"
git push origin feature/new-feature

# 3. Pull Request作成
# GitHubでPRを作成

# 4. コードレビュー
# レビュアーが確認・承認

# 5. mainにマージ
# GitHubでマージボタンをクリック

# 6. ローカルのmain更新
git checkout main
git pull

# 7. 機能ブランチ削除
git branch -d feature/new-feature
```

### 11.5 CI/CD連携の基礎

**GitHub Actions設定例：**

`.github/workflows/ci.yml`
```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run tests
      run: npm test
    
    - name: Run linter
      run: npm run lint
```

---

## 12. よくあるワークフロー

### 12.1 個人開発

```bash
# 1. リポジトリ作成
git init
git add .
git commit -m "Initial commit"

# 2. GitHubにリポジトリ作成後
git remote add origin https://github.com/username/repo.git
git push -u origin main

# 3. 日々の作業
git add .
git commit -m "feat: 新機能追加"
git push

# 4. 過去の状態を確認
git log
git checkout abc1234  # 特定コミットを確認
git checkout main     # 最新に戻る
```

### 12.2 チーム開発（基本）

```bash
# 1. 最新を取得
git checkout main
git pull

# 2. 機能ブランチ作成
git checkout -b feature/login-page

# 3. 作業
git add .
git commit -m "feat: ログインページを作成"

# 4. リモートにpush
git push origin feature/login-page

# 5. Pull Request作成（GitHub上）

# 6. レビュー後、mainにマージ（GitHub上）

# 7. ローカルのmain更新
git checkout main
git pull

# 8. 不要なブランチ削除
git branch -d feature/login-page
```

### 12.3 コンフリクト解決

**コンフリクト発生時：**

```bash
# 1. pullまたはmerge時にコンフリクト
git pull
# Auto-merging file.txt
# CONFLICT (content): Merge conflict in file.txt

# 2. コンフリクトファイルを確認
git status

# 3. ファイルを編集
# コンフリクトマーカーを探す：
<<<<<<< HEAD
自分の変更
=======
他人の変更
>>>>>>> branch-name

# 4. マーカーを削除して正しい内容に修正

# 5. 解決をステージング
git add file.txt

# 6. マージコミット完了
git commit  # エディタが開く（メッセージはデフォルトでOK）

# 7. push
git push
```

**コンフリクトツールを使用：**
```bash
# マージツール起動
git mergetool

# VS Codeで開く
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'
git mergetool
```

### 12.4 rebaseでPR前に最新化

```bash
# 1. 機能ブランチで作業中
git checkout feature/new-feature

# 2. mainの最新を取得
git fetch origin

# 3. mainの上に自分のコミットを乗せ換え
git rebase origin/main

# 4. コンフリクトがある場合
# ファイルを編集
git add file.txt
git rebase --continue

# 5. force pushが必要
git push --force-with-lease origin feature/new-feature

# 6. Pull Request作成
```

**メリット：**
- 履歴が一直線で綺麗
- コンフリクトを事前に解決
- レビュアーが見やすい

### 12.5 Fork先からPR

**オープンソースプロジェクトへの貢献：**

```bash
# 1. GitHubでFork

# 2. Forkをクローン
git clone https://github.com/your-username/project.git
cd project

# 3. upstreamを追加
git remote add upstream https://github.com/original-owner/project.git

# 4. 最新を同期
git fetch upstream
git checkout main
git merge upstream/main

# 5. 機能ブランチ作成
git checkout -b fix/typo

# 6. 修正
git add .
git commit -m "docs: READMEのtypoを修正"

# 7. 自分のForkにpush
git push origin fix/typo

# 8. 元のリポジトリにPR作成（GitHub上）

# 定期的に最新を同期
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

---

## 13. トラブルシューティング

### 13.1 pushが拒否された

**エラーメッセージ：**
```
 ! [rejected]        main -> main (non-fast-forward)
error: failed to push some refs
```

**原因：**
リモートに自分の知らないコミットがある

**解決方法：**

```bash
# 1. まずpull
git pull

# 2. コンフリクトがあれば解決
git add .
git commit

# 3. 再度push
git push

# または、rebaseでpull
git pull --rebase
git push
```

### 13.2 間違えてcommit/push

**ケース1: コミット直後（まだpushしていない）**
```bash
# メッセージだけ修正
git commit --amend -m "正しいメッセージ"

# ファイルを追加して修正
git add forgotten-file.txt
git commit --amend --no-edit

# コミット自体を取り消し
git reset --soft HEAD~1  # 変更はステージングに残る
git reset HEAD~1         # 変更はワーキングツリーに残る
git reset --hard HEAD~1  # 変更も削除（危険）
```

**ケース2: push済み**
```bash
# revertで打ち消しコミットを作成（安全）
git revert HEAD
git push

# やむを得ず歴史を書き換える場合（危険）
git reset --hard HEAD~1
git push --force-with-lease
```

**ケース3: 機密情報をコミット**
```bash
# 最新コミットからファイルを完全削除
git rm --cached secret.txt
git commit --amend --no-edit

# 歴史からファイルを完全削除（BFG Repo-Cleaner使用）
# https://rtyley.github.io/bfg-repo-cleaner/
java -jar bfg.jar --delete-files secret.txt
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# すでにpush済みなら、トークンやパスワードを即座に変更
```

### 13.3 detached HEAD

**状態：**
```
You are in 'detached HEAD' state.
```

**意味：**
ブランチではなく特定のコミットを直接チェックアウトしている

**解決方法：**

```bash
# 1. 単に元に戻る
git checkout main

# 2. この状態で作業した内容を保存したい
git checkout -b new-branch-name
# または
git branch new-branch-name
git checkout main

# 3. 作業内容を破棄
git checkout main
```

### 13.4 Git LFS（大容量ファイル）

大きなファイル（画像、動画、バイナリ）を扱う場合。

**インストール：**
```bash
# Mac
brew install git-lfs

# Linux
sudo apt-get install git-lfs

# 初期化
git lfs install
```

**使用方法：**
```bash
# 特定の拡張子をLFS管理に
git lfs track "*.psd"
git lfs track "*.mp4"

# .gitattributesが自動生成される
git add .gitattributes

# 通常通りcommit & push
git add file.psd
git commit -m "デザインファイルを追加"
git push
```

### 13.5 リポジトリ破損対応

**破損の検出：**
```bash
# リポジトリの整合性チェック
git fsck --full

# オブジェクトの検証
git fsck --lost-found
```

**復旧方法：**

```bash
# 1. バックアップ作成
cp -r .git .git-backup

# 2. インデックスの再構築
rm .git/index
git reset

# 3. reflogから復元
git reflog
git checkout HEAD@{5}

# 4. 最終手段：新しいクローン
cd ..
git clone https://github.com/username/repo.git repo-new
# 作業中のファイルをコピー
```

### 13.6 その他のトラブル

**問題: .gitignoreが効かない**
```bash
# キャッシュをクリア
git rm -r --cached .
git add .
git commit -m "Update .gitignore"
```

**問題: SSL証明書エラー**
```bash
# 一時的に証明書検証を無効（非推奨）
git config --global http.sslVerify false

# 特定のリポジトリのみ
git config http.sslVerify false
```

**問題: 誤ってファイルを削除**
```bash
# 最新コミットから復元
git checkout HEAD -- file.txt

# 特定のコミットから復元
git checkout abc1234 -- file.txt
```

**問題: ブランチが多すぎる**
```bash
# マージ済みブランチを一括削除
git branch --merged main | grep -v "main" | xargs git branch -d

# リモートで削除されたブランチをローカルから削除
git fetch --prune
git remote prune origin
```

---

## 14. まとめ

### 14.1 データの流れ

```
ワーキングツリー  →  ステージング  →  ローカルリポジトリ  →  リモートリポジトリ
(作業中)           (git add)       (git commit)         (git push)
                                   
     ← git restore ← git restore --staged ← git reset ← git pull/fetch
```

### 14.2 安全性レベル

**安全（いつでも使える）：**
- `git status`, `git log`, `git diff`
- `git add`, `git commit`
- `git pull`, `git fetch`
- `git branch`, `git checkout`

**注意が必要（ローカルのみで使う）：**
- `git reset --hard`（変更が消える）
- `git commit --amend`（履歴書き換え）
- `git rebase`（履歴書き換え）

**危険（チームでは原則使わない）：**
- `git push --force`（他人の変更を消す可能性）
- `git reset`（push済みのコミットに使用）

**やむを得ず使う場合：**
```bash
# 他人の変更を上書きしないforce push
git push --force-with-lease
```

### 14.3 基本ルール

1. **こまめにコミット**
   - 意味のある単位で分割
   - あとで振り返りやすい

2. **pushする前にpull**
   - コンフリクトを早期発見
   - ローカルで解決

3. **わかりやすいメッセージ**
   - 何をしたか明確に
   - Conventional Commitsを推奨

4. **ブランチを活用**
   - mainは常に安定状態
   - 機能ごとにブランチ作成

5. **レビューを経てマージ**
   - Pull Requestで確認
   - 最低1人の承認を得る

6. **履歴を綺麗に保つ**
   - rebaseで整理
   - 無駄なマージコミットを避ける

7. **定期的に同期**
   - upstreamから最新を取得
   - コンフリクトを最小化

---

## 15. 付録

### 15.1 チートシート

**毎日使うコマンド：**
```bash
git status               # 状態確認
git add .                # 全変更をステージング
git commit -m "msg"      # コミット
git push                 # リモートに送信
git pull                 # リモートから取得
git checkout -b branch   # ブランチ作成＆切り替え
```

**週に1回程度：**
```bash
git log --oneline        # 履歴確認
git diff                 # 差分確認
git merge branch         # ブランチ統合
git branch -d branch     # ブランチ削除
git stash                # 変更を退避
git stash pop            # 変更を復元
```

**困ったときに：**
```bash
git reset --hard HEAD~1  # 直前のコミット取り消し
git reflog               # 操作履歴
git checkout -- file     # ファイルの変更破棄
git clean -fd            # 未追跡ファイル削除
```

### 15.2 用語集

| 用語 | 説明 |
|------|------|
| リポジトリ | プロジェクトの履歴を保存する場所 |
| コミット | 変更の記録（スナップショット） |
| ブランチ | 開発の流れを分岐させる仕組み |
| HEAD | 現在作業しているコミットを指すポインタ |
| ステージング | コミット前の準備領域 |
| リモート | サーバー上のリポジトリ |
| クローン | リポジトリの複製 |
| フォーク | 他人のリポジトリを自分のアカウントにコピー |
| プルリクエスト | 変更の取り込みを依頼する仕組み |
| マージ | ブランチを統合すること |
| コンフリクト | 自動マージできない競合 |
| リベース | コミット履歴を整理すること |
| チェリーピック | 特定のコミットだけを取り込むこと |
| タグ | 特定のコミットに名前をつける |
| origin | デフォルトのリモートリポジトリ名 |
| upstream | フォーク元のリポジトリ（慣例） |
| Fast-forward | 早送りマージ |
| detached HEAD | ブランチではなくコミットを直接指している状態 |

### 15.3 参考リンク

**公式ドキュメント：**
- [Git公式サイト](https://git-scm.com/)
- [Git Book（日本語）](https://git-scm.com/book/ja/v2)
- [GitHub Docs](https://docs.github.com/)

**学習リソース：**
- [Learn Git Branching](https://learngitbranching.js.org/)（対話的学習）
- [GitHub Skills](https://skills.github.com/)（実践的チュートリアル）
- [Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)

**ツール：**
- [Oh My Zsh](https://ohmyz.sh/)（Git aliases）
- [GitHub Desktop](https://desktop.github.com/)（GUI）
- [GitKraken](https://www.gitkraken.com/)（GUI）
- [SourceTree](https://www.sourcetreeapp.com/)（GUI）

**便利なサービス：**
- [gitignore.io](https://www.toptal.com/developers/gitignore)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

---

**このマニュアルについて**

- バージョン: 1.0.0
- 最終更新: 2025年1月
- ライセンス: このドキュメントは自由に使用・改変できます

**フィードバック歓迎：**
誤りや改善提案があれば、IssueやPull Requestをお願いします。

---

Happy Git! 🎉
