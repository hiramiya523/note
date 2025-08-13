
sudo apt update
sudo apt install podman


adduserはホームディレクトリの作成なども自動で行うため便利です。
sudo adduser podmanrunner


Lingerの有効化 (重要):
rootlessコンテナは、ユーザーがログインしているセッションに紐づきます。ログアウト後もコンテナを実行し続けるためには、ユーザーのLinger（リンガー）を有効にする必要があります。

Subordinate UIDとGIDの割り当て
次に、作成したユーザーがrootlessコンテナを実行するために必要なSubordinate ID（補助的なUIDとGID）の範囲を割り当てます。これは、コンテナ内のユーザー名前空間をホストOS上の通常のユーザーから分離するための重要な設定です。

podmanrunnerユーザーに100000から65536個のUIDとGIDの範囲を割り当てます。

```
sudo usermod --add-subuids 100000-165535 podmanrunner
sudo usermod --add-subgids 100000-165535 podmanrunner

=> まとめることもできる。
usermod --add-subuids  ...
```


Lingerの有効
  userのログインセッションとsystemdサービスを独立させる
```
loginctl enable-linger podmanrunner
```

動確
```sh
podman run --rm docker.io/library/hello-world
```


pod構築
- network
  podman network create --gateway=10.10.0.1 --subnet=10.10.0.0/24 test-net
  podman network inspect test-net
- pod create
    test-netネットワークの, ipを指定する
    podman pod create --name=test-pod --net test-net \
    --network test-net:ip=10.10.0.10
- add container
    podman run -d --pod test-pod --name web docker.io/library/nginx:1.23.3-alpine

podman pod ps
podman pod inspect test-pod
podman pod stop test-pod

podman rm b2eb0a83b95b
<!-- コンテナ動いてると消せない -->
podman pod rm test-pod



Podman の rootless モードでは、デフォルトのユーザーネットワーク（slirp4netns）ではコンテナ間通信ができません。
そのため、以下のように rootlessでもPodmanネットワーク（bridge）を明示的に作成する必要があります。

```sh
podman network create --driver bridge app-net
```
これで rootless でも --network app-net を指定すれば通信可能です。





- rootless serviceはここに置くべきなの？
mkdir -p ~/.config/systemd/user
systemctl --user daemon-reload
systemctl --user enable --now pod-redis.service