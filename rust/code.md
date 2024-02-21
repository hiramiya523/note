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