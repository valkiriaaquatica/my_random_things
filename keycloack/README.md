### Estilo Markdown para el README:

```markdown
# OAuth2 Proxy with Keycloak on Kubernetes

## 1. Deploy Keycloak

First, you need a Keycloak instance deployed. In this example, we are using Kubernetes and Helm. You can find the Keycloak Helm chart here:

[Keycloak Helm Chart](https://artifacthub.io/packages/helm/bitnami/keycloak)

## 2. Install OAuth2 Proxy

Next, install OAuth2 Proxy. We are also using Helm to manage the installation. You can find the Helm values for OAuth2 Proxy here:

[OAuth2 Proxy Helm Values](https://github.com/oauth2-proxy/manifests/blob/main/helm/oauth2-proxy/values.yaml)

## 3. Configure OAuth2 Proxy

Below is a basic configuration for OAuth2 Proxy that protects applications **without a default login**.

```yaml
clientID: "your_client_id"
clientSecret: "your_client_secret"
cookieName: "oauth2-proxy-ansible"
cookieSecret: "a_simple_cookie" # generate it with: openssl rand -base64 32 | head -c 32 | base64
cookieName: "cookie_name"
configFile: |-
  provider="keycloak-oidc"
  provider_display_name="Keycloak"
  redirect_url="https://oauth2-proxy-dev.homelab.com/oauth2/callback"
  oidc_issuer_url="https://keycloack-dev.homelab.com/realms/test-caasc-ansible"
  code_challenge_method="S256"
  ssl_insecure_skip_verify=true
  http_address="0.0.0.0:4180"
  email_domains=["*"]
  cookie_domains=[".homelab.com"]
  cookie_secure=true
  scope="openid"
  whitelist_domains=[".homelab.com"]
  insecure_oidc_allow_unverified_email="true"
  cookie_samesite="none"
  silence_ping_logging=true
```

## 4. Configure Keycloak

Follow the steps in the video to configure the Keycloak client, realm, users, and LDAP integration. 
Remembe  to adjust the variables in the Ansible playbook and run it:

```bash
ansible-playbook main.yml -v
```

## 5. Add Annotations to the Ingress, in this case nginx, traefik has others (better nginx :S )

To protect your no login apps with OAuth2 Proxy, add the following annotations to your **Ingress**:

```yaml
nginx.ingress.kubernetes.io/auth-signin: https://your_oauth2_proxy_endpoint.com/oauth2/start?rd=https://$host$request_uri
nginx.ingress.kubernetes.io/auth-url: http://oauth2-proxy.oauth2-proxy.svc.cluster.local/oauth2/auth  # make sure to adjust this to youur service
nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"
nginx.ingress.kubernetes.io/auth-response-headers: Authorization
```

These annotations configure NGINX to handle authentication requests via OAuth2 Proxy, protecting your application behind Keycloak and OAuth2 Proxy.
