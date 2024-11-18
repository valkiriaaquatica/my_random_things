
# Variables for Proxmox VM Configuration

variable "vm_name" {
  description = "Name of the virtual machine"
  default     = "ubuntu4youtube"
}

variable "vm_description" {
  description = "Description of the virtual machine"
  default     = "Ubutnu 2204 machien created from template"
}

variable "node_name" {
  description = "Proxmox node name"
  default     = "pve2"
}

variable "mtu_value" { # if you deploy in vmbr0 you dont need to add this
  description = "MTU value for the network, in VXLAN is has to be <1450"
  type        = number 
  default     = 1450
}

variable "vm_id" {
  description = "ID of the virtual machine"
  default     = 256
}

variable "vm_tags" {
  description = "Tags for the VM"
  default     = ["terraform", "youtube", "test"]
}

variable "agent_enabled" {
  description = "Enable the Proxmox agent"
  default     = true
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  default     = 2
}

variable "cpu_sockets" {
  description = "Number of CPU sockets"
  default     = 1
}

variable "cpu_type" {
  description = "Type of CPU"
  default     = "host" # same as hypervisor
  # default     = "x86-64-v2-AES" # in case you will migrate mahcine for example
}

variable "memory_dedicated" {
  description = "Dedicated memory in MB"
  default     = 2048
}

variable "network_bridge" {
  description = "Network bridge"
  default     = "vtnet2"
}

variable "network_model" {
  description = "Network model"
  default     = "virtio"
}

variable "os_type" {
  description = "Operating system type"
  default     = "l26"
}

variable "replicate_value" {
  description = "If the disk shoudl be replicated in proxmox jobs"
  default     = false
}

variable "disk_datastore_id" {
  description = "Datastore ID for the disk"
  default     = "nas-homelab-synology"
}

variable "disk_file_format" {
  description = "Disk file format"
  default     = "qcow2"
}

variable "disk_interface" {
  description = "Disk interface"
  default     = "virtio0"
}

variable "disk_size" {
  description = "Disk size in GB"
  default     = 25
}

variable "dns_servers" {
  description = "List of DNS servers for the VMs"
  type        = list(string)
  default     = ["172.16.1.7"]
}

variable "ipv4_address" {
  description = "IPv4 address of the VM"
  default     = "172.16.3.33/24"
}

variable "ipv4_gateway" {
  description = "IPv4 gateway for the VM"
  default     = "172.16.3.1"
}


variable "clone_vm_id" {
  description = "VM ID of the template to clone from"
  default     = 255
}

variable "clone_full" {
  description = "Whether to make a full clone"
  default     = true
}

