provider "huaweicloud" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vm" {
  for_each = var.vm_list
  source   = "../../modules/vm"

  name              = each.key
  image_id          = lookup(var.image_map, each.value.image_id) # Resolve the image ID dynamically
  flavor_id         = each.value.flavor_id
  availability_zone = each.value.availability_zone
  network_id        = lookup(var.subnet_map, each.value.network_id) # each.value.network_id
  security_groups   = each.value.security_groups
  user_data         = file(each.value.user_data) # Dynamically use user_data from vm_list
  fixed_ip_v4       = each.value.fixed_ip_v4
  system_disk_type  = each.value.system_disk_type
  system_disk_size  = each.value.system_disk_size
  data_disks        = each.value.data_disks
  tags              = each.value.tags
  agent_list        = each.value.agent_list
  create_eip        = each.value.create_eip
  eip_bandwidth_size = each.value.eip_bandwidth_size
}