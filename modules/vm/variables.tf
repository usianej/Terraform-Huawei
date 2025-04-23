variable "name" {
  description = "The name of the VM"
  type        = string
  default     = ""
}

variable "image_id" {
  description = "The ID of the image to use for the VM"
}

variable "flavor_id" {
  description = "The flavor ID (instance type) for the VM"
}

variable "availability_zone" {
  description = "The availability zone where the VM will be deployed"
}

variable "network_id" {
  description = "The ID of the network to attach to the VM"
}

variable "security_groups" {
  type = list(string)
}
variable "user_data" {
  type    = string
  default = ""
}

variable "agent_list" {
  type    = string
  default = ""
}

variable "tags" {
  description = "Tags to assign to the VM"
  type        = map(string)
  default     = {
    environment = "dev"
    team        = "cloud"
  }
}

variable "system_disk_type" {
  type    = string
  default = "SAS"  # or SATA/SSD
}

variable "system_disk_size" {
  description = "The size of the system disk in GB"
  type        = number
  default     = 40
  validation {
    condition     = var.system_disk_size > 0
    error_message = "System disk size must be greater than 0."
  }
}

variable "data_disks" {
  description = "A list of additional data disks to attach to the VM"
  type = list(object({
    type = string # The type of the disk (e.g., SATA, SSD)
    size = number # The size of the disk in GB
  }))
  default = []
}

variable "fixed_ip_v4" {
  description = "The fixed IPv4 address to assign to the VM"
  type        = string
  default     = null
}

variable "create_eip" {
  description = "Whether to create an Elastic IP for the VM"
  type        = bool
  default     = false
}

variable "eip_bandwidth_size" {
  description = "Bandwidth size for the Elastic IP"
  type        = number
  default     = 0
  validation {
    condition     = var.create_eip == false || var.eip_bandwidth_size > 0
    error_message = "EIP bandwidth size must be greater than 0 when create_eip is true."
  }
}