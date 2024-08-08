variable "os_source" {
  description = "The location of the source cloud image, used with the cloud-init image to deploy the nodes."
  type = string
  default = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
}

variable "pool_name" {
  description = "The name of pool."
  type = string
  default = "ubuntu"
}

variable "pool_type" {
  description = "The type of pool (dir - directory on the local file system)."
  type = string
  default = "dir"
}

variable "pool_path" {
  description = "The location of the pool storage."
  type = string
  default = "/tmp/terraform-provider-libvirt-pool-ubuntu"
}

variable "node_count" {
  description = "The number of nodes."
  type = number
  default = 1
}

variable "memory" {
  description = "The node's memory."
  type = string
  default = "2048"
}

variable "vcpu" {
  description = "The node's vcpu."
  type = number
  default = 1
}

variable "domain_name" {
  description = "The domain's name."
  type = string
  default = "ubuntu-terraform"
}

variable "size" {
  description = "The size in bytes of the disk."
  type = string
  default = "17179869184"  # 16 GB in bytes (16 * 1024 * 1024 * 1024)
}

variable "cloudinit_name" {
  description = "The name of cloudinit."
  type = string
  default = "commoninit.iso"
}

variable "network_name" {
  description = "The name of network."
  type = string
  default = "default"
}

variable "volume_name" {
  description = "The name of base volume."
  type = string
  default = "ubuntu-qcow2"
}

variable "volume_name_15gb" {
  description = "The name of volume with 15GB."
  type = string
  default = "ubuntu-15gb.qcow2"
}