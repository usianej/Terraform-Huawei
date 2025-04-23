variable "region" {
  description = "The region where resources will be deployed"
  type        = string
}

variable "access_key" {
  description = "Access Key for Huawei Cloud"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Secret Key for Huawei Cloud"
  type        = string
  sensitive   = true
}

variable "image_map" {
  description = "Mapping of image names to their IDs"
  type        = map(string)
  default = {
    ubuntu2204 = "6bb66dc3-f3f8-4a35-9b6a-3627ba1fa2ac"
    ubuntu2004 = "ce36af6f-f9a7-4e17-b483-b2be51271673"
    windc2019  = "22d7f0fe-513e-4baf-9df8-0708b0bb6fff"
    cent77     = "e24338d1-d9b6-4e5a-9b47-4aee741eb40e"
  }
}

variable "subnet_map" {
  description = "Mapping of subnet names to their Network IDs"
  type        = map(string)
  default = {
    dev = "aed39ce2-2e95-402d-a515-79268f819c0c" # Dev CIDR Range
    staging = "2d0f8854-8fc5-48ff-8e14-da6701299c89" # Staging CIDR Range
  }
}

variable "vm_list" {
  description = "List of VMs to be created in this environment"
  type        = map(object({
    region            = string
    image_id          = string
    flavor_id         = string
    availability_zone = string
    network_id        = string
    security_groups   = list(string)
    user_data         = string
    system_disk_type  = string
    system_disk_size  = number
    data_disks        = list(object({
      type = string
      size = number
    }))
    fixed_ip_v4       = string
    tags              = map(string)
    agent_list        = string
    create_eip        = bool
    eip_bandwidth_size = number
  }))
}