#!/bin/bash

# Directory where this script is located (should be the certs/ folder)
CERTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOMAIN="catchup-app.app"

# Certbot Renewal Command
# --pre-hook: Stops Nginx before renewal (required for standalone mode to bind port 80)
# --post-hook: Starts Nginx after renewal attempt is finished
# --deploy-hook: Copies the new certs to your project folder ONLY if renewal was successful

sudo certbot renew --quiet \
  --pre-hook "docker stop catchup-nginx" \
  --post-hook "docker start catchup-nginx" \
  --deploy-hook "cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem $CERTS_DIR/$DOMAIN.crt && cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $CERTS_DIR/$DOMAIN.key && echo 'Certificates renewed and copied.'"