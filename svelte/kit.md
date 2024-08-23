- SvelteKitでは、レンダリング前に取得したいデータ（ローディングデータ）をload関数に、フォームデータを受け取った際の処理（フォームアクション）をactions関数として定義できます。

- page.ts と +page.server.tsの違い
  どちらも、
  - +page.server.ts
    サーバ側でのみ、実行する処理。
    DBアクセス、APIキーのようなプライベートな環境変数にアクセスする場合に利用される。

load関数はpage.ts(page.js)ファイルまたは+page.server.ts(+page.server.js)ファイルで定義することができます。page.tsで定義したload関数はサーバまたはクライアントで実行されますが+page.server.jsで定義したload関数は必ずサーバで実行されます。


- ディレクトリ構成
公式
https://kit.svelte.dev/docs/project-structure


# +page.ts
  +page.svelteのレンダリングに合わせて実行される。
  実行環境は、SSRの場合サーバサイド、CSRの場合クライアントサイド。
  設定によってどちらでも実行されうる.

- エクスポート可能な関数
    - load 
    - prerender
        Boolean
        SSG的な。静的コンテナを事前にビルド。
    - ssr
        Boolean設定。
        デフォルトtrueで、falseは非推奨。
       ```
        もし ssr を false に設定した場合、代わりに空の 'shell' ページがレンダリングされます。これはページがサーバーでレンダリングできない場合には便利 (例えば document などのブラウザオンリーな globals を使用するなど) ですが、ほとんどの状況では推奨されません 
       ```
       ```
       export const ssr = false を最上位(root)の +layout.js に追加した場合、アプリ全体がクライアントのみでレンダリングされるようになり、それはつまり、本質的にはアプリを SPA にする、ということを意味します。
       ```

# +page.serever.ts
常に、サーバ実行。

- エクスポート可能な関数
  - actions
    フォームアクションを表現