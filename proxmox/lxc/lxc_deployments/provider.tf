terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  # Configuration options
  pm_tls_insecure = true
# export PM_API_URL="https://proxmox-homelab.homelab.com:8006/api2/json"
# export PM_USER="your_user@pve"
# export PM_PASS="your_password"

}