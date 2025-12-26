# Deploy Catchup app development environment

## Instructions

1. Install nginx loadbalancer to route the traffic based on the domain and the subdomains between keycloak, service APIs and frontent
2. SSL for the domain and should works for subdomains as well
3. Install PostgreSQL to be used for Keycloak, make disk volume to store the data
4. Install Custom Keycloak image that include the SSL, make disk volume to store the data if needed
5. Install MongoDB to be used by the App services, make disk volume to store the data
6. Make sure that all these services are in same docker-compose network, make sure that the network is named catchup-network
7. Any correct and confirmed commands and steps, document them

## Development environment domains

1. catchup-app.app
2. dev.catchup-app.app
3. auth-dev.catchup-app.app
4. api-dev.catchup-app.app
5. partner-dev.catchup-app.app
