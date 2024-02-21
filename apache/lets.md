
●Let’s Encrypt で設定したドメインを削除するには

- 手動で削除する場合
下記を削除
```
rm -Rf /etc/letsencrypt/archive/ドメイン名
rm -Rf /etc/letsencrypt/live/ドメイン名
rm -f /etc/letsencrypt/renewal/ドメイン名.conf

# apache再起動
  systemctl restart httpd
  systemctl status httpd
```
- certbot(またはcertbot-auto)で削除する場合
```
# backup
cp -Rp /etc/letsencrypt /etc/letsencrypt.$(date +'%Y%m%d%H%M%S')

# certbot起動(対話モード) 
certbot delete

# 削除したいドメインの番号を入力してEnter。※何も入力せずにEnterを押すと全ドメインの設定が削除されるので注意
番号を入力

# apache再起動。※certbotのバージョンによっては自動で行われる
systemctl restart httpd
systemctl status httpd

# バックアップ削除
rm -Rf /etc/letsencrypt.202*
```
