terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.66.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://proxmox-homelab.homelab.com:8006/" 
  insecure = true  
# export PROXMOX_VE_USERNAME="username@realm"
# export PROXMOX_VE_PASSWORD='a-strong-password'
}





