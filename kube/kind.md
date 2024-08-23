Kubernetes IN Docke

# install on wsl
## kind
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

## kubectl
ドキュメント読むと、kind は kubectl は必須じゃないけど、入れておいた方がいいよーとのことなので、kubectlをインストールします。
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
- checksum
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

## インストールチェック
kind create cluster

# Comman
- 
   - list
      kind get clusters
   - create
      kind create cluster --name kind-2

   - remove
      kind delete cluster --name kind

