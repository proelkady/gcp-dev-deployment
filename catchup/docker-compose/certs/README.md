# SSL Certificates

To generate a self-signed wildcard certificate for local development that covers `catchup-app.app` and all subdomains (like `auth-dev.catchup-app.app`), run the provided script:

```bash
cd certs
chmod +x gen-self-signed.sh
./gen-self-signed.sh
```

This will create:
- `catchup-app.app.crt`
- `catchup-app.app.key`

These files are automatically mapped into the Nginx container.

**Note:** Since this is a self-signed certificate, your browser will show a warning. You can proceed past it for development purposes.
