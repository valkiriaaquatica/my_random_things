# LXC Template Creation with Ansible Roles

This project is structured into two Ansible roles:

1. **Template Creation (`template_creation`)**: Handles the creation of an LXC container from a predefined template
2. **Template Preparation (`template_preparation`)**: Configures the container, applies updates, installs packages, and converts it into a reusable LXC template

## Inventory

The roles use the following inventory structure:

```ini
[proxmox_nodes]
pve ansible_host=X.X.X.X
pve2 ansible_host=X.X.X.X

[container]
lxc ansible_host=X.X.X.X ansible_ssh_extra_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
```

## Playbook
```
---
- name: Role to create the template
  hosts: pve,lxc # place the node name of your inventory
  gather_facts: false
  become: false

  roles:
    - template_creation

- name: Role to configure the template
  hosts: container
  gather_facts: false
  become: false

  roles:
    - template_preparation
```

## Credentials
Make sure you have the proxmox endpoint, user and password to connect to Proxmox.