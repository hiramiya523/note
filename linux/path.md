- 「/bin」「/usr/bin」「/usr/local/bin」ディレクトリの使い分けについて。
  - /bin
    シングルユーザモードで利用するコマンド
    OSが壊れた時の非常用コマンド

  - /usr/bin
    Rpmや、Deb等のパッケージ管理で管理されるもの
  
  - /usr/local/bin
    上記2つに当てはまらないプログラム。
    自作なんかはここに置かれる。

「/sbin」「/usr/sbin」「/usr/local/sbin」のディレクトリも基本的に同じ関係性です。
「sbin」はシステム管理用のコマンドやプログラム。