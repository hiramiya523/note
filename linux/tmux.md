
## Check

- tmux ls

## Launch

- tmux
- tmux new -s {session name}

## Pane Operation

- 左右分割: Ctrl-b, %
- 上下分割: Ctrl-b, "
- ペイン破棄: Ctrl-b, x
- ペイン番号表示: Ctrl-b + q

## 移動

- 次のウィンドウ: Ctrl-b, n
- 前のウィンドウ: Ctrl-b, p
- ペイン移動
    - Ctrl-b, 方向キー 
    - 順番: Ctrl-b +  o

## 切断

ctrl + b, d

## Session Operations

tmux kill-session
tmux kill-session -t mysession




# 問題

## マウスホイールが聞かない
https://zenn.dev/softoika/scraps/19abddeaa09e12

```~/.tmux.conf
set -g mouse on
bind-key -T edit-mode-vi WheelUpPane send-keys -X scroll-up
bind-key -T edit-mode-vi WheelDownPane send-keys -X scroll-down
```
こちらの記事の方が丁寧かも
https://zenn.dev/ken5l/articles/9ef9df319f66a2


https://qiita.com/nmrmsys/items/03f97f5eabec18a3a18b
#マウス操作を有効にする
set-option -g mouse on