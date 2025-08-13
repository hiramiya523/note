# 定期的にやるべき事
- 容量が逼迫してくるので、最適化する事。(50GBくらい開放出来た)
  https://qiita.com/antyuntyuntyun/items/8a0c555399cd8c96f792
  ```
    wsl --shutdown
    wsl -l -v

    diskpart
    select vdisk file="C:\Users\<username>\AppData\Local\Docker\wsl\data\ext4.vhdx"
    attach vdisk readonly
    compact vdisk
    detach vdisk
    exit
  ```

- logファイルの場所
  \\wsl$\docker-desktop-data\data\docker\containers