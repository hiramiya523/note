apt installだと古いバージョンしか入らないので、公式のcurlダウンロードをする。libfuseはエラーになるので前もってインストール
sudo apt install libfuse2

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
./nvim.appimage

- パスを通す
sudo ln -s $(pwd)/nvim.appimage /usr/bin/nvim

# wslで、ファイルアイコンが表示されないとき
https://qiita.com/hwatahik/items/acdd791abeef4ed13c45

sudo snap install nvim --classic