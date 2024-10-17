# Overview

## Middleware

実装例  

- ログイン試行回数制限
  - なぜ、controllerではないのか？
    - 関心を分離
    - 再利用性の観点
    - パフォーマンスの観点
    記述によって、controllerの無駄な処理を走らせてしまう可能性がある。

