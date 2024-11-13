Aquí tienes el README.md estructurado en Markdown con instrucciones claras:

```markdown
# Ubuntu 22.04 Template Creation for Proxmox with Packer

This repository provides a Packer configuration to create an Ubuntu 22.04 template in Proxmox using Cloud-init.

## Prerequisites

Before running the configuration, ensure you have set up the necessary environment variables for security and configuration purposes. Export the following variables in your terminal:

```bash
export PACKER_PROXMOX_URL="https://proxmox-homelab.homelab.com:8006/api2/json"
export PACKER_PROXMOX_API_TOKEN_ID='root@pam!youtube'
export PACKER_PROXMOX_API_SECRET="0796951e-eafd-4483-aa8b-857c36921752"
```

## Commands to Validate and Buildd

Once the environment variables are alredy set, validate and build the configuration with the following commands:

```bash
packer validate ubuntu22.pkr.hcl
packer build ubuntu22.pkr.hcl
```

## Testing Connectivity During Build

To test connectivity to the VM during the build process, use `ping` or SSH (if enabled) to check if the VM is accessible
Also try to check for the machine executing packer in the port that packer exposes, if you can reach and see the suer-data file.
When DHCP you cannot because you dont' know the IP.

## Resources

- **ISO Download URL**: [Ubuntu 22.04 ISO](https://releases.ubuntu.com/jammy/)
- **Packer Installation Guide**: [Get Started with Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-startedget-started-install-cli)
- **Proxmox Packer Builder Documentation**: [Proxmox Integration](https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox)



### Network Configuration Requred

The VM will use the IP address defined in the `user-data` Cloud-init file, set to a static IP if configured or via DHCP if that line is commented out in `boot_command`.

---

Ensure your Proxmox node is accessible and has permission to execute the build. Customize the configuration as needed for your environment.
```
