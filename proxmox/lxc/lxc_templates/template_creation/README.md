
---

### `template_creation` Role Readme (`template_creation/README.md`)

```markdown
# Template Creation Role

This role is responsible for creating an LXC container from a predefined template in Proxmox. It also ensures the container
 is accessible via SSH and ready for further configuration (barely here here is the LXC template creation)

## Requirements

- Proxmox API access credentials.
- An existing Ubuntu 22.04 template in Proxmox.

## Role Variables

The following variables are used in this role:

- `admin_user_value`: Proxmox API username.
- `admin_user_password`: Proxmox API password.
- `pve_value`: Proxmox node where the container is created.
- `vmid`: VM ID for the new container.
- `container_ip`: Static IP address for the container.
- `dns_value`: DNS server address.
- `net_value`: Network bridge for the container.

These variables are loaded from `vars/credentials.yaml` and `vars/main.yaml` , for tthe credential just use ansible-vault to vault them

## Dependencies

This role requires the `community.general.proxmox` module for interacting with the Proxmox API.

## Example Playbook

```yaml
- name: Create and start LXC container
  hosts: all
  gather_facts: false
  roles:
    - template_creation
```

## Tasks Overview

- Creates the LXC container.
- Starts the container for making ot the configuration.
- Configures SSH access (copies `authorized_keys`).
- Sets facts for the next role.

## Inventory

The inventory should include Proxmox nodes (because is where commands are executed). It is important to use hosts: all because that way the role template_preparation can accesses the variables that are make in the set_fact. (for the Ansible fanatics, yes I can use hostvars but is easier this way hehe with small inventories)

```ini
[proxmox_nodes]
pve ansible_host=X.X.X.X
pve2 ansible_host=X.X.X.X
[container]
lxc ansible_host=X.X.X.X  ansible_ssh_extra_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"