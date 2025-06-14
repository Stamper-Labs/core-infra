data "terraform_remote_state" "stamper_labs" {
  backend = "s3"
  config = {
    bucket = "stamper-labs-tfstate-bucket"
    key    = "base-infra/prod/terraform.tfstate"
    region = "us-east-1"
  }
}

module "std_ecs_task_iam_role" {
  source             = "../../module/iam_role"
  role_name          = "STDServiceRoleForECSTasks"
  assume_role_policy = file("./policy/ecs-task-assume-iam-role-trust-policy.json")
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]
  env_tag = "stg"
}

module "std_ecr_iam_policy" {
  source            = "../../module/iam_policy"
  policy_name       = "ECRPushPullPolicyForGitHubActions"
  policy_description = "ECR Push and Pull permissions for GitHub Actions"
  policy            = file("./policy/github-pull-and-push-ecr-iam-policy.json")
}

module "std_github_iam_role" {
  source             = "../../module/iam_role"
  role_name          = "STDServiceRoleForGitHub"
  assume_role_policy = file("./policy/github-assume-iam-role-trust-policy.json") # Update path if needed
  # apply twice module.std_ecr_iam_policy.iam_policy_arn to ensure it is created before use
  # policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", module.std_ecr_iam_policy.iam_policy_arn]
  env_tag = "stg"
}

module "allow_http_security_group" {
  source         = "../../module/security_group"
  sg_name        = "stg-sg-allow-http"
  sg_vpc_id      = data.terraform_remote_state.stamper_labs.outputs.vpc_id
  sg_description = "Security group for ecs cluster in stage environment"
  sg_ingress_rules = [
    { from_port = 0, to_port = 65535, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow Web" },
  ]
  sg_egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], description = "Allow all outbound" },
  ]
  env_tag = "stg"
}

module "std_stg_ecs_cluster" {
  source           = "../../module/ecs"
  ecs_cluster_name = "std-stg-ecs-cluster"
  env_tag          = "stg"
}

module "ecr_repository_onboarding_api" {
  source = "../../module/ecr"
  repository_name = "std-onboarding-api"
}

output "ecs_cluster_id" {
  value = module.std_stg_ecs_cluster.ecs_cluster_id
}

output "ecr_repository_id" {
  value = module.ecr_repository_onboarding_api.ecr_repository_id
}

output "iam_role_github_arn" {
  value = module.std_github_iam_role.iam_role_arn
}

output "ecs_task_execution_role_arn" {
  value = module.std_ecs_task_iam_role.iam_role_arn
}

output "allow_http_security_group_id" {
  value = module.allow_http_security_group.sg_id
}

output "vpc_subnet_id" {
  value = data.terraform_remote_state.stamper_labs.outputs.vpc_subnet_id
}