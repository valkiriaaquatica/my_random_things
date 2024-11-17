
### `template_preparation` Role Readme (`template_preparation/README.md`)

```markdown
# Template Preparation Role

This role configures the newly created LXC container, installs required packages, and converts it into a reusable template. (barealy you can place whatever you want to configure the LXC here).

## Requirements

- The LXC container must already be created and accessible via SSH.

## Role Variables

- `packages_to_install`: List of packages to install (e.g., `nmap`, `git`, etc.).
- `user_name`: Name of the user to be created in the container.
- `user_password`: Password for the created user (hashed).
- `ssh_public_key`: Public key for the created user.

Important!! In the template_creation there is a final task who set_facts, that is VERY important
because those variables that are set facted are used here, to not write 2 times the variables, 
those variables are: `vmid` , `pve_value`, `admin_user_password`, `api_host`, `admin_user_value`, `pve_value`

## Dependencies

This role requires the `community.general.proxmox` module for interacting with the Proxmox API.

## Example Playbook

```yaml
- name: Configure and prepare LXC container as a template
  hosts: container
  gather_facts: false
  roles:
    - template_preparation
```

## Tasks Overview
### Here place what YOU want ;) this is just a basic setup

- Update and upgrades the containers package lists.
- Installs requireds packages.
- Creates a new user and configures SSH access.
- Stops the container.
- Converts the container into a Proxmox template.

## Inventory

The inventory should include the container: I use static IP because that way I can control
the IP that the LXC has, so when the template_creation creates the LXC this template_preparation role 
can quickly configured it.

```ini
[container]
lxc ansible_host=X.X.X.X ansible_ssh_extra_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
```