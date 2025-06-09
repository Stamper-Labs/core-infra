module "vpc" {
  source                       = "../../module/vpc"
  vpc_name_tag                 = "stamper-labs-prod-vpc"
  subnet_availability_zone     = "us-east-1a"
  vpc_cidr_block               = "10.0.0.0/16"
  subnet_cidr_block            = "10.0.1.0/24"
  route_destination_cidr_block = "0.0.0.0/0"
  internet_gateway_name_tag    = "tnk-prod-vpc-igw"
  route_table_name_tag         = "tnk-prod-vpc-rt"
  subnet_name_tag              = "tnk-prod-vpc-snet-a"
  env_tag                      = "prod"
}

module "s3" {
  source = "../../module/s3"
  s3_bucket_name = "stamper-labs-policies-bucket"
  env_tag = "prod"
}

module "iam_openid_github" {
  source = "../../module/iam_openid"
  connector_url = "https://token.actions.githubusercontent.com"
  openid_client_id_list = ["sts.amazonaws.com"]
  openid_thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  env_tag = "prod"
}
output "policies_bucket_name" {
  value = module.s3.bucket_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

output "oidc_github_provider_arn" {
  value = module.iam_openid_github.oidc_provider_arn
}