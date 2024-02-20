- setting
  https://remylog.com/ufw/

  sudo ufw enable

  sudo ufw status

  sudo ufw allow 80
  sudo ufw allow 22
  sudo ufw allow 8080
  sudo ufw reload


- close
  sudo ufw deny

- del
  sudo ufw delete allow 51820/udp
  sudo ufw delete deny 51820/udp
  sudo ufw delete allow 22
  sudo ufw delete allow 22/tcp