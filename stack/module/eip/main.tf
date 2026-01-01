resource "aws_eip" "this" {
  domain = var.domain
  tags = {
    Name = var.eip_name_tag
    Env = var.env_tag
  }
}