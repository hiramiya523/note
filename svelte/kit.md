- SvelteKitでは、レンダリング前に取得したいデータ（ローディングデータ）をload関数に、フォームデータを受け取った際の処理（フォームアクション）をactions関数として定義できます。

- page.ts と +page.server.tsの違い
  どちらも、
  - +page.server.ts
    サーバ側でのみ、実行する処理。
    DBアクセス、APIキーのようなプライベートな環境変数にアクセスする場合に利用される。

load関数はpage.ts(page.js)ファイルまたは+page.server.ts(+page.server.js)ファイルで定義することができます。page.tsで定義したload関数はサーバまたはクライアントで実行されますが+page.server.jsで定義したload関数は必ずサーバで実行されます。