- 戻り値はスライスで
  何も考えずに書くとこうなる。
  ```
  fn main() {
      let mut s = String::from("hello world");

      let word = first_word(&s); // word will get the value 5
                                // wordの中身は、値5になる

      s.clear(); // this empties the String, making it equal to ""
                // Stringを空にする。つまり、""と等しくする

      // word still has the value 5 here, but there's no more string that
      // we could meaningfully use the value 5 with. word is now totally invalid!
      // wordはまだ値5を保持しているが、もうこの値を正しい意味で使用できる文字列は存在しない。
      // wordは今や完全に無効なのだ！
  }
  ```

  スライスで、借用で返すと、返した後も、返した値が真であることを保証する
  ```
  fn first_word(s: &String) -> &str {
      let bytes = s.as_bytes();

      for (i, &item) in bytes.iter().enumerate() {
          if item == b' ' {
              return &s[0..i];
          }
      }

      &s[..]
  }
  ```

- 関数の引数のシグニチャには、&Stringより&strを指定するべき
  ```
  fn first_word(s: &str) -> &str {
  ```
  もし、文字列スライスがあるなら、それを直接渡せます。Stringがあるなら、 そのString全体のスライスを渡せます。
  ⇒ 同じ関数を&String値と&str値両方に使えるようになるからです。


## Rustでは、エラーハンドリングを行うために`unwrap`、`expect`、`?`、および`match`の4つそれぞれの使い所について以下に説明します。
### `unwrap`
- **用途**: 最小限のエラーハンドリング。簡潔に書きたい場合。
- **利点**: コードがシンプルで短い。
- **欠点**: エラー時にパニックし、どの種類のエラーが発生したかの詳細な情報を提供しません。
- **例**:
  ```rust
  let file = File::open("path").unwrap();
  ```
### `expect`
- **用途**: エラー時に具体的なエラーメッセージを表示させたい場合。デバッグの際に有用。
- **利点**: エラー内容に加え、カスタムメッセージが表示されるため、原因が分かりやすい。
- **欠点**: 依然としてプログラムをパニックさせるため、開発やテスト時には有用ですが、本番環境には適さないことが多い。
- **例**:
  ```rust
  let file = File::open("path").expect("Failed to open the file");
  ```

### `?`
- **用途**: エラーを呼び出し元に伝播させたい場合に使う。関数内で自動的かつ簡潔にエラーハンドリングを行いたい場合。
- **利点**: コードが読みやすく、エラー伝播が簡潔に行える。関数全体で一貫したエラーハンドリングが可能。
- **欠点**: 関数の戻り値が`Result`または`Option`である必要があるため、すべての場面で使えるわけではない。
- **例**:
  ```rust
  fn read_file(path: &str) -> io::Result<String> {
      let mut file = File::open(path)?;
      let mut contents = String::new();
      file.read_to_string(&mut contents)?;
      Ok(contents)
  }
  ```
### `match`
- **用途**: より詳細なエラーハンドリングや異なるエラーごとに異なる処理を行いたい場合。
- **利点**: エラーごとに異なる対処を行うことができ、コードが細かく制御できる。最も柔軟な方法。
- **欠点**: コードが冗長になりがち。
- **例**:
  ```rust
  let file = match File::open("path") {
      Ok(file) => file,
      Err(e) => {
          println!("Failed to open the file: {}", e);
          return;
      }
  };
  ```
### 使い分けの具体例
- **開発初期**: `unwrap`や`expect`を使ってとりあえず動作を確認。
- **デバッグ**: `expect`を使ってエラーメッセージをわかりやすくする。
- **プロトタイプ・スクリプト的な用途**: `unwrap`を使って素早く処理。
- **本番コード**: `?`を使ってシンプルなエラーハンドリング。あるいは、`match`を使って詳細なエラーハンドリング。
状況に応じて適切な方法を選ぶことで、エラーハンドリングを効果的に行うことができます。