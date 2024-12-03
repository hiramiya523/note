状態をアプリケーション側が保持することで、セッションベースの認証です。
<=> 
トークンベース認証

アプリケーションはユーザーのログイン状態を保持しません。

## why use Jwt
- アプリケーションがユーザーのセッション管理しなくて良いので、シンプルに
- 署名を付与するので、改ざん検知可能。
- ユーザーの権限情報を付与できるので、認可に使える？
- SSOによく使われる


## Advantages of JWT
1. ステートレス認証
JWTは自己完結型で、トークン自体が必要なすべての情報を持っています。
これにより、サーバー側でユーザーの状態を保持する必要がなくなり、拡張性が向上します。

1. 分散システムでの利便性
分散システムやマイクロサービスアーキテクチャでは、異なるサービス間でユーザー認証情報を共有する必要があります。
JWTは簡単に他のサービスと共有でき、各サービスで個別にユーザーを認証する必要をなくします。

1. クロスオリジン認証が容易
JWTはクロスオリジンリクエストに適しており、異なるドメイン間で安全に認証情報を交換できます。

1. パフォーマンスの向上
セッションベースの認証と比較して、JWTはサーバーのリソースを節約でき、より良いパフォーマンスを提供します。

## Disadvantages of JWT
1. トークンの盗難リスク
JWTが盗まれると、有効期限が切れるまで攻撃者によって悪用される可能性があります。

1. これを防ぐために、HTTPSを使用して通信を暗号化する、トークンの有効期限を短くするなどの対策が必要です。

1. トークンのサイズ
JWTはセッションIDよりも大きくなることが多く、特に多くのクレームを含む場合は、ネットワークのオーバーヘッドが増加します。

1. トークンの失効管理
一度発行されたJWTは、有効期限が切れるまで有効です。
即時に無効化する標準的な方法がないため、トークンの悪用を防ぐためには追加の仕組みが必要になることがあります。