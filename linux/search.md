- ssh access ip
```
sudo grep 'Accepted publickey for' /var/log/auth.log | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'
```


