output "instance_id" {
  description = "The ID of the created instance"
  value       = huaweicloud_compute_instance.this.id
}

output "name" {
  description = "The name of the created instance"
  value       = huaweicloud_compute_instance.this.name
}

output "fixed_ip_v4" {
  description = "The fixed IPv4 address of the instance"
  value       = huaweicloud_compute_instance.this.network[0].fixed_ip_v4
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = huaweicloud_compute_instance.this.availability_zone
}

output "tags" {
  description = "Tags assigned to the instance"
  value       = huaweicloud_compute_instance.this.tags
}

output "eip_address" {
  description = "The Elastic IP address of the instance (if created)"
  # Return the EIP address if the resource exists, otherwise return null
  value       = length(huaweicloud_vpc_eip.this) > 0 ? huaweicloud_vpc_eip.this[0].address : null
}