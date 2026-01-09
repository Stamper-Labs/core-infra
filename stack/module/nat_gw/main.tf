resource "aws_nat_gateway" "this" {
  allocation_id = var.elastic_ip_id
  subnet_id     = var.public_subnet_id # This must be a *public* subnet normally; using same for simplicity
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}