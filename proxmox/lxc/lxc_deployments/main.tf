resource "proxmox_lxc" "lxc-terraform" {
  target_node  = var.target_node
  hostname     = var.hostname
  clone        = var.clone_template
  unprivileged = true
  start        = true
  full         = true
  nameserver   = var.nameserver
  cores        = var.cores
  memory       = var.memory
  tags         = var.tags
#   swap         = var.swap_values

  rootfs {
    storage = var.rootfs_storage
    size    = var.rootfs_size
  }

  network {
    name   = var.networok_if
    bridge = var.network_bridge
    ip     = var.network_ip
    gw     = var.network_gw
    mtu    = var.network_mtu
  }

  features {
    nesting = true
  }
}
