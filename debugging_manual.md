# Debugging Manual for AI

## Purpose

To enable AI to efficiently identify and fix bugs while interacting with the user.

## Notes

- Do not start coding immediately.
- Always explain the AI's intentions to the user and receive feedback at each step.
- When testing, generate appropriate test data and test code for each step.

## Debugging Procedure

1. Confirm the Facts

   - Objectively describe what happened using observed phenomena, files, logs, images, etc.

2. Analyze the Incident

   - Organize the sequence leading to the issue in terms of system structure and input/output relationships.

3. Compare Expected and Actual Behavior

   - Clearly compare the behavior expected by the user or defined in the specification with the actual behavior, and visualize the differences.

4. Narrow Down the Cause

   - Logically infer the path of the problem from the observed structure and execution order.

5. Verify Reproducibility

   - Check the conditions under which the issue can be reproduced using input, logs, and environment.

6. Break Down the Processing Logic

   - Analyze relevant functions and structures from the inside to clarify their responsibilities.

7. Identify the Cause and Location of the Bug

   - Separate and identify the cause (e.g., branching logic, syntax error, conversion omission) and the location.

8. Propose a Fixing Strategy

   - Compare multiple options, such as small fixes or refactoring, and present an appropriate fix.

9. Estimate the Scope of Impact

   - Statistically analyze the functions, structures, and modules affected by the fix and assess the risks.

10. Implement the Fix

    - Write code that is concise, clear, and maintainable at the function/class level.

11. Verify at the Function Level

    - Test whether the fixed function/class works as expected in isolation.

12. Integration Test

    - Test whether the fixed function/class interacts correctly with other parts of the system.

13. System-Level Test

    - In the actual execution environment, verify overall behavior and test consistency in outputs, state transitions, logs, etc.

14. Output the Result

    - Output the full code at the level of function, class, or module, according to the user’s instructions.

--

# AI 向けデバッグマニュアル (Japanese)

## 目的

AI がユーザーと対話しながら不具合の特定・修正を効率的に進める

## 注意

- いきなりコーディングしないこと。
- AI の意図をユーザーに説明し、ステップごとにレビューを受けること。
- テストに際しては、各ステップごとに適切なテストデータ/テストコードを生成すること

## デバッグ手順

1. 事実の確認

   - 現象、ファイル、ログ、画像などから「何が起きたか」を客観的に記述する。

2. 事象の分析

   - 事象発生への流れをシステム構造や入出力の関係から整理する。

3. 期待動作と実動作の比較

   - 仕様書やユーザーが期待している動作と、実際の動作を明確に対比し、差分を可視化する。

4. 原因の絞り込み

   - 観測された構造や実行順から、問題の経路を論理的に推定する。

5. 再現可能性の確認

   - 入力・ログ・環境をもとに、問題が再現する条件を確認する。

6. 処理ロジックの分解

   - 関連する関数・構造を内側から読み解き、責任範囲を明確にする。

7. 不具合原因と不具合箇所の特定

   - 条件分岐、構文ミス、変換不足などを原因と場所に分けて示す。

8. 修正方針の提案

   - 小規模修正やリファクタリングなどの複数案を比較し、適切な修正案を提示する。

9. 影響範囲の見積もり

   - 修正が影響する関数、構造、モジュールを静的に分析し、リスクを評価する。

10. 修正の実施

    - 関数/クラス単位で簡潔・明瞭に、将来の変更に耐えうる保守性をもったコードを作成する。

11. 関数レベルの検証

    - 修正済み関数/クラスが単体で期待通りに動作するかをテストする。

12. 結合テスト

    - 修正した関数/クラスが他の部分と正しく連携して動作するかテストする。

13. 全体統合確認（システムテスト）

    - 実行環境での全体的な動作を確認し、出力、状態遷移、ログ等の整合性をテストする。

14. 修正結果の出力

    - 関数／クラス／モジュール単位など、ユーザーの指示に応じた粒度でコード全文を出力する。

--
