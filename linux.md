# Overview

## Linux Server Operation

### Permission Management

### Why should we use the sudo command?

1. track logs
  "You can track logs for each user."
  /var/log/auth.log, /var/log/secure
1. Security
  Using the root account regularly increases security risks.

## Terminal settings

PS1 は、Unix系オペレーティングシステムのシェル（例えば、BashやZsh）におけるプライマリプロンプト文字列を制御する環境変数です。シェルがコマンドの入力待ち状態で表示するプロンプトの外観を設定するために使用されます。
    \u: 現在のユーザー名
    \h: ホスト名
    \w: 現在の作業ディレクトリ
    \n: 改行
    \\$: 通常ユーザーは$、スーパーユーザー(root)には#を表示

    ANSIエスケープシーケンスを使って、プロンプトのフォントや色をカスタマイズすることができます。例えば、\[\033[0;32m\] は緑色を表します。

プロンプトを、右はじに持ってくる。

PS1='[\033[0;32m]\u ➜ [\033[0;34m]\w [\0330;31m\[\033[0m]\n\$ '
⇒色付きならこっちがいいかも.
PS1='[\033[0;32m]\u:[\033[0;34m]\w [\0330;31m\[\033[0m]\n\$ '

⇒ gitブランチがないディレクトリの場合は、該当箇所非表示。

PS1='\[\033[0;32m\]\u:\[\033[0;34m\]\w $(git rev-parse --is-inside-work-tree &>/dev/null && echo "\[\033[0;31m\]$(git branch --show-current 2>/dev/null)")\[\033[0m\]\n\$ '
PS1='\[\033[0;32m\]\u \[\033[0;34m\]\w $(git rev-parse --is-inside-work-tree &>/dev/null && echo "\[\033[0;31m\]$(git branch --show-current 2>/dev/null)")\[\033[0m\]\n\$ '
