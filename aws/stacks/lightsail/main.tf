module "stamper_ligthsail_vps_ssh_key" {
  source       = "../../module/ssh_key"
  name     = "stamper-ligthsail-vps-ssh-key"
  public_key_path = ""  # leave empty to auto-generate
}

module "stamper_lightsail_vps" {
  source = "../../module/lightsail_instance"
  name              = "stamper-lightsail-vps"
  availability_zone = "us-east-1a"
  blueprint_id      = "amazon_linux_2023"
  bundle_id         = "small_2_0"
  key_pair_name     = module.stamper_ligthsail_vps_ssh_key.name
  user_data         = <<-EOT
    #!/bin/bash
    apt update && apt install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOT
  env_tag = "core-infra"
}