# setup

```sh
cargo init hoge && cd hoge/
```

WASMでの開発を楽にするためにTrunkと、それに必要なwasm-bindgen-cliを導入します。

```sh
rustup target add wasm32-unknown-unknown
cargo install --locked trunk
cargo install --locked wasm-bindgen-cli
```

インストールしたら試しに起動させてみましょう。trunkではビルドに必要な設定はindex.htmlに書くようになっており、index.htmlが最低限存在する必要があります。

```sh
touch index.html
trunk serve --open --watch .
```
コンパイル後にブラウザが起動して、ブランクのページが表示されるはずです。今回はこのtrunkを起動させたままにしておきましょう。ウォッチでこのディレクトリ上を監視しているので変更があったら自動でコンパイルされてブラウザも自動でリロードされるようになります。

## leptosの導入

trunkを起動させたまま別のターミナルを開いて次のコマンドを実行します。
cargo add leptos --features=stable

```rs main.rs
use leptos::*;

fn main() {
    mount_to_body(|cx| view! { cx, <p>"Hello, world!"</p> })
}
```