module "stamper_vpc" {
  source         = "../module/vpc"
  vpc_cidr_block = "192.168.0.0/16"
  vpc_name_tag   = "stamper-vpc"
  env_tag        = "core-infra"
}

module "stamper_vpc_internet_gw" {
  source               = "../module/internet_gw"
  vpc_id               = module.stamper_vpc.id
  internet_gw_name_tag = "stamper-vpc-internet-gw"
  env_tag              = "core-infra"
  depends_on           = [module.stamper_vpc]
}

module "stamper_vpc_subnet_a_public" {
  source                  = "../module/subnet"
  vpc_id                  = module.stamper_vpc.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  subnet_name_tag         = "stamper-vpc-subnet-a-public"
  env_tag                 = "core-infra"
  depends_on              = [module.stamper_vpc]
}

module "stamper_vpc_route_table" {
  source               = "../module/route_table"
  vpc_id               = module.stamper_vpc.id
  public_subnet_id     = module.stamper_vpc_subnet_a_public.id
  internet_gw_id       = module.stamper_vpc_internet_gw.id
  route_table_name_tag = "stamper-vpc-route-table"
  env_tag              = "core-infra"
  depends_on = [
    module.stamper_vpc_subnet_a_public,
    module.stamper_vpc_internet_gw
  ]
}

module "stamper_vpc_subnet_b_private" {
  source                  = "../module/subnet"
  vpc_id                  = module.stamper_vpc.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  subnet_name_tag         = "stamper-vpc-subnet-b-private"
  env_tag                 = "core-infra"
  depends_on              = [module.stamper_vpc]
}

module "stamper_vpc_elastic_ip" {
  source       = "../module/eip"
  domain       = "vpc"
  eip_name_tag = "stamper-vpc-elastic-ip"
  env_tag      = "core-infra"
}

module "stamper_vpc_nat_gw" {
  source           = "../module/nat_gw"
  elastic_ip_id    = module.stamper_vpc_elastic_ip.id
  public_subnet_id = module.stamper_vpc_subnet_a_public.id
  nat_gw_name_tag  = "stamper-vpc-nat-gw"
  env_tag          = "core-infra"
  depends_on = [
    module.stamper_vpc_elastic_ip,
    module.stamper_vpc_subnet_a_public
  ]
}

module "stamper_vpc_route_table_private" {
  source               = "../module/route_table_private"
  vpc_id               = module.stamper_vpc.id
  private_subnet_id    = module.stamper_vpc_subnet_b_private.id
  nat_gateway_id       = module.stamper_vpc_nat_gw.id
  route_table_name_tag = "stamper-vpc-route-table-private"
  env_tag              = "core-infra"
  depends_on = [
    module.stamper_vpc_nat_gw,
    module.stamper_vpc_subnet_b_private
  ]
}

module "stamper_vpc_security_group" {
  source         = "../module/security_group"
  sg_name        = "stamper-vpc-security-group"
  sg_vpc_id      = module.stamper_vpc.id
  sg_description = "Security group for ecs clusters"
  sg_ingress_rules = [
    { from_port = 1984, to_port = 1984, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow cnd-onboarding-api" },
  ]
  sg_egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], description = "Allow all outbound" },
  ]
  env_tag    = "core-infra"
  depends_on = [module.stamper_vpc]
}

module "github_provider_openid" {
  source                 = "../module/iam_openid"
  connector_url          = "https://token.actions.githubusercontent.com"
  openid_client_id_list  = ["sts.amazonaws.com"]
  openid_thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  openid_name_tag        = "github-provider-open-id"
  env_tag                = "core-infra"
}

module "stamper_policy_github_actions_provision" {
  source             = "../module/iam_policy"
  policy_name        = "StamperGitHubActionsProvisioningPolicy"
  policy_description = "IAM permissions required by StamperServiceRoleForGitHubActions to provision and manage AWS resources via Terraform."
  policy             = file("./policy/github-actions-provision-policy.json")
}

module "stamper_role_github_actions" {
  source             = "../module/iam_role"
  role_name          = "StamperServiceRoleForGitHubActions"
  assume_role_policy = file("./policy/github-actions-assume-policy.json")
  policy_arns = {
    s3_full_access = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    github_actions_provision  = module.stamper_policy_github_actions_provision.arn
  }
  env_tag = "core-infra"
}

module "stamper_cnd_onboarding_api_ecr" {
  source          = "../module/ecr"
  repository_name = "stamper/cnd-onboarding-api"
  env_tag         = "core-infra"
}

module "cnd_ecs_cluster_staging" {
  source       = "../module/ecs"
  cluster_name = "cnd-ecs-cluster-staging"
  env_tag      = "staging"
}