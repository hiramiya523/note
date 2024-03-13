# 最新版をインストールする

1. 
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring

GnuPG は通信とデータ保存を安全なものにする GNU ツール
OpenPGP: 公開鍵暗号を応用してファイルやメッセージを暗号化してやり取りする技術標準。

lsb-release: 
    ディストリビューションのバージョン確認コマンド
    lsb_release -a
    ⇒ cat /etc/os-release command gives more detail than b
    but, it is useful to get partical information in scripts.

ubuntu-keyring:
    apt-key is deprecated.
    Used to maitain a list of keys that apt uses to authenticate pacages.


2. Import an official nginx signing key so apt could verify the packages authenticity. Fetch the key:
    ```
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
    ```
3. Verify that the downloaded file contains the proper key:
gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

4.
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list


echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx


sudo apt update

sudo apt install nginx
sudo nginx
