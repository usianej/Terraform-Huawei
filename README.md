# VM Module

This module provisions virtual machines on Huawei Cloud.

## Overview

The VM module is designed to dynamically provision virtual machines on Huawei Cloud. It supports features such as:
- Configurable system and data disks.
- Elastic IP (EIP) creation and bandwidth configuration.
- Cloud-init user data for VM initialization.
- Flexible tagging and security group assignment.

---

## Prerequisites

- Terraform v1.0 or later.
- Huawei Cloud credentials (Access Key and Secret Key).
- Permissions to create compute instances, networks, and Elastic IPs.

---

## Inputs

| Name                | Description                              | Type          | Default   | Required |
|---------------------|------------------------------------------|---------------|-----------|----------|
| `name`              | The name of the VM                      | `string`      |           | yes      |
| `image_id`          | The ID of the image to use for the VM    | `string`      |           | yes      |
| `flavor_id`         | The flavor ID (instance type) for the VM | `string`      |           | yes      |
| `availability_zone` | The availability zone for the VM         | `string`      |           | yes      |
| `network_id`        | The ID of the network to attach to the VM| `string`      |           | yes      |
| `security_groups`   | A list of security groups for the VM     | `list(string)`| `[]`      | no       |
| `user_data`         | Path to the cloud-init user data script  | `string`      | `""`      | no       |
| `agent_list`        | A comma-separated list of agents to install | `string`   | `""`      | no       |
| `tags`              | Tags to assign to the VM                | `map(string)` | `{}`      | no       |
| `system_disk_type`  | The type of the system disk              | `string`      | `"SAS"`   | no       |
| `system_disk_size`  | The size of the system disk in GB        | `number`      | `40`      | no       |
| `data_disks`        | A list of additional data disks          | `list(object)`| `[]`      | no       |
| `fixed_ip_v4`       | The fixed IPv4 address to assign to the VM | `string`    | `null`    | no       |
| `create_eip`        | Whether to create an Elastic IP          | `bool`        | `false`   | no       |
| `eip_bandwidth_size`| Bandwidth size for the Elastic IP        | `number`      | `0`       | no       |

---

## Outputs

| Name             | Description                                |
|------------------|--------------------------------------------|
| `instance_id`    | The ID of the created instance             |
| `name`           | The name of the created instance           |
| `fixed_ip_v4`    | The fixed IPv4 address of the instance      |
| `availability_zone` | The availability zone of the instance    |
| `tags`           | Tags assigned to the instance              |
| `eip_address`    | The Elastic IP address of the instance (if created) |

---

## Image Mapping

The `image_id` field in the `vm_list` variable accepts image names instead of raw image IDs. These names are mapped to their corresponding IDs using the `image_map` variable.

### Supported Image Names and IDs

| Image Name   | Description               | Image ID                                |
|--------------|---------------------------|-----------------------------------------|
| `ubuntu2204` | Ubuntu 22.04              | `6bb66dc3-f3f8-4a35-9b6a-3627ba1fa2ac` |
| `ubuntu2004` | Ubuntu 20.04              | `ce36af6f-f9a7-4e17-b483-b2be51271673` |
| `windc2019`  | Windows Server 2019       | `22d7f0fe-513e-4baf-9df8-0708b0bb6fff` |
| `cent77`     | CentOS 7.7                | `e24338d1-d9b6-4e5a-9b47-4aee741eb40e` |

To use an image, specify its name (e.g., `ubuntu2204`) in the `image_id` field of the `vm_list` variable.

---

## Example Usage

```hcl
module "vm" {
  source = "../../modules/vm"

  name              = "example-vm"
  image_id          = "ubuntu2204" # Use the name instead of the raw image ID
  flavor_id         = "s6.medium.2"
  availability_zone = "af-south-1a"
  network_id        = "vpc-id"
  security_groups   = ["default"]
  user_data         = "scripts/bootstrap.sh"
  fixed_ip_v4       = "192.168.1.100"
  system_disk_type  = "SATA"
  system_disk_size  = 60
  data_disks = [
    { type = "SATA", size = 100 },
    { type = "SATA", size = 200 }
  ]
  tags = {
    environment = "dev"
    team        = "cloud"
  }
  agent_list        = "ces,hss,hss-ent"
  create_eip        = true
  eip_bandwidth_size = 5
}

## Issues

- Unable to set windows server password.
