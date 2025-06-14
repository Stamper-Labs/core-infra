# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.internet_gw_name_tag
  }
}