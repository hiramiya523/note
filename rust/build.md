
# ライブラリの読み込みパスの確認方法
$ uname -m
x86_64

cat /etc/ld.so.conf
```結果
  include ld.so.conf.d/*.conf
```
cat /etc/ld.so.conf.d/*.conf
```
  # libc default configuration
  /usr/local/lib
  # Multiarch support
  /usr/local/lib/x86_64-linux-gnu
  /lib/x86_64-linux-gnu
  /usr/lib/x86_64-linux-gnu
```

なので、このubuntuへのbuildは

```
  cargo build --target x86_64-unknown-linux-gnu
```
リリースビルド
```shell
  cargo build --release --target x86_64-unknown-linux-gnu
```

- 出力先
target/x86_64-unknown-linux-gnu/release/{hoge}

# 参考
- サポートターゲットリスト
https://doc.rust-lang.org/nightly/rustc/platform-support.html