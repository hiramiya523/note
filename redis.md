# Overview

メモリ上限を超えた時の挙動について。
Redisのメモリが100%になるかmaxmemory設定を超えた時、Eviction という事象が発生します。

Eviction とは直訳すると「立ち退き、明け渡し」的な意味で、既存のキーを削除しメモリを確保する挙動です。

削除ルールはRedisの
`maxmemory-policy`
    - volatile-ttl
        有効期限が短いキーから削除してメモリを確保
    - allkeys-lfu
        最も使用頻度が少ないキーを削除してメモリを確保  
    - noeviction
        メモリ制限に達したときに新しい値は保存されず、エラーを返す

## confnについて

maxmemory <bytes>

