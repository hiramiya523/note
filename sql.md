# Overview

about SQL processing perfomance.
syntax

Don't write about the Database.

## Online Analytical Processing (オンライン分析処理)

windowは、範囲という意味を表している。

### Advantages

### 構文

window() Over([Partition by a, b...] ORDER BY)

order by は必須かな、なんか構文エラーになる。
ランク対象を特定してやる必要があるし。

useCase

- 移動平均、
- グループランキング、
- グループ比率
- 期間累積


### Order by {hoge} の挙動について

```sql
select 
count(*) over(),
count(*) over(order by id) 
from t_reservation_charge_types;
```
------
113|1
113|2
113|3

このような結果になるのは、
window関数のorder byの仕様が特殊且つ、OLAPに使われる理由で、
`最初の行から、現在の行までの集計結果を返す`というルールである。

#### フレーム句

モードにより、`CURRENT_ROW`の判定が変わる。

RANGE
ROW

## index

カーディナリティの小さい順に、列を指定するべき。

連結索引は、
列１が等しいもの`同士`がソートされ、
その結果に対して列2で同じように、、、、

注意点  
インデックスの長所は、`検索処理`の性能向上であるが、
インデックスの更新が必要になるので、`更新処理は低下`してしまう。
さらに、これがクラスタ化インデックス（クラスタ索引）であった場合、データページの再編成が必要になることがある。
クラスタ化インデックスはテーブルのデータ自体をソートして保存するため、
更新によって再編成が頻繁に発生すると、負荷が高くなる可能性があります。

⇒ 更新が多いカラムにインデックスを張るのは避けよう。

