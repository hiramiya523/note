https://dev.classmethod.jp/articles/rust-headless-chrome/7



テスト設計について。

rustではユニットテストはテスト対象と同じファイルに記述するのがならわしのようです。同一ファイルに書かなくても一応テスト自体はできますが、
privateな識別子にアクセスできないといったデメリットが発生します。

- 結合テストは？
https://zenn.dev/itskey/articles/8e70cc17768a5c


> プロジェクトのrootにtestsディレクトリを作ります。
> rustにおいて、rootにあるtestsディレクトリ(Cargo.tomlと同じ階層にある)はプロジェクトとは別のcrateとして扱わるのでバイナリクレートを作っている場合でも、結合テストを書く場合には外部に公開するためのlib.rsが必要になります。
> また、testsからはpivate関数を呼ぶことはできません。

```
└── project
    ├── src/
    │   ├── main.rs
    │   └── lib.rs    //必要
    ├── tests/
    │   └── integration_test.rs
    ├── Cargo.toml
```