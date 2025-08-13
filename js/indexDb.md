# 概要

- RDBではなく、オブジェクト指向データベース
  → リレーションを持たない事を意味する。
- インデックスによる効率的な検索
    → key-valより、柔軟な検索にも対応。
- 非同期でメインスレッドをノンブロック
- トランザクションあり
- 同一`ドメイン`に対して有効
- 複数のDBを作れる

## 基本

IndexedDBとはブラウザで動作するオブジェクト指向データベースです。大量データの保存が可能であり、本格的なオフラインアプリケーションやPWAなどに向いています。
生操作だと、Promise対応していないのでidbのようなラッパを使うそうだが、完璧ではないので生も理解したい。

```js
const DB = 'my';
const VERSION = 1;

const openRequest = window.indexedDB.open(DB, VERSION);

console.log(openRequest)
// upgradeがneededな時。クライアントがDBを持っていない時。
openRequest.onupgradeneeded = function(event){
    console.log("初期化処理....")

}
openRequest.onerror = function(){
    console.log("DBアクセスリクエストに失敗しました ....")
}

openRequest.onsuccess = function(event){
    console.log("DBアクセス成功")
    const db = event.target.result;
}

```
