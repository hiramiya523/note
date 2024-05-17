hostnameは、sshする名称と一致させる必要はなく、自由に決定できるので、
組織や個人で管理しやすい名称を付けるべきである。

ssh で指定するホスト名は、名前解決出来れば何でもよい。(もちろん、hostnameと一致せずとも)


# ホスト名設定
```
sudo hostnamectl set-hostname melon
```