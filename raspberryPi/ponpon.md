# ponpon 

4F女子トイレ前に
養生テープのところが、スイッチになる。

ラスパいスティール
MJPG-Streamer

raspistill
-> 1マイパシャって。軽量だよ。

窓からの光で色差分があるのでは？
ー＞rinnkaku 
を検出して 

輪郭強調 convert
imagemagik -> linuxでよく使う。

ヒストグラム(phpもある)
で数値可して差分を出す（数値を
↓
もっといいライブラリは？
動態検知、差異とか
⇒opencvで

dytonにpostして、いるファイルをつく

## 調査

LANを通せないので、Wifiを使うしかない。

### 環境情報

cat /etc/debian_version
>9.4
root@ponpon:/var/log# cat /etc/issue
>Raspbian GNU/Linux 9 \n \l

cat /proc/version
Linux version 4.14.50+ (dc4@dc4-XPS13-9333) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1122 Tue Jun 19 12:21:21 BST 2018

python --version
Python 2.7.1お

 pip list
-bash: pip: コマンドが見つかりません

root@ponpon:/home# python
Python 2.7.13 (default, Nov 24 2017, 17:33:09)
[GCC 6.3.0 20170516] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import cv2
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: No module named cv2

vimあり

- apache2あり
systemctl status apache2
● apache2.service - The Apache HTTP Server

/home/pi/start_stream.sh
```sh
#!/bin/bash

# 1. pgrep mjpg_streamerを使って、mjpg_streamerというプロセスが既に実行中かどうかを確認します。
if pgrep mjpg_streamer > /dev/null
then
        echo "mjpg_streamer already running"
else
        # mjpg_streamer起動

        # LD_LIBRARY_PATHを指定し、必要なライブラリパスを設定します。
        # mjpg_streamerを起動して、カメラ入力プラグインinput_raspicam.soを使用し、15fpsの解像度640x480でストリームを生成します。
        # HTTP出力プラグインoutput_http.soを使用して、ポート9000でストリームを出力します。
        # 標準出力とエラー出力を/dev/nullにリダイレクトし、バックグラウンドでプロセスを実行します。
        LD_LIBRARY_PATH=/opt/mjpg-streamer/ /opt/mjpg-streamer/mjpg_streamer -i "input_raspicam.so -fps 15 -q 50 -x 640 -y 480" -o "output_http.so -p 9000 -w /opt/mjpg-streamer/www" > /dev/null 2>&1&
        echo "mjpg_streamer started"
fi
```

### 落ち原因は．．．？

システムログの確認を推奨．．．
/var/log/ ディレクトリ内のログファイル（例: syslog, messages, kern.log）を確認し、エラーメッセージがないかチェックしてください。
特にdmesg コマンドでカーネルログを確認することをお勧めします。

less /var/log/syslog
 => ???

 tail -f -n 100 kern.log.1
    -> ???


dmesg | grep -i error
dmesg | grep -i warn

### mjpeg-streamer

MJPG-Streamerは、Linux互換カメラの映像をWeb配信するためのアプリケーションです。カメラから直接JPEGデータを生成し、リアルタイムに高速なMJPGストリームを出力します。
MJPG-Streamerにより出力される動画は、ネットワーク経由でChrome、Safari、FirefoxなどのブラウザやVLC、mplayerのアプリで簡単に見ることができます。
もともと、CPUやメモリリソースの少ない組み込みデバイス向けに作成されたアプリです。ラズパイZeroのように小リソース機器で動画配信させるにはMJPG-Streamerがイチオシです。


### raspistill

raspistill -o test.jpg
root@ponpon:/home# ls
> pi  test.jpg


wsl 
sftp root@ponpon

get test.jpg
quit or bye
### rustビルド戦略
#### wsl上

<!-- WSL2のLinuxディストリビューション上で、ARMバイナリをエミュレート実行するためのqemu-user-staticとbinfmt_miscが設定されていることを確認します。 -->
sudo apt install -y binfmt-support qemu-user-static


docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

なぜ --privileged が必要？
    --privileged オプションは、/proc/sys/fs/binfmt_misc/ などのシステムパスに書き込みが必要だからです。
    これはホスト OS に QEMU エミュレーターを登録するために使われます。

--privileged	コンテナに特権モード（ホストのカーネル機能へのアクセス）を与える
multiarch/qemu-user-static	QEMU を使ったエミュレーション環境を提供する公式イメージ
--reset -p yes	QEMU のエミュレーションをホストに登録（binfmt_misc 経由）
これにより、他のアーキテクチャのバイナリを透過的に実行可能にする


なんかめんどくなってきたかも。
wsl上で直接できない？

ARG TARGET_ARCH=arm-linux-gnueabihf # Raspberry Pi Zero/1/2/3/4 (32bit) 向け
