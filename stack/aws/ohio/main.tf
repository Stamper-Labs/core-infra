provider "aws" {
  region  = "us-east-2"
  profile = "owners-ohio"
  alias   = "ohio"
}

module "stamper_vpc" {
  source         = "../../module/vpc"
  vpc_cidr_block = "192.168.0.0/16"
  stack_tag      = "ohio"
  tf_name_tag = "stamper_vpc"
  providers = {
    aws = aws.ohio
  }
}

module "stamper_vpc_internet_gw" {
  source               = "../../module/internet_gw"
  vpc_id               = module.stamper_vpc.id
  stack_tag      = "ohio"
  tf_name_tag = "stamper_vpc_internet_gw"
  depends_on           = [module.stamper_vpc]
  providers = {
    aws = aws.ohio
  }
}

module "stamper_vpc_subnet_a_public" {
  source                  = "../../module/subnet"
  vpc_id                  = module.stamper_vpc.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  stack_tag      = "ohio"
  tf_name_tag = "stamper_vpc_subnet_a_public"
  depends_on              = [module.stamper_vpc]
  providers = {
    aws = aws.ohio
  }
}

module "stamper_vpc_route_table" {
  source               = "../../module/route_table"
  vpc_id               = module.stamper_vpc.id
  public_subnet_id     = module.stamper_vpc_subnet_a_public.id
  internet_gw_id       = module.stamper_vpc_internet_gw.id
  stack_tag      = "ohio"
  tf_name_tag = "stamper_vpc_route_table"
  depends_on = [
    module.stamper_vpc_subnet_a_public,
    module.stamper_vpc_internet_gw
  ]
  providers = {
    aws = aws.ohio
  }
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
  stack_tag      = "ohio"
  tf_name_tag = "stamper_vpc_security_group"
  depends_on = [module.stamper_vpc]
  providers = {
    aws = aws.ohio
  }
}

module "stamper_ec2_independency_ssh_key" {
  source       = "../../module/ssh_key"
  name     = "stamper-ec2-independency-ssh-key"
  public_key_path = ""  # leave empty to auto-generate
  providers = {
    aws = aws.ohio
  }
}

module "stamper_role_ec2_independency" {
  source             = "../../module/iam_role"
  role_name          = "StamperServiceRoleForEC2Independency"
  assume_role_policy = file("./policy/ec2-independency-assume-policy.json")
  policy_arns = {
    ssm_managed_instance = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  stack_tag                = "ohio"
  tf_name_tag = "stamper_role_ec2_independency"
  providers = {
    aws = aws.ohio
  }
}

module "stamper_ec2_independency" {
  source = "../../module/ec2"
  ec2_ami_id         = "ami-0a0d9cf81c479446a"
  ec2_instance_type  = "t3.micro"
  subnet_id          = module.stamper_vpc_subnet_a_public.id
  add_public_ip      = false
  security_group_ids = [
    module.stamper_vpc_security_group.id
  ]
  ssm_profile_name = "StamperEC2IndependencyProfile"
  ssm_role_name = module.stamper_role_ec2_independency.name
  stack_tag      = "ohio"
  tf_name_tag = "stamper_ec2_independency"
  providers = {
    aws = aws.ohio
  }
}