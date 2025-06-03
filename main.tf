module "vpc" {
  source                       = "./module/vpc"
  vpc_name_tag                 = "prod-vpc"
  subnet_availability_zone     = "us-east-1a"
  vpc_cidr_block               = "10.0.0.0/16"
  subnet_cidr_block            = "10.0.1.0/24"
  route_destination_cidr_block = "0.0.0.0/0"
  internet_gateway_name_tag    = "tnk-prod-vpc-igw"
  route_table_name_tag         = "tnk-prod-vpc-rt"
  subnet_name_tag              = "tnk-prod-vpc-snet-a"
  env_tag                      = "prod"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}
