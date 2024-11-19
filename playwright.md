# Playwright

## Install

pnpm create playwright
pnpm exec playwright install-deps
-> root権限で実施した方が良いかも？
実行確認

 pnpm exec playwright test

ヘッドレス実行
pnpx playwright test --headed

※コンテナをrebuildしたせいか、installから必要になった。
`pnpm exec playwright install`

## Search

### BestPracice

Official Document.S
https://playwright.dev/docs/best-practices#avoid-testing-third-party-dependencies

1. use Soft assertions
- 


## レポート

### E2Eテストとは？

End-to-End (端から端まで)

- システムやプロセス全体を通しての検査やテスト

- ユーザーの実際の利用環境に基づき、システムが正しく動作するか・データフローが適切に機能するかどうかを、システム全体を通して検証するテスト

- あらゆる構成要素を組み込んだ状態で、テスト対象システム全体の品質を保証する手法です。UI操作をともなうことから「UIテスト」と呼ばれる場合もありますが、バックエンドとの通信などもテスト観点に含まれるため、より上位の概念といえます。

- ユーザーの使用シナリオに基づいて、アプリケーションの開始から終了までの全プロセスをテストする手法です。


よくまとめられている記事
https://zenn.dev/yuu104/articles/what-is-e2e-test

### 具体的に何をテストするか

- E2Eテストで測定すべき項目は、「スピード」「正確さ」「使い勝手の良さ」などです。

ex)
・商品をカートに入れる
・カートの中身を確認する
・支払い手続きを行う
・注文確認メールを受け取る

## コマンド

- レポート確認
 pnpm exec playwright show-report

 Inside that directory, you can run several commands:

  pnpm exec playwright test
    Runs the end-to-end tests.

  pnpm exec playwright test --ui
    Starts the interactive UI mode.

  pnpm exec playwright test --project=chromium
    Runs the tests only on Desktop Chrome.

  pnpm exec playwright test example
    Runs the tests in a specific file.

  pnpm exec playwright test --debug
    Runs the tests in debug mode.

  pnpm exec playwright codegen
    Auto generate tests with Codegen.

We suggest that you begin by typing:

    pnpm exec playwright test