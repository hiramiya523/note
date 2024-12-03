# a

## オレオレ証明書

1. 秘密鍵

    ```sh
    openssl genrsa -out server.key 2048
    ```

1. 証明書署名要求 (CSR: Certificate Signing Request)
    サーバー証明書発行するための署名要求

    ```sh
    // - req: PKCS形式でcsrを作成
    // - new: 新しく作成
    openssl req --out server.csr -key server.key -new
    ```

1. ドメインチェックの回避(SAN.txt)
   Chromeはドメイン名のチェックをCommonNameでなく、SAN(Subject Alternative Name)で行う。

   ```sh
   openssl x509 -req -days 3650 -signkey server.key -in server.csr -out server.crt -extfile SAN.txt
   ```
