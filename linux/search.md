- ssh access ip
```
sudo grep 'Accepted publickey for' /var/log/auth.log | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'
```


・IP/Port指定で、疎通確認
  nc -v -w 1 000.000.000.000 443
  ↓　
  水野さんよりこちらの方がapacheの正常かまで分かって、良いとのこと
  telnet 000.000.000.000 443
