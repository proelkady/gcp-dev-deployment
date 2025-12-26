# Install Keycloak
```bash
helm install keycloak bitnami/keycloak \
  --namespace catchup-dev \
  -f catchup/deployment/keycloak-values.yaml
```

```bash
helm upgrade keycloak bitnami/keycloak \
  --namespace catchup-dev \
  -f catchup/deployment/keycloak-values.yaml
```