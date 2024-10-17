# 参考
- サーバサイドAPIドキュメント
https://docs.stripe.com/api

- JSのAPIドキュメント
https://docs.stripe.com/js

# 用語
## PaymentIntent
 顧客の支払いライフサイクルを追跡し、支払いの試行失敗があった場合にはその記録を残して顧客への請求に重複が発生しないようにします。
 レスポンスで PaymentIntent の client secret を返して、クライアントで支払いを完了します。

## 決済フロー

1. PaymentIntentを作成し、顧客の支払いライフサイクルを始める
2. PaymentIntentの作成で生成される、clientSecretをクライアントに返す。


> Stripe は、収集した住所情報と支払い方法を組み合わせて、PaymentIntent を作成します。

⇒これは、PaymentIntent生成段階から住所を取得できるということか？


できるか分からないが、
配送料金を徴収するために、住所が欲しく、
checkout

- ダミーデータ
`4242 4242 4242 4242`


# メモ
- この記事によると、２回目以降の決済を簡略化できるような記述がある
https://qiita.com/hideokamoto/items/d2ad3b1a3ec101c785a9
⇒2024の記事だ！！

だが、アプリケーションでユーザーを識別する必要がある。

## 配送料請求

請求先住所と配送先住所を収集する(https://docs.stripe.com/payments/collect-addresses)
ことで、顧客に配送料金を請求することが可能。

https://docs.stripe.com/payments/during-payment/charge-shipping

```
PaymentIntentの場合と異なり、Checkoutセッションの場合は、Product / PriceのデータをStripeに登録する必要があります。
その代わりに合計金額の計算を行う必要がなくなります。
https://qiita.com/hideokamoto/items/f0304cb005f276e35d43
```
⇒ つまり、Checkoutセッションは使えない？

Elements を組み合わせる
https://docs.stripe.com/payments/payment-element
Payment Element はその他の Element と連携します。たとえば、このフォームは支払い情報の自動入力に 1 つの追加エレメント、配送先住所の収集にもう 1 つの追加エレメントを使用しています。


github 公式サンプル
https://github.com/stripe-samples/accept-a-payment/tree/main/payment-element