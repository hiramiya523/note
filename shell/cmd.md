# リソース監視
## CPU 使用率確認
- top
 - -d秒で更新
 - -u {user}のプロセスを確認する
top -d 3


## 圧縮
tar -c

-c : create
-x : extract. expand archive

-z : gzip format

-v : --verbose. show detail 

-f : specify a file name

# user/group
- user list
  cat /etc/passwd

- group list
 cat /etc/group

グループにユーザーを追加する
- add a user to group
  sudo usermod -aG docker ubuntu