# client side
ssh-keygen -t rsa -b 4096

# server side setting
1. register a public key
mkdir ~/.ssh
chmod 700 ~/.ssh
cat ~/.ssh/hoge_key.pub >> authorized_keys
chmod 600 ~/.ssh/authorized_keys

1. edit ssh configurations
vim /etc/ssh/sshd_config
```
  PubkeyAuthentication yes
```

1. restart ssh server
sudo service ssh restart

1. make sure you can connect
ssh -i ~/.ssh/vps_id_rsa ubuntu@000.000.000.000
