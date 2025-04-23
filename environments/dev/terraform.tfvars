  region     = "af-south-1"
  access_key = "xxxx"
  secret_key = "xxxx"

    vm_list = {
    "dev-vm-01" = {
      region            = "af-south-1"
      image_id          = "ubuntu2204" # Use the name instead of the ID
      flavor_id         = "s6.medium.2"
      availability_zone = "af-south-1a"
      network_id        = "staging" # Use the name instead of the ID
      security_groups   = ["default"]
      user_data         = "scripts/cloud-config.yaml"
      system_disk_type  = "SATA"
      system_disk_size  = 60
      data_disks = [
        { type = "SATA", size = 100 },
        { type = "SATA", size = 200 }
      ]
      fixed_ip_v4       = "10.3.4.5"
      tags = {
        environment = "dev"
        team        = "cloud"
      }
      agent_list        = "ces,hss,hss-ent"
      create_eip        = true
      eip_bandwidth_size = 5
    },
    ####-----Dev VM 02-----#####
    "dev-vm-02" = {
    region            = "af-south-1"
    image_id          = "windc2019" # Use the name instead of the ID
    flavor_id         = "s6.large.4"
    availability_zone = "af-south-1b"
    network_id        = "staging"
    security_groups   = ["default"]
    user_data         = "scripts/cloud-config-win.yaml"
    system_disk_type  = "SSD"
    system_disk_size  = 100
    data_disks = [
      { type = "SSD", size = 200 }
    ]
    fixed_ip_v4       = "10.3.4.6"
    tags = {
      environment = "prod"
      team        = "cloud"
    }
    agent_list        = "ces,hss"
    create_eip        = false
    eip_bandwidth_size = 0
  }
  }