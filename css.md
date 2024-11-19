# overview

## issue

### 画像の大きさを親要素に合わせたい

### 自分のイメージ

  最も近い親要素のh,wに合わせるには、
  width :100%とか、

## interisting & serarch

- fit-content
利用可能な空間に対して fit-content 式を使用し、指定された引数に置き換えられます。
すなわち min(max-content, max(min-content, length-percentage)) です。

- object-fit:cover
  このような指定だと、画像の比率を無視した大きさの指定になる。

  ```css
    width: 100%;
    height: 100%;
  ```

  `object-fit: cover`だと、画像比率を維持しつつはみ出る部分をカット.

## アスペクト比率

  画面や画像の横と縦の長さの比率のことを言います。

## 比率

  h-fullを指定した時、親の幅を超えている気がした。
  が、そうではなく、親のパディングを含めた高さに合っていた。

## flex & gap

flexコンテナには、正の余白、負の余白があるのでこの理解は必須。

フレックスボックスでは、アイテムの max-content の寸法を flex-basis として使用します。

## CSS 設計

1. width -> max-width
  width の指定をすると、画面幅が縮んだときにコンテンツが収まりきらなくなる可能性が出てくるので、
  幅が変化する方が困るという時以外はなるべく指定しないようにしています。
  https://tech.asoview.co.jp/entry/2022/12/17/005047

1. 子要素の width は grid-template を使う
  親要素を grid にして列幅を指定、さらに均等幅で配置する場合は要素の数で自動計算してくれる 1fr の単位を使います。これでよりフレキシブルになります
  https://tech.asoview.co.jp/entry/2022/12/17/005047

1. height - >min-height を使う
  height を使いたくなった場合、最小の高さを保持してそれ以上になったときに可変してくれる min-height で整えると変化に強くなります。

1. 要素間の余白は margin → gap に変える
  子要素間の余白を一括設定できる gap プロパティを使うと、親要素側で余白をコントロールできるようになり、管理しやすくなります。