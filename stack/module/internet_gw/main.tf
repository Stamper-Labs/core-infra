# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}