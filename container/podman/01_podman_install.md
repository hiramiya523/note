# install

## Ubuntu

apt-get update
apt-get install podman
```sh
The following additional packages will be installed:
  aardvark-dns buildah catatonit conmon containernetworking-plugins crun fuse-overlayfs golang-github-containers-common golang-github-containers-image libslirp0 libsubid4 libyajl2 login netavark passt passwd slirp4netns uidmap
Suggested packages:
  containers-storage libwasmedge0 docker-compose
The following NEW packages will be installed:
  aardvark-dns buildah catatonit conmon containernetworking-plugins crun fuse-overlayfs golang-github-containers-common golang-github-containers-image libslirp0 libsubid4 libyajl2 netavark passt podman slirp4netns uidmap
The following packages will be upgraded:
  login passwd
2 upgraded, 17 newly installed, 0 to remove and 116 not upgraded.
```
buildahがあるね。
OCIコンテナランタイムとして`crun`もいる。`runc`が他には有名どころか。
<!-- composeが必要なら、サードパーティー製のも apt install podman podman-compose -->

podman -v

rootlessが有効じゃないね。rootユーザーだから？
```sh
$ podman info | grep rootless
    rootless: false
```

ユーザーを作ってみる。
```
adduser nuchedule
>psss: ujtzzR.99s

cat /etc/passwd | grep nuche
nuchedule:x:1001:1001:,,,:/home/nuchedule:/bin/bash

-- sudo実行可能に
gpasswd -a nuchedule sudo

su - nuchedule
sudo ls -la
sudo podman info | grep rootless
```

一応、rootで動かせはするね
```sh
 podman run --name basic_httpd -dt -p 8080:80/tcp docker.io/nginx
Trying to pull docker.io/library/nginx:latest...
Getting image source signatures
Copying blob 40a6e9f4e456 done   |
Copying blob 254e724d7786 done   |
Copying blob 913115292750 done   |
Copying blob 3e544d53ce49 done   |
Copying blob 4f21ed9ac0c0 done   |
Copying blob d38f2ef2d6f2 done   |
Copying blob d3dc5ec71e9d done   |
Copying config a830707172 done   |
Writing manifest to image destination
714453ed6cdcaf503d34a10dd8e673da73d822683c3c8815ab9860f57df30354
root@veillon:/home# podman ps
CONTAINER ID  IMAGE                           COMMAND               CREATED        STATUS        PORTS                 NAMES
714453ed6cdc  docker.io/library/nginx:latest  nginx -g daemon o...  8 seconds ago  Up 8 seconds  0.0.0.0:8080->80/tcp  basic_httpd
```

- loginctlで、対象ユーザーをenable-lingerしてやったらエラーは消えた。
```sh
 podman ps
WARN[0000] The cgroupv2 manager is set to systemd but there is no systemd user session available
WARN[0000] For using systemd, you may need to log in using a user session
WARN[0000] Alternatively, you can enable lingering with: `loginctl enable-linger 1001` (possibly as root)
WARN[0000] Falling back to --cgroup-manager=cgroupfs
WARN[0000] The cgroupv2 manager is set to systemd but there is no systemd user session available
WARN[0000] For using systemd, you may need to log in using a user session
WARN[0000] Alternatively, you can enable lingering with: `loginctl enable-linger 1001` (possibly as root)
WARN[0000] Falling back to --cgroup-manager=cgroupfs
CONTAINER ID  IMAGE       COMMAND     CREATED     STATUS      PORTS       NAMES
nuchedule@veillon:~$ sudo loginctl enable-linger 1001
nuchedule@veillon:~$ podman ps
CONTAINER ID  IMAGE       COMMAND     CREATED     STATUS      PORTS       NAMES
```
lingerを有効にすることで、そのユーザーのサービスがログアウト後も引き続き実行されることを許可します。この設定はsystemd管理のサービスに影響します。
↓
rootlessで動いた！！！
```sh
~$ podman ps -a
CONTAINER ID  IMAGE                           COMMAND               CREATED         STATUS         PORTS                 NAMES
d39c421b516d  docker.io/library/nginx:latest  nginx -g daemon o...  11 seconds ago  Up 12 seconds  0.0.0.0:8080->80/tcp  basic_httpd
nuchedule@veillon:~$ ps aux | grep nginx
nuchedu+   24154  0.0  0.3  11464  7512 pts/0    Ss+  21:39   0:00 nginx: master process nginx -g daemon off;
165636     24178  0.0  0.1  11928  3060 pts/0    S+   21:39   0:00 nginx: worker process
nuchedu+   24209  0.0  0.1   6544  2412 pts/0    S+   21:40   0:00 grep --color=auto nginx
nuchedule@veillon:~$ podman info | grep rootless
    rootless: true
```



