# install
sudo apt update 
sudo apt install bind9 bind9-utils

インストール確認
named -v

sudo systemctl status named


# 初期セットアップ
設定ファイルは、`/etc/bind`に格納される
1. ゾーン設定
sudo vim /etc/bind/named.conf.local
```
zone "k-shi.com" {
    // マスターDNSであることを明示
    type master;
    file "/etc/bind/zones/db.k-shi.com"; # ゾーンデータファイルの場所
};
```



# bind9
## named.conf
エントリポイント。インクルードしてるだけ。
```
// 挙動・設定
include "/etc/bind/named.conf.options";
// 独自にzoneを設定
include "/etc/bind/named.conf.local";
// デフォルト
include "/etc/bind/named.conf.default-zones";
```

## named.conf.options
