resource "huaweicloud_compute_instance" "this" {
  name              = var.name
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  availability_zone = var.availability_zone
  security_groups   = var.security_groups
  agent_list        = var.agent_list
  tags              = var.tags
  system_disk_type  = var.system_disk_type
  system_disk_size  = var.system_disk_size


  dynamic "data_disks" {
    for_each = var.data_disks
    content {
      type = data_disks.value.type
      size = data_disks.value.size
    }
  }

  network {
    uuid        = var.network_id
    fixed_ip_v4 = var.fixed_ip_v4
  }

  user_data = var.user_data
}

# Create an Elastic IP if create_eip is true
resource "huaweicloud_vpc_eip" "this" {
  count = var.create_eip ? 1 : 0

  publicip {
    type = "5_bgp" # Specify the type of public IP
  }

  bandwidth {
    name       = "${var.name}-bandwidth"
    size       = var.eip_bandwidth_size
    share_type = "PER"
  }
}

# Associate the Elastic IP with the VM
resource "huaweicloud_vpc_eip_associate" "this" {
  count      = var.create_eip ? 1 : 0
  public_ip  = huaweicloud_vpc_eip.this[0].address
  port_id    = huaweicloud_compute_instance.this.network[0].port
}