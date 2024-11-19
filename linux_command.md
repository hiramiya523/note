# Overview

Linuxのコマンドについて、仕様のメモと、
実績のある組み合わせを記録。

## Util

```
// 1. 確認 (-print0オプションを使ってヌル文字で区切ることでファイル名を正しく扱うようにしています)
find . -type f -name '*Zone.Identifier' -print0 | xargs -0 ls
// 2. 実行
find . -type f -name '*Zone.Identifier' -print0 | xargs -0 rm
```
