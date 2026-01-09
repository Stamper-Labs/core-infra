resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}