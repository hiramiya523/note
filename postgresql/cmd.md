- ログイン
psql -U user

- データベース一覧確認
\l

みやすく
select datname, datdba, encoding, datcollate, datctype from pg_database; 