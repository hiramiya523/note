# overview

DBMSについて。

## 正規化

- 目的は？
    冗長性を排除し、独立性を高める。

    `更新時異常`を防ぐ

- 欠点は
    テーブルの数が増えるので、SQLの結合が増え、パフォーマンスが悪化。
    → パフォーマンスの観点で、正規化を崩すということもする。

### 正規化のレベル

#### ボイス・コッド正規形

- ボイス・コッド正規形とは？
  非キー属性から、キーへの関数従属を排除した形。

- 注意点は？
    注意しないと、非可逆な分解をしてしまう可能性がある。
    (分解前の関係を維持しつつ分解すれば、回避できるよ。)

#### 第4正規形

- 関連エンティティとは？
  エンティティ間の関連を表現するエンティティ。
  第4,5正規形の対象は関連エンティティに対して発生する。

## トランザクション

### ACID特性

トランザクションが持つべき性質。
(DBに限らず分散システムや、分散データストアなど)

DBMSがACID特性を実現するために、以下の3つのトランザクション機能がある。

1. コミットメント制御
    - Atomicity (原子性)
      Transactionは、`完全に実行しきる`or`全く実行しない`のどちらか。

1. 排他制御 (同時実行制御)
     - Consistency (一貫性)
          TransactionはDB内部で整合性が保たれている必要がある。
     - Isolation (独立性)
           他のTransactionから影響を受けず、
           `並行で実行したい場合の結果 = 単独で実行した結果`の結果になるべき。
1. 障害回復
    - Durability (耐久性)
        トランザクション結果は、障害発生時も失われてはならない。

### ロストアップデート

トランザクションAが更新した後に、トランザクションBが上書き更新をしてしまう事で、
トランザクションAの更新が失われてしまうこと。

```txt
10というデータを、同時に実行されたトランザクションAとトランザクションBに+10で更新がされた時、
結果が20になってしまう。
```

- 対策
  排他制御を行う。

### ISOLATION LEVEL

トランザクションの独立性と、分離性のレベルのこと。
独立性の阻害要因である、

1. Dirty Reads
   他のTransactionで更新された、コミット前のデータを読み込んでしまうこと。

    ```t
    TransactionBでcommit前のデータを、TransactionAが読み込んでしまい、
    その後Bがrollbackしたら不整合が発生。
    ```

2. Non-Repeatble reads
    `同じデータ`を2回読み込んだとき、それぞれの結果が異なる可能性がある。
    (Phantom は同じじゃない )

    ```txt
    TransactionBのコミット前後により、
    TransactionAが読み込み結果が変わってしまう。
    ```

3. Phantom Reads
    1回と2回目のリスト取得の間に、
    他のトランザクションによる新規データが追加された時、1回目にはなかった幻のデータが追加されてしまう。

の許容範囲で、４つのレベルで表せる。

1. Read Uncommitted
    最も分離レベルが低いが、トランザクションのスループットが上がる。
    Dirty Readsが発生。
2. Read Committed
    コミットされたデータのみ読み込む。
      Dirty readsは抑止可能。
      コミットされてしまえば読み込むので、
      - 値だけが異なるnon-repetable reads
      - レコード追加コミットで発生する、phantom read
      は発生する。
3. Repetable Read
    inno_dbのデフォルト。
    Phantom Readは発生。

4. Serializable
   `Four Update`.直列化可能性という、並列で走らせた場合も直列で走らせた場合と同じ結果になる性質を持つ。

確認コマンド
maria
select @@tx_isolation;

設定
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
MariaDB [middle_db]> SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

### ロック

デッドロックの回避方法は？
→ ロックをかけて処理する順番を統一する。

### 暗黙コミット

(kiyo)
更新系のSQLを実行するとき、`begin`をしていなくとも、  
`暗黙的トランザクション`が勝手に張られる。  

例えば、```update table set hoge = 1;```というクエリがあった時、  
実際にストレージにあるデータの更新は1件に済まず、  
`Atomicity`を担保するためにトランザクションを張る必要がある。  
そのため、明示的にトランザクションを開始しなくとも、暗黙的にトランザクションが生成されている。

もし、整合性を保つ必要のない複数の更新クエリがあった場合、  
それぞれに暗黙的にトランザクションが生成されてしまうため、  
この場合は明示的にトランザクションを張った方が、1つのトランザクション&commitによる書き込みで済むため、  
性能に大きな違いが出る。
⇒ 迷うなら、更新系クエリは全てtransactionで囲ってしまうのがいいかも？(もちろん要件を優先させるが)

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

## その他メモ

なぜ、tomoniでロックもない一回の更新のためにTransactionをはるのか？
⇒ 推測。
今回のDBMSはMaria.トランザクションレベルがRepeatable Readなので、
DBから取得した状態を保つ事をある程度補償した状態で、キャッシュに登録したいのだろうか？
