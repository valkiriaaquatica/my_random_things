# Crossplane: Advantages, Disadvantages, and Use Cases

## 🛑 **Disadvantages of Crossplane**
- 🚫 **No equivalent to Terraform's `plan, test, validate..`:**
  - Crossplane does not generate a plan before applying changes.
- 🚫 **Limited support for complex logic:**
  - No built-in support for loops, advanced variables, or conditions. Tools like **Ansible** are better for these cases.
- 🚫 **Smaller enterprise support:**
  - It doesn't have a large backing company like HashiCorp.
- 🚫 **Not ideal outside Kubernetes:**
  - If you're not in a Kubernetes environment, **don't use it**. Crossplane is fully dependent on the cluster.

---

## ✅ **Advantages of Crossplane**
- **GitOps-ready:**
  - Fully compatible with tools like **ArgoCD**, **Flux**, and **Gitops**.
- **Kubernetes-native:**
  - Operates directly within the cluster, means that apps like **Rancher**, **Kubernetes Dashbord**
    are easy to monitored, apps and infrastracture.
- **Applications as Code (CaaC):**
  - Configure tools like **Jenkins**, **Keycloak**, and **Vault** without the need for external Ansible or Terraform workflows.
  - Services are accessible by name directly within the cluster.
- **Monitorization of Infrastractrue and Apps easily**: We have applciations and infrastructur in the
    same apps to be controlled and monitored.

---

## ⚖️ **Middle Ground**
- **State is stored in `etcd`:**
  - Unlike Terraform, which stores state in a `.tfstate` file, Crossplane relies on Kubernetes' **etcd**.

---

## 🌐 **Providers in Use**
- **Proxmox:** [provider-proxmoxve](https://github.com/dougsong/provider-proxmoxve)
- **AWS:** [provider-aws-s3 (v1.18.0)](https://marketplace.upbound.io/providers/upbound/provider-aws-s3/v1.18.0)
- **Keycloak:** [provider-keycloak](https://github.com/crossplane-contrib/provider-keycloak)

---

## 🔑 **Keycloak as Configuration as Code (CaaC)**

### **Create a Client with Ansible**
- Use the Ansible module:  
  [Keycloak Client](https://galaxy.ansible.com/ui/repo/published/middleware_automation/keycloak/content/module/keycloak_client/)

```yaml
- name: Create a Keycloak client
  hosts: localhost
  tasks:
    - name: Configure client
      middleware_automation.keycloak.keycloak_client:
        name: my-client
        realm: my-realm
        state: present
        url: https://keycloak.example.com
        user: admin
        password: password123
```

---

### **Create a Client with Crossplane**
- Use the Crossplane provider for Keycloak:  
  [Example configuration](https://github.com/crossplane-contrib/provider-keycloak/blob/main/examples/clients.yaml)

```yaml
apiVersion: keycloak.crossplane.io/v1alpha1
kind: Client
metadata:
  name: my-client
spec:
  forProvider:
    realm: my-realm
    clientId: my-client-id
    enabled: true
    standardFlowEnabled: true
    redirectUris:
      - https://my-app.example.com/callback
  providerConfigRef:
    name: keycloak-provider
```

---
