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

## Option 2: ZeroSSL or other providers
You can download the CRT and Key files from your SSL provider and place them here with the expected names.
