module "stamper_vpc" {
  source         = "../../module/vpc"
  vpc_cidr_block = "192.168.0.0/16"
  stack_tag      = "base_optimized"
  tf_name_tag = "stamper_vpc"
}

module "stamper_vpc_internet_gw" {
  source               = "../../module/internet_gw"
  vpc_id               = module.stamper_vpc.id
  stack_tag      = "base_optimized"
  tf_name_tag = "stamper_vpc_internet_gw"
  depends_on           = [module.stamper_vpc]
}

module "stamper_vpc_subnet_a_public" {
  source                  = "../../module/subnet"
  vpc_id                  = module.stamper_vpc.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  stack_tag      = "base_optimized"
  tf_name_tag = "stamper_vpc_subnet_a_public"
  depends_on              = [module.stamper_vpc]
}

module "stamper_vpc_route_table" {
  source               = "../../module/route_table"
  vpc_id               = module.stamper_vpc.id
  public_subnet_id     = module.stamper_vpc_subnet_a_public.id
  internet_gw_id       = module.stamper_vpc_internet_gw.id
  stack_tag      = "base_optimized"
  tf_name_tag = "stamper_vpc_route_table"
  depends_on = [
    module.stamper_vpc_subnet_a_public,
    module.stamper_vpc_internet_gw
  ]
}

module "stamper_vpc_elastic_ip" {
  source       = "../../module/eip"
  domain       = "vpc"
  stack_tag      = "base_optimized"
  tf_name_tag = "stamper_vpc_elastic_ip"
}

module "stamper_vpc_security_group" {
  source         = "../../module/security_group"
  sg_name        = "stamper-vpc-security-group"
  sg_vpc_id      = module.stamper_vpc.id
  sg_description = "Security group for ecs clusters"
  sg_ingress_rules = [
    { from_port = 1984, to_port = 1984, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow cnd-onboarding-api" },
  ]
  sg_egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], description = "Allow all outbound" },
  ]
  stack_tag      = "base_optimized"
  tf_name_tag = "stamper_vpc_security_group"
  depends_on = [module.stamper_vpc]
}

module "stamper_cnd_onboarding_api_ecr" {
  source          = "../../module/ecr"
  repository_name = "stamper/cnd-onboarding-api"
  stack_tag      = "base_optimized"
  tf_name_tag = "stamper_cnd_onboarding_api_ecr"
}

module "cnd_ecs_cluster_staging" {
  source       = "../../module/ecs"
  cluster_name = "cnd-ecs-cluster-staging"
  stack_tag      = "base_optimized"
  tf_name_tag = "cnd_ecs_cluster_staging"
  env_tag = "stage"
}