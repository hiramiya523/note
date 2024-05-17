`idx_t_reservation_commodities_01` (`i_commodity_cd`,`d_use_date`,`i_reserve_status`,`i_stock_agent_cd`,`i_reserve_count`),

# インデックスとは
- データ件数が多いテーブルの検索を早くすることができる。
  `並び順を保持`する。
  https://qiita.com/towtow/items/4089dad004b7c25985e3

- MySql公式
  `マルチカラムインデックスは、インデックス設定されたカラムの値を連結して作成された値を格納する行である、ソート済みの配列とみなすことができます。`
  https://dev.mysql.com/doc/refman/8.0/ja/multiple-column-indexes.html

  つまり、値を連結して、ソートされた配列ってことー？


# 貼り方
## カーディナリティ
カーディナリティが高いカラムをインデックスとすることで、クエリの実行速度を改善できる可能性があります。

- カーディナリティを意識しないと、逆効果の可能性
  ```
  一般的にカーディナリティが低いINDEXの弊害などはいろんな方が言われていますが、
  効果が低いのでSELECTの性能向上にはつながらない
  INSERT時にINDEXの更新がされるのでINDEX数が多いほどINSERTが遅くなる
  ```

# 使い方
## 複合インデックス
### 順番
- index(colm1, colm2)を指定した場合、
  - OK  
    colm1単体、または colm1⇒colm2を(SQL実行順通りに)指定
  - NG  
    colm2単体, colm1⇒colm2を(SQL実行順通りに)指定されていないばあい

- 公式さん
テーブルにマルチカラムインデックスがある場合、オプティマイザは、インデックスの左端のプリフィクスを使用して行をルックアップできます。 
たとえば、`(col1, col2, col3) に 3 カラムのインデックスがある場合、(col1)、(col1, col2)、および (col1, col2, col3) `に対して、インデックス検索機能を使用できます。
https://dev.mysql.com/doc/refman/8.0/ja/multiple-column-indexes.html


# 注意点
## 貼りすぎの問題点
1. 期待外のインデックスを利用される可能性が上がる。
1. 登録時、インデックスの再作成が必要になるため、低速になる。
1. カーディナリティが高いカラムのインデックスを持っていても、そのカラムの値の分布が極端に偏っている場合、オプティマイザーがそのインデックスを使用しないことがあります
  `「カーディナリティが高い」だけでなく、均等にデータが分散されているフィールドにインデックスを貼る のが重要`
  https://makky12.hatenablog.com/entry/2022/11/14/120500