# Route Table
resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gw_id
  }
  tags = {
    Name = var.route_table_name_tag
    Env = var.env_tag
  }
}

# Associate Public Route Table with Subnet
resource "aws_route_table_association" "this" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.this.id
}