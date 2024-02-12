# Support for password authentication was removed
平文で登録する必要があるので、httpsを常用するのは微妙か。。

## ssh
1. 
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

  cat /home/user/.ssh/github_rsa

- vi ~/.ssh/config
  ```
    Host github.com
      User [username]
      Port 22
      HostName github.com
      IdentityFile ~/.ssh/github_rsa
  ```

1. 
  ssh -T git@github.com


1. https to ssh
git remote -v

# HTTPS -> SSH
git remote set-url origin  git@github.com:USERNAME/REPOSITORY.git

# SSH -> HTTPS
git remote set-url origin  https://github.com/USERNAME/REPOSITORY.git