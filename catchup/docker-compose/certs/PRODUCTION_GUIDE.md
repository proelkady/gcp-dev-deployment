# Production SSL Certificates (Let's Encrypt)

If you are deploying this to a public server (e.g., GCP VM) and want valid SSL certificates (no browser warnings), you should use Let's Encrypt.

## Option 1: Certbot (Recommended)

1. Install Certbot on the host machine.
2. Run Certbot to generate certificates for your domains:
   ```bash
   sudo certbot certonly --standalone -d catchup-app.app -d *.catchup-app.app
   ```
   *Note: Wildcard certificates require DNS validation. You will need to add a TXT record to your Squarespace DNS settings during this process.*

3. Copy the generated certificates to this `certs/` directory and rename them to match the Nginx config:
   - `fullchain.pem` -> `catchup-app.app.crt`
   - `privkey.pem` -> `catchup-app.app.key`

### Setup SSL

```bash
sudo apt-get update
sudo apt-get install certbot -y
sudo certbot certonly --manual --preferred-challenges dns -d catchup-app.app -d "*.catchup-app.app"

Please deploy a DNS TXT record under the name:

_acme-challenge.catchup-app.app.

with the following value:

PkmVbK8g4o_W_iMRffGG9y9zNhYb3haV0wA6mKakgog
```

### Automatic Renewal (Cron Job)

Since Let's Encrypt certificates expire every 90 days, you should set up a cron job to renew them automatically.

1. Make the renewal script executable:

   ```bash
   chmod +x certs/renew-certs.sh
   ```

2. Open the crontab editor:

   ```bash
   sudo crontab -e
   ```

3. Add the following line to run the check daily at 3:00 AM:

   ```cron
   0 3 * * * /path/to/your/project/certs/renew-certs.sh >> /var/log/cert-renew.log 2>&1
   ```

## Option 2: ZeroSSL or other providers

You can download the CRT and Key files from your SSL provider and place them here with the expected names.
