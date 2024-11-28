
# **TALOS VERY SIMPLE TUTORIAL**

## **Initial Setup Fro deplying a simple 3 node cluster**

#### Prerequistes
- Have deployed 3 Talos Machines
- Talosctl installed in your enviroment
- K9s is a plus always
- Kubectl installed
- Helm installed (not compolsary)

### Customize the values for Master and Worker nodes:
```bash
export MASTER_1=ip
export WORKER_1=ip
export WORKER_2=ip
```

---

## **Generating Configuration**
1. Generate secrets:
   ```bash
   talosctl gen secrets
   ```

2. Generate configuration files:
   ```bash
   talosctl gen config proxmox-cluster https://$MASTER_1:6443 \
   --with-secrets secrets.yaml \
   --config-patch @customs/custom.yml \
   --output output_config
   ```

---

## **Applying Configuration**
1. Apply configuration to the Master node:
   ```bash
   talosctl apply-config -f output_config/controlplane.yaml -n $MASTER_1 --insecure
   ```

2. Apply configuration to the Worker nodes:
   ```bash
   talosctl apply-config -f output_config/worker.yaml -n $WORKER_1 --insecure
   talosctl apply-config -f output_config/worker2.yaml -n $WORKER_2 --insecure
   ```

---

## **Talosctl Configuration and cluster Bootin**
1. Export the Talos configuration:
   ```bash
   export TALOSCONFIG=output_config/talosconfig
   ```

2. List the current contexts:
   ```bash
   talosctl config contexts
   ```

3. Set the Master endpoint:
   ```bash
   talosctl config endpoint $MASTER_1
   ```

4. Access the Talos Dashboard:
   ```bash
   talosctl dashboard -n $MASTER_1
   ```

5. Bootstrap the cluster:
   ```bash
   talosctl bootstrap -n $MASTER_1
   ```

6. Retrieve the Kubeconfig file:
   ```bash
   talosctl kubeconfig -n $MASTER_1
   ```
7. (optional) Remove a node from the cluster
   ```bash
   talosctl -n IP reset
   ```
---

## **Updating Configurations**
To apply changes to a specific node:
```bash
talosctl apply-config -f output_config/controlplane.yaml -n <NODE_IP>
```

**Note:** Do not use `--insecure` for subsequent updates.

---

## **Installation Test**
1. Install MetalLB using Helm:
   ```bash
   helm install metallb metallb/metallb --namespace metallb-system --create-namespace
   ```
