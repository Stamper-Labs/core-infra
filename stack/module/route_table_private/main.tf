# Route Table
resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}

# Associate Public Route Table with Subnet
resource "aws_route_table_association" "this" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.this.id
}