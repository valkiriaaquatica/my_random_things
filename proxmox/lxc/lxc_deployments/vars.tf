variable "target_node" {
  description = "The Proxmox node where the LXC container will be created"
  type        = string
  default     = "pve2"
}

variable "hostname" {
  description = "The hostname for the LXC container"
  type        = string
  default     = "terraform-ansible-lxc"
}

variable "clone_template" {
  description = "The VMID of the template to clone"
  type        = string
  default     = "217"
}

# variable "swap_values" {
#   description = "Amount of SWAOP used, enabled is 512MB"
#   type        = string
#   default     = "512" # dependes on your memory and if you want to control oom problems
                        # in my case i use hdd which is NOT  good for swap ://
# }
variable "tags" {
  description = "TTags for labelling the container"
  type        = string
  default     = "terraform;ansible"
}

variable "nameserver" {
  description = "The nameserver for the LXC container"
  type        = string
  default     = "172.16.1.7"
}

variable "cores" {
  description = "Number of CPU cores assigned to the LXC container"
  type        = number
  default     = 1
}

variable "networok_if" {
  description = "The name of the itnerace"
  type        = string
  default     = "eth0"
}

variable "memory" {
  description = "Amount of RAM (in MB) allocated to the LXC container"
  type        = number
  default     = 1024
}

variable "rootfs_storage" {
  description = "Storage for the root filesystem of the LXC container"
  type        = string
  default     = "hdd"
}

variable "rootfs_size" {
  description = "Size of the root filesystem (e.g., 10G)"
  type        = string
  default     = "10G"
}

variable "network_bridge" {
  description = "The bridge interface for the container's network"
  type        = string
  default     = "vnet1"
}

variable "network_ip" {
  description = "The static IP address of the LXC container (with CIDR)"
  type        = string
  default     = "172.16.2.102/24"
}

variable "network_gw" {
  description = "The gateway for the containers network"
  type        = string
  default     = "172.16.2.1"
}

variable "network_mtu" {
  description = "The MTU for the container's network interface" # just for my case i have adjust the mtu in my vxlan
  type        = number
  default     = 1450
}
