- テスト実行
  pnpx playwright test
  pnpm exec playwright test

ヘッドレス実行
pnpx playwright test --headed



# Install
  pnpm create playwright
　⇒ devDependenciesに入る

wslで下記のインストールも促された。(workコンテナでも)
 pnpm exec playwright install-deps


# コマンド

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