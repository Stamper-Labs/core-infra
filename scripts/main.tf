module "stamper_vpc" {
  source = "../module/vpc"
  vpc_cidr_block = "192.168.0.0/16"
  vpc_name_tag = "stamper_vpc"
}

module "stamper_internet_gw" {
  source = "../module/internet_gw"
  vpc_id = module.stamper_vpc.id
  internet_gw_name_tag = "stamper_internet_gw"
}

module "stamper_public_subnet_a" {
  source = "../module/subnet"
  vpc_id = module.stamper_vpc.id
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  subnet_name_tag = "stamper_public_subnet_a"
}

module "stamper_public_route_table" {
  source = "../module/route_table"
  vpc_id = module.stamper_vpc.id
  public_subnet_id = module.stamper_public_subnet_a.id
  internet_gw_id = module.stamper_internet_gw.id
  route_table_name_tag = "stamper_public_route_table"
}

module "stamper_private_subnet_b" {
  source = "../module/subnet"
  vpc_id = module.stamper_vpc.id
  cidr_block = "192.168.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
  subnet_name_tag = "stamper_private_subnet_b"
}

module "stamper_eip_vpc"{
  source = "../module/eip"
  domain = "vpc"
  eip_name_tag = "stamper_eip_vpc"
}

module "stamper_nat_gw" {
  source = "../module/nat_gw"
  elastic_ip_id = module.stamper_eip_vpc.id
  public_subnet_id = module.stamper_public_subnet_a.id
  nat_gw_name_tag = "stamper_nat_gw"
}

module "stamper_route_table_private" {
  source = "../module/route_table_private"
  vpc_id = module.stamper_vpc.id
  private_subnet_id = module.stamper_private_subnet_b.id
  nat_gateway_id = module.stamper_nat_gw.id
  route_table_name_tag = "stamper_route_table_private"
}

module "stamper_iam_openid_github_provider" {
  source = "../module/iam_openid"
  connector_url = "https://token.actions.githubusercontent.com"
  openid_client_id_list = ["sts.amazonaws.com"]
  openid_thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  openid_name_tag = "stamper_iam_openid_github_provider"
}

module "stamper_iam_role_ecs_tasks_execution" {
  source             = "../module/iam_role"
  role_name          = "StamperServiceRoleForECSTasksExecution"
  assume_role_policy = file("./policy/ecs-task-assume-policy.json")
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]
}

module "stamper_security_group_allow_http" {
  source         = "../module/security_group"
  sg_name        = "stamper_security_group_allow_http"
  sg_vpc_id      = module.stamper_vpc.id
  sg_description = "Security group for ecs clusters"
  sg_ingress_rules = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow Web" },
  ]
  sg_egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], description = "Allow all outbound" },
  ]
  env_tag = "base_infra"
}

module "stamper_policy_ecr_push_and_pull" {
  source            = "../module/iam_policy"
  policy_name       = "StamperECRPushPullPolicyForGitHubActions"
  policy_description = "ECR push and pull permissions for github actions"
  policy            = file("./policy/ecr-push-and-pull-policy.json")
}

module "stamper_iam_role_github_actions" {
  source             = "../module/iam_role"
  role_name          = "StamperServiceRoleForGitHubActions"
  assume_role_policy = file("./policy/github-assume-policy.json") # Update path if needed
  # apply twice module.std_ecr_iam_policy.iam_policy_arn to ensure it is created before use
  # policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", module.stamper_policy_ecr_push_and_pull.arn]
}