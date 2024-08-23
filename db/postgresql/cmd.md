- ログイン
psql -U user
psql -U user -d database_name

- データベース一覧確認
\l

- データベース接続
\c <hoge>

みやすく
select datname, datdba, encoding, datcollate, datctype from pg_database; 

- 一気にdbまで接続
psql -U postgres -d sample_db

- テーブル一覧確認
  \dt

- テーブル定義確認
 \d <hoge>

# DDL 

create table todos (
    id integer,
    s_content varchar(512),
    i_complete_flg integer,
    PRIMARY KEY (id)
);

CREATE TABLE Staff
(id    CHAR(4)    NOT NULL,
name   TEXT       NOT NULL,
age    INTEGER    ,
PRIMARY KEY (id));