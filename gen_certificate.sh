#!/bin/sh

[ "$#" -ne 1 ] && echo "Usage: $0 <domain_name>" >&2 && exit 1

[ -d ssl ] && echo " [!] Folder ssl already exists, not overwriting" >&2 && exit 2

mkdir ssl
cd ssl

sed "s/domain.com/$1/" ../openssl_template.cnf > openssl.cnf

openssl req -new -x509 -config openssl.cnf -batch -keyout server.key -out server.pem

echo "Certificate ready, now just docker run -v $(pwd):/etc/dovecot/ssl/ [...]"
