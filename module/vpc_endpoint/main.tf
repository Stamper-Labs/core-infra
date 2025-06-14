resource "aws_vpc_endpoint" "this" {
  vpc_id            = var.vpc_id
  service_name      = var.service_name
  vpc_endpoint_type = var.vpc_endpoint_type
  subnet_ids        = var.subnet_ids
  security_group_ids = var.security_group_ids
  tags = {
    Name = var.vpc_endpoint_name_tag
    Env  = var.env_tag
  }
}