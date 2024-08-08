# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}
# qemu - hipervisor
# system - connect as user of system

resource "libvirt_pool" "ubuntu" {
  name = var.pool_name
  type = var.pool_type
  path = var.pool_path
}

# Fetch the latest ubuntu release image from their mirrors
resource "libvirt_volume" "ubuntu-qcow2" {
  name        = var.volume_name
  pool        = var.pool_name
  source      = var.os_source
  format      = "qcow2"
  depends_on  = [libvirt_pool.ubuntu]                                           

}

# Create new volume with 15 GB
resource "libvirt_volume" "ubuntu-15gb" {
  name            = var.volume_name_15gb
  pool            = var.pool_name
  base_volume_id  = libvirt_volume.ubuntu-qcow2.id
  size            = var.size 
  depends_on      = [libvirt_pool.ubuntu]                                           

}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

# for more info about paramater check this out
# https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
# Use CloudInit disk to add our ssh-key to the instance
# you can add also meta_data field
resource "libvirt_cloudinit_disk" "commoninit" {
  name           = var.cloudinit_name
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool            = var.pool_name
  # pool   = libvirt_pool.ubuntu.name
}

# Create the virtual machine
resource "libvirt_domain" "domain-ubuntu" {
  count  = var.node_count
  name   = var.domain_name
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name = var.network_name
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"

  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.ubuntu-15gb.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  # wait for vm to be created
  depends_on = [libvirt_volume.ubuntu-15gb]


  autostart = true
}

