# Overview

## Feature

2つのコネクションを張る。

1. 制御コネクション
    ログイン情報、コマンド受信などの、セッション周りを管理。
2. データコネクション

### active mode

静的ポート。
21ポートに、`サーバ --> クライアント`でデータを送信。

ここで問題なのが、クライアントが21ポートを解放していない場合、
データ受信が出来ない。
⇒ そこで、Passive Modeが誕生。

### passive mode

データの受信に、
サーバ側の、設定範囲内の任意ポートを利用するという方式が取られる。
データの受信は、`クライアント --> サーバ`になるため、クライアントのufw設定を考慮する必要がなくなる。

### Ubuntu settings

サーバ側にvsftpdが必要なので、状態確認
systemctl status vsftpd

vim /etc/vsftpd.conf

touch /etc/vsftpd.user_list

systemctl start vsftpd

ufw status verbose

```sh
ufw allow in on eth0 from 153.127.219.93 to any port ftp
ufw allow in on eth0 from 153.127.219.93 to any port 40000:40030 proto tcp
```

ufw status verbose
