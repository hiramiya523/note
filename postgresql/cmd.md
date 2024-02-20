- ログイン
psql -U user

- データベース一覧確認
\l

みやすく
select datname, datdba, encoding, datcollate, datctype from pg_database; 

- 一気にdbまで接続
psql -U postgres -d sample_db

- テーブル一覧確認
  \dt