provider "aws" {
  region  = "us-east-1"
  profile = "owners-virginia"
  alias   = "virginia"
}

module "stamper_ligthsail_vps_ssh_key" {
  source       = "../../module/ssh_key"
  name     = "stamper-ligthsail-vps-ssh-key"
  public_key_path = ""  # leave empty to auto-generate
  providers = {
    aws = aws.virginia
  }
}

module "stamper_lightsail_vps" {
  source = "../../module/lightsail_instance"
  name              = "stamper-lightsail-vps"
  availability_zone = "us-east-1a"
  blueprint_id      = "amazon_linux_2023"
  bundle_id         = "small_2_0"
  key_pair_name     = module.stamper_ligthsail_vps_ssh_key.name
  env_tag = "core-infra"
  providers = {
    aws = aws.virginia
  }
}

resource "local_file" "ansible_inventory" {
  filename = "./dist/inventory.ini"
  content = <<-EOT
    [lightsail]
    stamper-vps ansible_host=${module.stamper_lightsail_vps.public_ip_address} ansible_user=ec2-user ansible_ssh_private_key_file=./dist/stamper-ligthsail-vps-ssh-key_private.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  EOT

  depends_on = [module.stamper_lightsail_vps]
}