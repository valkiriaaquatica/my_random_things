# Proxmox Virtual Environment VM Resource 
resource "proxmox_virtual_environment_vm" "youtube" {
  name        = var.vm_name
  description = var.vm_description
  node_name   = var.node_name
  vm_id       = var.vm_id
  tags        = var.vm_tags

  agent {
    enabled = var.agent_enabled
  }

  cpu {
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
    type    = var.cpu_type
  }

  memory {
    dedicated = var.memory_dedicated
  }


  network_device {
    bridge = var.network_bridge
    model  = var.network_model
    mtu    = var.mtu_value
  }
  

  operating_system {
    type = var.os_type
  }

  disk {
    replicate    = var.replicate_value # i would recommend to disable this
    datastore_id = var.disk_datastore_id
    file_format  = var.disk_file_format
    interface    = var.disk_interface
    size         = var.disk_size
  }

  # this is the cloud-init
  initialization {
    dns {
      servers  = var.dns_servers
    }
    ip_config {
      ipv4 {
        address = var.ipv4_address # if you want dhcp just place address = "dhcp"
        gateway = var.ipv4_gateway
      }
    }
  }

  # here we use the template we have already created 
  clone {
    vm_id = var.clone_vm_id 
    full  = var.clone_full # my recommendation to ALWAYS make a full clone
  }
}