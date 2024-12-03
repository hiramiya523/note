# overview

## 索引(インデックス)

### ユニーク索引と非ユニーク索引

参考
https://itmanabi.com/unique-cluster-index/

- ユニーク索引
  主キー制約やユニーク制約
- 非ユニーク索引
    行の重複を許す索引

- ユニーク索引と非ユニーク索引の違い
ユニーク索引　：　列や列の組の値の重複を許さない索引。データを一意に特定できる
非ユニーク索引　：　値の重複を許す索引。一部の複数レコードを効率的に抽出できる

### クラスタ索引、非クラスタ索引

PKは自動的にクラスタ索引になりそう。

Mysql(Maria)において、クラスタインデックスを明示的に指定する事は無いが、
PKがそれに該当するらしい。

非ユニーク索引かつクラスタ索引の図が示されているけど、そんなケースある？
=> Posgreだとクラスタ索引追加できるので、非ユニーク索引に対してクラスタ索引を指定出来る。

当然、更新コストに影響はある。

### Fulltext Index

#### 概要

フリーワード検索で`文字数の多い`カラム間の文字結合や、Like検索は避けるべき。
性能面を考慮するなら、Indexを張るべきなのだが、Indexを張れるカラムは、文字列上限があるので難しい場合がある。
ここで、fulltextインデックスを張る.

知りたいことは、多言語に対応するような、最適なngram設定方法を模索したい。
ngramは、前知識として検索単語単位。

#### 調査

定義タイミングは、create or alter
検索は、`match() ... against`構文を使う。

InnoDB full-text indexes have an inverted index design.

単語のリストと、その単語が含まれるドキュメントのリストが、
inverted indexに格納される。
また、Proximity Searchに対応する為に、単語毎の位置情報をバイトオフセットとして格納。

```sql
-- FulltextIndexを確認する

-- 全体
SELECT * FROM information_schema.statistics WHERE index_type = 'FULLTEXT'\G
SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_TABLES;
-- ⇒ 結果の`database名/FTS_00..._INDEX_N`が転置インデックスを

-- 指定
SELECT * 
FROM information_schema.statistics 
WHERE table_schema = 'your_database_name' 
  AND table_name = 'your_table_name'
  AND index_type = 'FULLTEXT';
```

ドキュメントが挿入されると、トークン化され、各単語および関連付けられたデータが FULLTEXT インデックスに挿入されます。
 このプロセスが実行されると、小さなドキュメントの場合でも、補助インデックステーブルへの多数の小規模な挿入が発生します。

#### ngram Full-Text Parser

組込みの MySQL 全文パーサーは、単語間の空白をデリミタとして使用して、単語の開始位置と終了位置を決定します。これは、単語デリミタを使用しない表意文字言語を使用する場合の制限です。 この制限に対処するために、MySQL には、中国語、日本語および韓国語 (CJK) をサポートする ngram 全文パーサーが用意されています。 ngram 全文パーサーは、InnoDB および MyISAM での使用がサポートされています。

中国語、日本語および韓国語 (CJK) をサポートする文字ベースの ngram 全文パーサーと、日本語をサポートするワードベースの MeCab パーサープラグインが、InnoDB および MyISAM テーブルで使用するために提供されています。

デフォルトn=2
トークンサイズが 3 の場合、ngram パーサーは文字列 「abc def」 を 4 つのトークンに解析: 「ab」、「bc」、「de」 および 「ef」。

#### Mode

#### natural language mode (自然言語検索)


#### boolean mode (ブール検索)


```sql
match(text) against ('A' in boolean mode) → 「A」を含むテキスト
match(text) against ('A B' in boolean mode) → 「A」「B」どちらかを含むテキスト
match(text) against ('+A +B' in boolean mode) → 「A」「B」両方含むテキスト
match(text) against ('A -B' in boolean mode) → 「A」を含み、「B」を含まないテキスト
match(text) against ('"A B"' in boolean mode) → 「A」「B」がその順に並んだフレーズを含むテキスト
```

#### 個人の考え

同一テーブルに、多言語が混在する時にFullText Indexを張るのは現実的ではない。
なぜなら、日本語・中国語・韓国語は文字間隔にスペースを用いない

## 参考

https://qiita.com/vukujin/items/49c7164061ffca61f1da
B'zという単語を検索するまでの試行錯誤.
カラムを2つに分けるのは面白い

言語毎にカラムは分けるべきだという意見はやはり多い
https://dba.stackexchange.com/questions/258260/multi-language-full-text-search-using-postgresql

https://www.tech-teacher.jp/blog/morphological-analysis/
⇒日本語に限っていえば、形態素解析ツールは必須かもしれない。
MeCabは一番使われている感じはする。


