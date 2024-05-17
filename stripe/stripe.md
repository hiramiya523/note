# 参考
- サーバサイドAPIドキュメント
https://docs.stripe.com/api

- JSのAPIドキュメント
https://docs.stripe.com/js

# 用語
## PaymentIntent
 顧客の支払いライフサイクルを追跡し、支払いの試行失敗があった場合にはその記録を残して顧客への請求に重複が発生しないようにします。
 レスポンスで PaymentIntent の client secret を返して、クライアントで支払いを完了します。



# 決済フロー


- ダミーデータ
`4242 4242 4242 4242`


# メモ
- この記事によると、２回目以降の決済を簡略化できるような記述がある
https://qiita.com/hideokamoto/items/d2ad3b1a3ec101c785a9
⇒2024の記事だ！！

だが、アプリケーションでユーザーを識別する必要がある。
