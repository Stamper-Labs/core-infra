resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name_tag
    Environment = var.env_tag
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.subnet_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name        = var.subnet_name_tag
    Environment = var.env_tag
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name        = var.internet_gateway_name_tag
    Environment = var.env_tag
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name        = var.route_table_name_tag
    Environment = var.env_tag
  }
}

resource "aws_route" "this" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = var.route_destination_cidr_block
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}
