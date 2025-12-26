#!/bin/bash

# Create a configuration file for OpenSSL
cat > openssl.cnf <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
x509_extensions = v3_req

[dn]
C = SA
ST = Dev
L = Dev
O = Catchup
CN = *.catchup-app.app

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = catchup-app.app
DNS.2 = *.catchup-app.app
EOF

# Generate the certificate and key
openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes \
  -keyout catchup-app.app.key -days 3650 \
  -out catchup-app.app.crt \
  -config openssl.cnf

# Clean up
rm openssl.cnf

echo "Certificate (catchup-app.app.crt) and Key (catchup-app.app.key) generated."
