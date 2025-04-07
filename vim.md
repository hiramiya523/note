vim コマンド

オプション

vim -R <file>: read only mode.

## コマンド

:e バッファの再読み込み

## 移動系

行先頭(インデント無視): 0

+	下の行の先頭へ
-	

H: 画面内の最初の行に移動
M: 画面の中央の行に移動
L: 画面内の最後の行に移動

page up/down : ctrl + b/f


現在の行からn行移動: n + enter

move to corresponding brackets: %

back to the changed part: ctrl + o
move on insert mode.
control + o, k 上へ移動

g;	変更してきた箇所に戻る
g,	変更してきた箇所に進む

H : move the coursor to the top of the display screen.
L: move the coursor to the bottom of
M: Middle

gj / gk : Vertical movement on display.(ignoring line breaks)

zz: 現在のカーソル行を画面中央になるように表示。
zt: top

カーソル移動なしの表示ウィンドウスクロール
ctl e
ctl y

fだけじゃなくて、tも使ってクレメンス

メソッド移動
[m, ]m(M)で、メソッド移動できるけど、
vscodeは対応していないっぽい。。。

dis: sはsentenceらしいけど、どうなるんだ？ (das)

### cursor word move

単語末尾:e
first letter of the word: b

move to the beginning of the line, ignoring indentations : 0
move to the beginning of the line. : ^
move to the end of the line        : $
move to n line : n + G

## レジスタ
xやyやdの操作時にはレジスタという領域に保存されるようになっている

https://ylabdesk.com/vim-register-commands
無名レジスタから取り出し、カーソルの後方に貼り付け	p

- on normal mode
レジスタaから取り出し、カーソルの後方に貼り付け	`"ap`
レジスタbから取り出し、カーソルの前方に貼り付け	"bP

- on insert mode
無名レジスタから取り出し、カーソルの後方に貼り付け	Ctrl-r "
レジスタaから取り出し、カーソルの後方に貼り付け	Ctrl-r a

- レジスタに命名できる
"ayテキスト
"ap
⇒ it can also be used for commands such as deletion.

can be used: 使う主体が明確でない場合や、用途に焦点を当てたい場合

can use: 使う人や主体が明確な場合

## edit file
:save	ファイルを保存する
:saveas	ファイルを別名で保存する


y->w: copy word
p: paste

:reg   " 現在のレジスタの内容を確認
"2p    " 2番目のレジスタの内容を貼り付け

diw: カーソル上の単語を削除。
di": ダブルクォーテーションの内部を削除。
dit: HTMLタグの内部を削除。
ciw: カーソル上の単語を削除して、インサートモード。
ci": ダブルクォーテーションの内部を削除して、インサートモード。
cit: HTMLタグの内部を削除して、インサートモード。
yiw: カーソル上の単語をコピー。
yi": ダブルクォーテーションの内部をコピー。
yit: HTMLタグの内部をコピー

※html編集激やば

dat, vatはやっべぇ。
タグ対応で、削除、選択できるぞ。じゃあ、catもいけるってことか。

`https://gitlab.nu-face.jp/nu-face/ontra/middle-db/-/issues/37`
=> di`

ci"であればダブルクオートで囲まれた文字列を、ci{であれば中括弧({})で囲まれた文字列を、citであればHTMLタグで囲まれた文字列をそれぞれ編集できます。

cの変わりにdを使ってdi'とタイプするとシングルクオートの内部にある文字列を削除します。(挿入モードには入らない)

va'であれば、シングルクオートで囲まれた文字列をシングルクオートごとビジュアル選択します。。

ndd: 行数カット
delete the word at the cursor position : diw

cc/S: 現在の行を削除して、insert mode.

dap: 段落削除

折り返し行移動
gj
gk

### 連結

スペース無し：g + j
スペースあり: shift + j

## Visual Mode

選択した範囲を大文字に変換: U
選択した範囲を小文字に変換: u
選択した範囲の大文字と小文字を入れ替え: ~

## 置換

:%s/置換前/置換後/

これだと一行中で一番初めに当たったものしか置換されないので

:%s/置換前/置換後/g

とすると1行中に複数マッチしても置換されます。

頭に%と置くと今開いているファイルという意味になるので

:1,100s/置換前/置換後/g

とすると1行から100行までと行を指定できます。

## display
:set nu

### indent operation
add indent: >>
del indent: <<

## tab
tabs: show tab list

## terminal
:vert term

++rows=高さ	ターミナル画面の高さを指定
++cols=幅	ターミナル画面の幅を指定
一応上記のように紹介しましたが、実のところ個人的な好みとしては、ターミナル画面はVim画面全体の下に配置し、デフォルトの高さはそれほど必要としない、と言うことで以下のような操作一択です。

:bo term ++rows=10

## newtrw
vim <dir>

change display info : i
 Open with vertical split :v 
open with horizontal split: o

## interisting

十字キーに慣れた私はここでもう一つの、もっと根本的な過ちを犯したのです。
そうです。j,k,h,l この４つのキーを十字キーと同じ感覚でつかおうとしたのです

ただカーソルを移動させるだけならマウスの方が早いのです。
vimではそんなものは認められません

やるベきことがあるのなら、たどり着いた先でfを押しなさい

あの時私はfで検索するべきだったのです。
f + 文字でカーソル以降、 行内で次の該当文字まで移動することができます。
例えばf + tなら引っかかるのはtです。
すでにカーソルが、その箇所を過ぎていたならF + 文字で後ろに進めるでしょう。
２文字以上は打てません。１文字だけです。
そこから次の検索箇所まで移動したい場合は;を押すといいでしょう。
,を押せば前の検索箇所まで戻ることさえできます

これであなたは十字キーに触れることなくvimでの編集ができることでしょう。
vimmerもこれ以上あなたの命を狙おうとはしないはずです。

## vscodeの拡張機能について

vscode上で選択した文字は、vimのvisualモードとなる.

## 気づき, 経験

- df{X} :これ凄い。dとf移動の組み合わせヤバイわ。
    ⇒ これ、もし一度で目的の位置まで消せなくとも、
    `.`で繰り返せるから、軽率にできるね。

- 5 + j/k で、適当にちょっと上下行きたい時に便利かも？
    数字は、押しやすいので構わない。

- 削除は、dwを連打するのが安パイ？

- 横移動は、基本`w/b ->末尾移動でe` でok.
- 途上だけど、上下は, H/L/M とjk, #*を駆使すれば、表示領域の移動は十分な気もする


## nvim

これvimでも使えるのかな？
:sp、:vsp
:sp（split）でウィンドウを上下に分割し、:vsp（vsplit）で左右に分割する。分割したウィンドウの移動は、Ctrl + wにプラスしてj, k, h, lで上下左右に移動でき、単純に次のウィンドウに移動するならCtrl + wを２回叩けばOK。

:tabnew
:tabnewで新しいタブをnvim上に作成し、gtで右のタブへ移動、gTで左のタブへ移動する。