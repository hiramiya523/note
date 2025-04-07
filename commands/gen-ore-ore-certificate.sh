#!/bin/bash

# ドメイン名を指定
DOMAIN="hoge.example.com"

# 作成するファイルの名前
KEY_FILE="${DOMAIN}-key.pem"
CSR_FILE="${DOMAIN}.csr"
CERT_FILE="${DOMAIN}-cert.pem"

# 秘密鍵の作成
echo "Creating a private key..."
openssl genpkey -algorithm RSA -out $KEY_FILE -aes256
if [ $? -ne 0 ]; then
    echo "Failed to create a private key"
    exit 1
fi

# CSR（証明書署名要求）の作成
echo "Creating a certificate signing request (CSR)..."
openssl req -new -key $KEY_FILE -out $CSR_FILE -subj "/CN=${DOMAIN}"
if [ $? -ne 0 ]; then
    echo "Failed to create a CSR"
    exit 1
fi

# 自己署名証明書の作成
echo "Creating a self-signed certificate..."
openssl x509 -req -days 365 -in $CSR_FILE -signkey $KEY_FILE -out $CERT_FILE
if [ $? -ne 0 ]; then
    echo "Failed to create a self-signed certificate"
    exit 1
fi

echo "Self-signed certificate created successfully:"
echo "Private Key: $KEY_FILE"
echo "Certificate: $CERT_FILE"

# クリーンアップ
rm $CSR_FILE