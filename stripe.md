# Stripe

手数料: 3.6%

## 参考

- サーバサイドAPIドキュメント
https://docs.stripe.com/api

- JSのAPIドキュメント
https://docs.stripe.com/js

## PaymentIntent

 顧客の支払いライフサイクルを追跡し、
 支払いの試行失敗があった場合にはその記録を残して顧客への請求に重複が発生しないようにします。
 `レスポンスで PaymentIntent の client secret` を返して、`クライアントで支払いを完了`します。

### ライフサイクル(ステータス)

参考
https://docs.stripe.com/payments/paymentintents/lifecycle

requires_payment_method
  - 請求額が確定した段階で生成を推奨


`requires_action` -> 3Dセキュアなど、支払い時の追加アクションが必要なステータス。

- `canceld`
  - `processing`or`succeeded`に移行前、任意のタイミングでキャンセルを実施し移行。
  - キャンセルで売上はリリース
  - 角な確


## 3Dセキュア

PaymentIntentと、Setupintentで管理する。(どっちかを利用？)

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

オーソリしてから、キャプチャーする. つまり与信を取れるということ？
https://docs.stripe.com/payments/place-a-hold-on-a-payment-method

オーソリとキャプチャーを分離することを示すには、PaymentIntent の作成時に、capture_method に manual を指定します

```txt
決済を作成する際に、対象の支払い方法を保留することで、売上をリザーブして後からキャプチャーすることができます。
たとえば、ホテルではゲストのチェックイン前に決済を全額オーソリし、ゲストのチェックアウト時にその金額をキャプチャーするといったことがよく行われます。これは、手動キャプチャーと呼ばれることもあります。

決済のオーソリにより、顧客の支払い方法で金額が確保されて保証されます
```

```php
$stripe = new \Stripe\StripeClient('sk_test_09l3shTSTKHYCzzZZsiLl2vA'
);

$stripe->paymentIntents->create
([
  'amount
' => 1099,
  'currency
' => 'usd',
  'payment_method_types
' => ['card'],
  'capture_method
' => 'manual',
]);
```

サーバーで支払いを確定する
https://docs.stripe.com/payments/quickstart
-> 支払い情報を動的に更新する

## メモ
- この記事によると、２回目以降の決済を簡略化できるような記述がある
https://qiita.com/hideokamoto/items/d2ad3b1a3ec101c785a9
⇒2024の記事だ！！

だが、アプリケーションでユーザーを識別する必要がある。

## 配送料請求

請求先住所と配送先住所を収集する(https://docs.stripe.com/payments/collect-addresses)
ことで、顧客に配送料金を請求することが可能。

https://docs.stripe.com/payments/during-payment/charge-shipping

```a
PaymentIntentの場合と異なり、Checkoutセッションの場合は、Product / PriceのデータをStripeに登録する必要があります。
その代わりに合計金額の計算を行う必要がなくなります。
https://qiita.com/hideokamoto/items/f0304cb005f276e35d43
```

⇒ つまり、配送料金を登録したい場合はCheckoutセッションは使えない？

- Elements を組み合わせる
https://docs.stripe.com/payments/payment-element
Payment Element はその他の Element と連携します。たとえば、このフォームは支払い情報の自動入力に 1 つの追加エレメント、配送先住所の収集にもう 1 つの追加エレメントを使用しています。

- /github 公式サンプル
https://github.com/stripe-samples/accept-a-payment/tree/main/payment-element

## code

- `.js`は、deferで読み込まないと、上手くレンダリング出来ない。
aa

- 住所入力element

```js
const elements = stripe.elements();
const addressElement= elements.create("address", {
  mode:"shipping",
  allowedCountries: ['JP'],
  autocomplete: {
    mode: "automatic"
  },
  fields: {
    phone: "always"
  },
  validation: {
    phone: {
      required: 'always',
    },
  },
});
addressElement.mount("#address-element");
addressElement.on('change', (event) => {
  console.log(event.value)
  if (event.complete) {
    console.log('Address is complete:', event);
  } else {
    console.log('Address not complete or changed:', event.error);
  }
});
```

# 時系列順に記録しないと、蓄積がないわ

## 241218

checkoutSessionは動的な登録を出来ない。

PaymentIntentを利用して決済を進める。
入力はStripeElementで受け取る。

## 250220

やりたいこと。

Customer Objectに、住所情報を登録。
⇒ つまり、住所情報をStripeに送る必要あり。

Payment Intent で3D Sec認証
