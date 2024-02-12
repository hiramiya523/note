apt installだと古いバージョンしか入らないので、公式のcurlダウンロードをする。libfuseはエラーになるので前もってインストール
sudo apt install libfuse2

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
./nvim.appimage

- パスを通す
sudo ln -s $(pwd)/nvim.appimage /usr/bin/nvim
