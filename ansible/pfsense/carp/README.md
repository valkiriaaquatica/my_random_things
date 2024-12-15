# Role Name: pfsense-caasc-carp

## Description

This Ansible role configures a High Availability (HA) setup for pfSense, including master and backup routers. The role automates interface configuration, security rules, CARP setup, NAT configuration, and DHCP server deployment.

## VERY IMPORTAT: high availability and virtual ip modules are STILL in dvelopment. In the future the role will include them and it will be easier

## Requirements

- `pfsensible.core` collection must be installed.
- Environment variable `ANSIBLE_JINJA2_NATIVE` must be set to `True`:
  ```bash
  export ANSIBLE_JINJA2_NATIVE=True
  ```
- A valid inventory (static or dynamic) specifying master and backup pfSense hosts.

## Role Variables

The following variables can be configured for this role:

- **Interfaces**:
  - `interfaces_master`: List of interface configurations for the master router.
  - `interfaces_backup`: List of interface configurations for the backup router.
- **State**:
  - `state_infra`: State of resources (`present` or `absent`).
- **CARP Configuration**:
  - `virtual_ips`: List of virtual IPs for CARP.
  - `carp_password`: Password for CARP synchronization.
- **DHCP**:
  - `interface_dhcp_lan`: LAN interface for DHCP.
  - `dhcp_range_from` / `dhcp_range_to`: DHCP IP range.
  - `gateway_dhcp`: Gateway for DHCP clients.
  - `failover_peerip_dhcp`: Peer IP for DHCP failover.

## Dependencies

This role requires the following:
- `pfsensible.core` for pfSense management.
- A dynamic inventory or static inventory specifying master and backup hosts.

## Example Inventory

**Static Inventory:**
```ini
[pfsense-main-server]
192.168.1.1

[pfsense-backup-server]
192.168.1.2
```

**Dynamic Inventory:**
You can use a dynamic inventory tool to automatically fetch and manage host data.

## Example Playbook

Here is an example of how to use the role:

```yaml
- name: Configure pfSense HA
  hosts: pfsense-main-server, pfsense-backup-server
  become: false
  gather_facts: false
  roles:
    - pfsense-caasc
```