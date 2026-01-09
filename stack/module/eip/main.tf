resource "aws_eip" "this" {
  domain = var.domain
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}