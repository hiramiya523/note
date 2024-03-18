s
systemctl list-timers


- rotate
 保持数

- compress
  gzipで圧縮

- missingok
  missingでもok. ファイル無くても処理を続行するよ！

- postrotate～endscript
  ログローテーション後に実行


- nginx に USR1 シグナルを送ってログを開き直す
https://qiita.com/white_aspara25/items/7c0352cb2c24e5d7268b
 ```
 postrotate
          if [ -f /var/run/nginx.pid ]; then
                  kill -USR1 `cat /var/run/nginx.pid`
          fi
  endscript
  ```


# 問題
error: skipping "/home/middle_db/logs/pre/middle-db.com.log" because parent directory has insecure permissions (It's world writable or writable by group which is not "root") Set "su" directive in config file to tell logrotate which user/