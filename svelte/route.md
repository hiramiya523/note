# Api

- ディレクトリ直下に、`+server.js`を置くとエンドポイントとなる。
  ```
  /src/routes/
    ├ api/
    │   └ +server.js         ->  /api（エンドポイント）
    ├ home/
    │   └ +page.svelte       ->  /home（ページ表示）
    └ +page.svelte           ->  /
  ```
 