.wellknownは、アプリケーションディレクトリから分離した、全く関係の無いディレクトリを指定するべき
⇒ アプリケーションの変更や、Nginxのリダイレクト設定の影響で、取得エラー等を引き起こす事がよくあるとのこと。

https://fand.jp/issuing-a-new-lets-encrypt-certificate-without-interruption-nginx/
location ^~ /.well-known/acme-challenge {
    root /path/to/doc_root/;
}


/usr/share/nginx/html


location /.well-known/acme-challenge/ {
    root /usr/share/nginx/certbot/<hogefuga!!>;
}