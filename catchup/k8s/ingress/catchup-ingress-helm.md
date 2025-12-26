```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```
```bash
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace
```

```bash
helm upgrade nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.loadBalancerIP=35.222.238.219
```
```bash
helm upgrade nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.loadBalancerIP=35.222.238.219 \
  --set controller.admissionWebhooks.enabled=false
```

```bash
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --set startupapicheck.enabled=false

kubectl apply -f catchup/ingress/letsencrypt-issuer.yaml

# Create a directory to store them
mkdir -p certs

# Extract the Certificate (public key)
kubectl get secret catchup-me-tls -n ingress-ns -o jsonpath='{.data.tls\.crt}' | base64 --decode > certs/tls.crt

# Extract the Private Key
kubectl get secret catchup-me-tls -n ingress-ns -o jsonpath='{.data.tls\.key}' | base64 --decode > certs/tls.key

# Convert for Java (JKS/PKCS12)
openssl pkcs12 -export \
  -in certs/tls.crt \
  -inkey certs/tls.key \
  -out certs/keystore.p12 \
  -name catchup-alias \
  -passout pass:changeit
# To create a JKS file (Legacy):
keytool -importkeystore \
  -deststorepass changeit \
  -destkeypass changeit \
  -destkeystore certs/keystore.jks \
  -srckeystore certs/keystore.p12 \
  -srcstoretype PKCS12 \
  -srcstorepass changeit \
  -alias catchup-alias

helm uninstall cert-manager -n cert-manager

helm upgrade cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --set crds.enabled=true \
  --set startupapicheck.enabled=false \
  --set global.leaderElection.namespace=cert-manager \
  --set resources.requests.cpu=100m \
  --set resources.requests.memory=128Mi \
  --set webhook.resources.requests.cpu=100m \
  --set webhook.resources.requests.memory=128Mi \
  --set cainjector.resources.requests.cpu=100m \
  --set cainjector.resources.requests.memory=128Mi
```
```bash
```