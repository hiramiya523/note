## Key命名

衝突回避、可読性のため名前空間を設ける。
`namaA:hoge:fuga:21234`


## Write-Through / Write-Back


## サンダリング・ハード対策

## キャッシュにおけるN+1

patternA:id:1
patternA:id:2
....
patternA:id:1000
↓
1. KEYS patternA:id:*
1. MGET patternA:id:1 patternA:id:2 ...