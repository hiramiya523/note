# Overview

## web

### Session

- セッションIDに求められる要件
  - 推測不可
        -> 通常の乱数でなく、暗号論的疑似乱数生成器を用いること
  - IDを強制されないこと
  - 漏洩しないこと
    - URLパラメータに付与しない
      Refererや、

### フロント

#### Cookie

cookieにデータを保存することはsessionと比較した場合、
ほとんどのケースで推奨されないが

特に保存してはいけない情報は、
アプリケーション利用者に、改竄されると困る情報
    ユーザーID, 権限情報など

- http onlyは安心できない理由。
  jsから参照、更新ができない。
  XSSの緩和策
  → 完全な防御にならない。
  -> document.documentElement.innerHTMLを取得できるので、マイページ情報の個人情報を取得可能
    (mypageにXSS脆弱性がなくとも、別ページにあればmypageをフェッチできる(Cookieは自動付与.操作出来ないだけで利用可能。同一オリジン)
  -> csrfトークンも取得できてしまう(hiddenに埋め込まれる形式でも、html取得できるので。)

脆弱性について、以下が上げれられる。

- HTTPヘッダ・インジェクション
- クッキーセキュア属性不備
    https通信でもsecure属性がないcookieは平文送信される可能性があり、盗聴されうる。
    方法、
    httpsに紐づくcookieは、http://xxxxxx:443で、レスポンスは失敗しても、リクエスト自体は送信される。
    ⇒ 平文のcookieが、ネットワーク上に流れる。
    ⇒ secure属性は必ずつけましょう。(常時TLS化)
    ⇒ もしだめなら、トークンを発行してそいつにsecure属性を付ける。

cookieのpath属性の制限は、
パスによりセッションを分けたりはできるが、セキュリティ対策には貢献しないことを知っておけ。
⇒ jsは、オリジンポリシーがホスト名単い。

__HOST- : 特別なcookie。同一ホスト名のみにしか送られない。

#### hidden vs Cookie

- hidden
  - メリット  
    hiddenパラメータが、情報漏洩と第三者からの書き換えに対して、堅牢である理由。
  - デメリット  
    本人による書き換えが改ざんが可能

### アプリケーション

### 攻撃手法

#### CSRF

Forgery : 偽造

- 対策

  - Token検証
    アンチCSRFトークンを使用する
    サーバー側のCSRF防御には、アンチCSRFトークンが使用されます。これは、ユーザーのブラウザとWebアプリケーションだけが知っているランダムな文字列で構成されています。

    セッション変数の値が非表示のフォームフィールドと一致する場合、アプリケーションはリクエストを受け入れます。2つの値が一致しないと、リクエストは破棄されます。攻撃者は、非表示のフォームフィールド内の値を知らないため、リクエストの受け入れに利用することはできません。これにより、CSRF攻撃が阻止されます。

  - Cookie内でSameSiteフラグを使用する
    セッションクッキーがSameSiteクッキーとして指定されている場合、同じドメインからのリクエストでのみ送信できます。ほとんどの場合、攻撃者のドメインは標的Webサイトのドメインとは異なります。したがって、生成されるセッションCookieは、同じサイトからのものではありません。SameSiteクッキーが使用されている場合、攻撃者によるPOSTリクエストの送信は、別のドメインからのものであるためブロックされます。

    ただし、ハッカーが何らかの方法でターゲットドメインにアクセスし、そのドメインから動作する場合、リクエストは同じサイトから送信され、SameSiteの「テスト」に合格する可能性があります。したがって、WebアプリケーションやWebアプリケーションをホストするサーバーを適切に保護することが重要です。そうしないと、攻撃者はSameSiteプロトコルを満たし、ユーザーのアカウントを悪用する攻撃を開始できます。さらに、ドメイン内のページは、他のページよりも基本的なものであっても、正規のものと見なされる可能性が高くなります。これにより、攻撃者は無防備な顧客の信頼を得ることができます。

  - Refererチェック(IPAより`https://www.ipa.go.jp/security/vuln/websecurity/csrf.html`)

  - アップデート案
    - SameSite属性 (Strict, Lax, None)  
        → ブラウザ間で動作に差異が。
        → 古いブラウザは非対応、Getでは送られてしまう。
    - Originヘッダを付与
        サーバ側でOriginヘッダを照合すればよいのでは？
        → honoや、sveltekitでも採用されつつある？
    - Sec-Fetch-XXX を利用
        リクエスト元の詳細な情報がわかる。
        割と最近なので、古いブラウザは非対応の可能性.

なぜ、`Sec-`が安全なのか。

    https://blog.bokken.io/articles/2023-01-29/about-fetch-metadata.html
    ```
   Sec- prefixed ヘッダの Sec- がついている理由
    現状では、 Sec-Fetch や Sec-CH-UA などの prefix が存在している。

    それぞれ、Sec-Fetch は Fetch Metadata Request Headers、Sec-CH-UA は User-Agent Client Hints で定義されている。

    この Sec- prefix については、その答えは Fetch Metadata Request Headers に下記のように記載されている。

    Each of the headers defined in this document is prefixed with Sec-, which makes them all forbidden header names, and therefore unmodifiable from JavaScript. This will prevent malicious websites from convincing user agents to send forged metadata along with requests, which should give sites a bit more confidence in their ability to respond reasonably to the advertised information.

    --- Fetch Metadata Request Headers

    つまり、 Sec- prefixed な理由は、 Fetch Standard で定義されている forbidden header name にして JavaScript から変更できないようにするためとのこと。こうすることで malicious なサイトがヘッダを JavaScript で偽装してくることを防げる。

    引用元の Fetch Standard にも下記のように記載されている。

    These are forbidden so the user agent remains in full control over them.

    Header names starting with Sec- are reserved to allow new headers to be minted that are safe from APIs using fetch that allow control over headers by developers, such as XMLHttpRequest. XHR

    --- Fetch Standard

    Header の仕様 (5.1. Headers class - Fetch Standard) に、 header の validate に関する定義があるが、forbidden reqeust-header の場合は無効と判定される。Header class のメソッドのうち変更が発生するメソッドでは validation のステップがあるため、forbidden な場合は処理が中断されるようになっている。

    こうすることで、ヘッダが変更されないことを保証するようだ。
    ```


    この情報を用いれば、画像の読み込みのFetchで銀行用のAPIが叩かれるはずがないといった、明らかな不正なリクエストを検知することができるようになる。

  `https://blog.jxck.io/entries/2024-04-26/csrf.html`
  令和時代のAPI実装のベースプラクティス.
  ↓ 徳丸
  確かにその通りなのですが、脆弱性診断業者の中には、トークンないだけでCSRF判定しちゃうところもあるようで困ったものです。 
  https://x.com/ockeghem/status/1783829944088588314

  SPA + WebAPI でアプリケーションを構築するときの CSRF 対策についてのメモ
  https://kimuson.dev/blog/%E3%83%95%E3%83%AD%E3%83%B3%E3%83%88%E3%82%A8%E3%83%B3%E3%83%89/csrf_spa/

- 間違った対策

    ログイン直後など$_SESSION['token']にはこの変数は設定されていない可能性。
    そして、PHPの場合、設定されていない変数を参照するとNULLが返ります（警告が表示され処理は継続される）。
    つまり、$_SESSION['token']の見かけの初期値はNULLということになります。そして、入力フォームに遷移するとトークンが設定され、メールアドレス変更の際にNULL（未定義）に戻ります。

    ```php
    if ($_POST['token'] !== $_SESSION['token']) { // ワンタイムトークン確認
      die('正規の画面からご使用ください');
    }
    ```

    $_POST['token']がNULLであれば、上記のif文はNULL同士の比較になるので、チェックを回避できます。
    `https://blog.tokumaru.org/2018/11/csrf_12.html`

  - Samesite=laxは緩和策にしかなりえない
    `https://blog.tokumaru.org/2022/01/impact-conditions-for-no-CSRF-protection-sites.html`

    > 「csrf-token 不要」で検索をすると、CookieのSameSite 属性を主要なブラウザがサポートをしていることによって、CSRFトークンは用いたCSRF対策は不要である、という記事を拝見しました。
    > 記事内ではSameSiteでLax、Strict を指定していれば、問題ないと書いてはいるのですが、メインブラウザにおいては本当に安全であると言い切っていいものでしょうか？
    SameSite=Strictであっても、いくつかCSRFの経路は残っています。
    例えば中間者攻撃でHTTP側で改ざんして罠ページを作るとか、別のサブドメインにXSS脆弱性があれば、SameSite属性による保護は回避されます。

    以下を推奨
        - アプリケーションフレームワークの提供するCSRF防御機能を使う
        - セッションIDのCookieにはsamesite=laxを明示する
        - 更新処理ではGETメソッドを受け付けないことを確認する

    https://speakerdeck.com/hiro_y/update-your-knowledge-of-csrf-protection?slide=34

  - 自分の理解に基づく対策。
    - formでリクエストされたら、samesiteすり抜ける説。。。？分からないけど検証しないと否定できない。
        → カスタムヘッダーを付与すると、formはそれが実現できないので対策出来そう(`https://www.ubsecure.jp/blog/2024csrf')
    - プリフライトリクエストで、APIの処理が実行されてしまわないか？これは確認したい。
        - AccessControl Origin headerを返す必要があるのでは？
        - つまり、処理が2回走る懸念をしているよ。(異なるOriginの場合、プリフライトが来る事を確認)
        - Laravelはこんな感じ。んー、やはりプリフライトorOPTIONSリクエストは、ヘッダーだけで返すのが無難な気がする。

        ```php
          if ($this->cors->isPreflightRequest($request)) {
              $response = $this->cors->handlePreflightRequest($request);

              $this->cors->varyHeader($response, 'Access-Control-Request-Method');

              return $response;
          }

          $response = $next($request);

          if ($request->getMethod() === 'OPTIONS') {
              $this->cors->varyHeader($response, 'Access-Control-Request-Method');
          }
        ```

    - Originヘッダのチェックはした方がいいかも。
      というか、sveltekit、hono.jsとかそれしか見てない。(`https://speakerdeck.com/hiro_y/update-your-knowledge-of-csrf-protection?slide=32`)

  まとめると。
  1. リクエストメソッドをみる
  1. プリフライトを返却
  1. origin検証
  1. token検証

  1. Sec-Fetch*は使っていいと思う。2023年以降、基本標準。
      https://caniuse.com/?search=Sec-Fetch-Site
    小数点パーセントのユーザーをサポートするかどうかって話。

    web.devも推奨してる雰囲気。`https://web.dev/articles/fetch-metadata?hl=ja#implementing-a-resource-isolation-policy`
      - メタデータ取得リクエスト ヘッダーは、すべての最新のブラウザ エンジンでサポートされています。
      - Fetch Metadata リクエスト ヘッダーを使用すると、強力な多層防御メカニズム（リソース分離ポリシー）をデプロイして、このような一般的なクロスオリジン攻撃からアプリケーションを保護できます。
      - Fetch Metadata リクエスト ヘッダーに基づいてリソース分離ポリシーをデプロイすることで、ほとんど手間をかけずにクロスサイト攻撃からアプリケーションを保護できます。

  form送信、fetch送信が混在されると
  カスタムヘッダを気軽に付与できないのが困る…

#### DOM Based XSS

Javascriptによる処理の不備が原因となる、XSS脆弱性。
近年JSの実装が増えているため、相対的に増加。

色々な方法がある。一例として,

- innerHTMLに、<img src=/ onerror=alert(1) >が挿入出来たら終わり。
- document.writeに、<img src=/ onerror=alert(1) >が挿入出来たら終わり。
- location.hrefに、scriptを挿入されたら終わり。

などなど。

- 対策変
  - URLのスキームは、http/httpsに限定
      location.href, src属性, href属性など
  - 最新のライブラリを使う(JQueryなど古い物特有の脆弱性がある)
  - textContentが使えないなら、せめてエスケープしよう

    ```js
    // ユーザ入力を元にDOM生成するなら、エスケープ必須。
    const query = payload.get('query');
    function escapeHTML(unsafe) {
    return unsafe
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
      }
      document.getElementById('output').innerHTML = escapeHTML(query);
    ```

#### Cookie Theft 対策と Device Bound Session Credentials

```
HTTPS が前提となり通信が暗号化されているため、Cookie を盗むのは難しいと考えるかもしれない。

しかし、Cookie Theft の攻撃ベクタは、通信の Person in the Middle ではなく、マルウェアやフィッシングにトレンドを移している。

ちょうど世間を騒がせた DMM のビットコイン流出事件も、この手法による Session Cookie の窃取が突破口になっているようだ。
```

https://blog.jxck.io/entries/2025-01-16/device-bound-session-credentials.html

```
ドメイン名を見て偽のサイトであることに気づくのが、ユーザができる第一の策だ。長いサブドメインを使って、部分的に本物に見せかける攻撃を防ぐために、モバイルブラウザが eTLD+1 のみの短縮表示を始めたのも、こうした理由が大きい
```

https://slack.engineering/catching-compromised-cookies/
slack社の新たな対策として、タイムスタンプを利用

→ 「盗まれないようにする」のと同じように、「盗まれても大丈夫にする」という対策も考えられている。

#### セッションID固定化攻撃

Session Fixation
https://www.ubsecure.jp/blog/session_fixation

Webサーバーの中には、ブラウザ側で発行したセッションIDを使用可能とする機能を有効化しているものもあります。

セッションID固定化攻撃では、この機能を悪用するのです。まずは攻撃者が生成したセッションIDを含んだURLなどを正規ユーザーに送りつけます。正規ユーザーがそのURLからログインすると、同じセッションIDを使って攻撃者も正規ユーザーと同じようにサイト内を徘徊することが可能となるのです。

#### 内容

#### 対策

1. ログイン前後で、Session Regenerate
1. FWの都合で上記対策が打てないとき、SESSION IDとは別のランダムな値を生成し、Session変数に格納。
    それをSetCookieして、リクエスト毎にチェック。
    ipaにもある=>https://www.ipa.go.jp/security/vuln/websecurity/session-managemenにもある=>

https://www.ipa.go.jp/security/vuln/websecurity/index.html

#### ログイン

##### 実装

- エラーメッセージ
  ID or パスワード、どちらが間違っているかバレるのはマズイ案件。

- アカウントロック
  → アカウントロックの解除を、メールアドレスでURLを送信、時間経過でも、
  (個人的に、管理画面から解除できるのもよいかも)

##### 攻撃

パスワードリスト攻撃
パスワードスプレー攻撃 (「low-and-slow」攻撃)
リバースブルートフォース攻撃
辞書攻撃
ジョーアカウント探索

対策の対策→

##### 攻撃対策

- 文字数は8桁以上は必須。6桁以下は秒。
    英数字64文字で考えたとき、
    6桁 → 約570億
    8桁 → 約220兆

    ただ、、、
    https://pc.watch.impress.co.jp/docs/news/1492292.html
    アルファベットの大文字/小文字/数字/記号の組み合わせでも8桁程度なら7時間で解析できることが示された。
　これを踏まえて同社では、安全性の高いパスワードの要件として
  「15文字以上であること」、
  「アルファベットの大文字と小文字/数字/記号を含めること」、
  「3～6カ月ごとにパスワードを変更すること」を挙げたほか、
  「パスワードを使い回さない」運用を勧めている。

https://www.keepersecurity.com/blog/ja/2023/07/03/how-long-would-it-take-a-cybercriminal-to-crack-my-password/
  逆に、6文字以下のパスワードは、大文字、数字、記号を組み込んでも即座に解読されてしまいます。

- アカウントロック
    ブルートフォースアタック対策

- ソルトを生成して、パスワードをハッシュ化。
ソルトをDBに。
辞書攻撃への効果
一意性の付与:
ソルトを加えることにより、同じパスワードでも異なるユーザ間で異なるハッシュが生成されます。辞書攻撃では、予め用意したハッシュテーブルを利用してパスワードを解読しようとしますが、ソルトを使うことで同じパスワードが異なるハッシュ値になるため、攻撃の効果を減少させます。
大規模なハッシュプリコンピュテーションの防止:
攻撃者が一度ハッシュ結果を生成してしまう（レインボーテーブルのように）方法では、ソルトによってパスワードを推測するために個別のハッシュ出力が必要になります。ソルトがあると、プリコンピュテーションしたハッシュが使えず、逆算する手間が大幅に増えます。
攻撃計算量の増加:
ソルトを使うことで、攻撃者はユーザごと、パスワード入力ごとに異なるソルトを適用するため、計算のコストが増加し、攻撃全体の効率を著しく低下させます。
まとめ
ソルトを利用することは、パスワードハッシュの一部であるだけでなく、辞書攻撃やその他のハッシュベースの攻撃を困難にするための重要なセキュリティ対策の一部です。これにより、たとえ攻撃者がデータベースにアクセスできても、ハッシュ化されたパスワードを元のプレーンテキストパスワードに変換するための労力が増大することから、セキュリティ性が高まります。

- パスワード失敗率の監視
  ログイン失敗率が急激に上昇する。(失敗回数/時間)
  → ログでIP割り出して、IP毎遮断するのもありか。

### TEMP

https://zenn.dev/dyoshikawa/scraps/7143f57e871c57

TCP通信の場合、TCPセッションの確立が必須となるため、IPスプーフィングの成立は困難
そこで攻撃者はさらにTCPシーケンス番号予測攻撃でTCPセッション確立を偽装しようとする
そのためシステム側ではTCPシーケンス番号予測攻撃への対策をする

TCPシーケンス番号
TCPパケットの順序や欠落がないかを確認するための番号
シーケンス番号の初期値をイニシャルシーケンス番号（ISN）という

TCPシーケンス番号予測攻撃
IPスプーフィングした攻撃者クライアントが任意のクライアント側ISNを生成しSYNをサーバに送信
サーバはサーバ側ISNを生成しSYN+ACKを（攻撃者ではない）真正なIPに応答する
攻撃者はSYN+ACKを受け取れないが気にせず、サーバ側ISNを予測してその値でACKを送信する
ACKを受け取ったサーバはシーケンス番号を確認し、正しい番号であればセッションを確立させてしまう

要するに、TCPセッションの確立にはクライアント側ISNとサーバ側ISNを適切に交換することが必要
なので攻撃者はサーバ側ISNの値を読み切れれば攻撃が成功する

TCPシーケンス番号予測攻撃への対策
ISNを予測不可能になるようランダム化する（昔は予測が容易な設定がされていたことがしばしばあったらしい）