## コマンド操作


### Pod 操作
1. pod作成
podman pod create -p 8080:80 --name nginx-pod
podman pod ps
podman run -dt --pod nginx-pod --name nginx docker.io/library/nginx:1.23.3-alpine
podman pod ps

- コンテナのCPU、MemoryUsageを、`top`コマンドのように確認
  podman pod stats -a

  podman pod top ${my_pod}

- 一覧
  podman ps --pod -a

- inspect
  podman pod inspect ${name}

- 停止
podman pod stop nginx-pod

- nameSpace確認
 podman pod ps --ns
POD ID        NAME        STATUS      CREATED         INFRA ID      CGROUP      NAMESPACES  # OF CONTAINERS
dfc7592d6238  tech-pod    Running     12 minutes ago  289a5fedebb6  user.slice 

- 削除
podman pod rm ${pod_name}

### コンテナ操作

- 一覧
  podman ps
  podman ps -a


- クリア
  podman system prune -f --volumes


### kube yaml ベースの操作

su - nuchedule

podman pod create -p 80:80 --name tech-pod
-> 一般userでもwellknownポートバインドできるんだ．．．？
podman run -dt --pod tech-pod --name nginx docker.io/library/nginx:1.23.3-alpine
> ここで怒られる。

/etc/sysctl.conf を編集し、rootlessユーザーにも許可することは可能
```sh
net.ipv4.ip_unprivileged_port_start=80
```

ただ、セキュリティの観点から控えるべきとのこと。
> 一般ユーザーが特権的なポート範囲を利用できるようになります。これにより、システム上の他のユーザーが知らないうちに特権ポートを悪用する可能性があります。

↓ リバースプロキシがやはり無難か。考えてみれば起動したコンテナが勝手にTLS証明書を更新し始めるとか変だもんな...


podman pod create -p 8080:80 --name tech-pod
podman run -dt --pod tech-pod --name nginx docker.io/library/nginx:1.23.3-alpine
`113.43.138.142:8080`

podman ps --pod -a
podman generate kube tech-pod >> teck-kube.yaml
vim teck-kube.yaml

podを削除して、yaml操作を試すよ

```
podman play kube teck-kube.yaml
Pod:
24b8ad2d26e730500d48a6db37067e4fb418f9864f83a28c774ca6e00f0acdfd
Container:
17a1977bf667ab825ab9879e2c1443bbadb036ae565ed74be3a61d8d26f30c3c

nuchedule@veillon:~$ podman pod ps
POD ID        NAME        STATUS      CREATED        INFRA ID      # OF CONTAINERS
24b8ad2d26e7  tech-pod    Running     4 seconds ago  25cf9dd5f1e3  2
```


systemdユニットファイルを作成する
<!-- $ podman generate systemd --name myubi > ~/.config/systemd/user/container-myubi.service -->
いきなりサービスに置くのはやなのでローカルに
podman generate systemd --name tech-pod > container-tech.service

podman generate systemd --name tech-pod --files --new


