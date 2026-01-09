resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.availability_zone
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}