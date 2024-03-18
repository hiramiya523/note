# 標準出力
- 参考
 https://keens.github.io/blog/2017/10/05/rustdekousokunahyoujunshutsuryoku/

println!は、遅い。
⇒ 実行の毎に、ロックを取得しているから。

改善 ⇒ ならば、初回にstdoutに対してロックを取得するようにすれば、
性能は上がる。
stdoutに対して、lock().
書き込みは、writeln!()
だが、思ったより上がらない。
⇒ write()を使う
writeln()は、改行でフラッシュされるから。
write!だと（改行がないと）フラッシュされない。