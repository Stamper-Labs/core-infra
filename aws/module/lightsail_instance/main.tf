resource "aws_lightsail_instance" "this" {
  name              = var.name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  user_data         = var.user_data
  key_pair_name     = var.key_pair_name != "" ? var.key_pair_name : null
  tags = {
    Name = var.name
    Env = var.env_tag
  }
}