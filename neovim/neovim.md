

# plugins

## telescop
### what is 
Fuzzy Finder。ファイルやバッファー、クイックフィックスなど、様々なソースから情報を検索するUIを提供する。

require :   
    - fd : コマンド名はfd。findの拡張版。
    - ripgrep: コマンド名はrg。grepの拡張版。agより若干速い。

apt install fd-find ripgrep

### 操作

h,l: open/close dir tree.

o: order by
i: detail

C-u/d : 普通に使える
C-c : close telescope

shift + h/l : tag move

ctrl + ? : toggle show terminal.


- ファイルリロード
  :e
  :e!
  :tabedo e

#### ファイル編集

gcc : コメントトグル

## neo-tree
C-w,h : treeに戻る
C-h/l : ツリーとファイルを行き来する
<leader>e : ツリーの表示非表示切替
a: create new file

tree上で、`/`を使ってフィルタ表示が可能

https://qiita.com/hwatahik/items/761ba2d378d86ecbc31c
常に開く設定は欲しいかも

## nvim-treesitter
neovim では treesitter(nvim-treesitter) 機能が組込まれており、それを用いてシンタックスハイライトができますがトラブルが多いです。
https://zenn.dev/shougo/articles/nvim-treesitter

:TSUpdate

npm install -g tree-sitter-cli



## 何のプラグインかはわからない

shift + e/E : ルートかカレント科で開く

- となりのtabファイルに移動
  space, w,0/1/...
  ctr+w, h/l でも行けているよ？


## terminal
- open 
  :term

## troble shuting
:messages

### 参考

https://neovim.io
⇒ tabcloseとかの解説あるぜ。
 LazyVimとかは、プラグインマネージャではあるので、
 ベースとなる操作はこちらを見るべきなのかもしれない。
