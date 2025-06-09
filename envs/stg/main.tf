data "terraform_remote_state" "stamper-labs" {
  backend = "s3"
  config = {
    bucket = "stamper-labs-tfstate-bucket"
    key    = "base-infra/prod/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_s3_bucket" "policies-bucket" {
  bucket = data.terraform_remote_state.stamper-labs.outputs.policies_bucket_name
}

data "aws_s3_object" "ecs-task-assume-role-policy" {
  bucket = data.aws_s3_bucket.policies-bucket.id
  key    = "std-onboarding/ecs-task-assume-role-policy.json"
}

data "aws_s3_object" "oidc-assume-role-github-policy" {
  bucket = data.aws_s3_bucket.policies-bucket.id
  key    = "std-onboarding/oidc-assume-role-github-policy.json"
}

data "aws_s3_object" "ecr-pull-push-github-policy" {
  bucket = data.aws_s3_bucket.policies-bucket.id
  key    = "std-onboarding/ecr-pull-push-github-policy.json"
}

module "security_group" {
  source         = "../../module/security_group"
  sg_name        = "std-stg-sg-allow-http"
  sg_vpc_id      = data.terraform_remote_state.stamper-labs.outputs.vpc_id
  sg_description = "Security group for ecs cluster in stage environment"
  sg_ingress_rules = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow Web" },
  ]
  sg_egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], description = "Allow all outbound" },
  ]
  env_tag = "stg"
}

module "ecs" {
  source           = "../../module/ecs"
  ecs_cluster_name = "std-stg-ecs-cluster"
  env_tag          = "stg"
}

module "iam_role" {
  source             = "../../module/iam_role"
  role_name          = "STDServiceRoleForECSTasks"
  assume_role_policy = data.aws_s3_object.ecs-task-assume-role-policy.body
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]
  env_tag            = "stg"
}

module "iam_policy_ecr_github" {
  source = "../../module/iam_policy"
  policy_name = "ECRPushPullForGitHubActions"
  policy_description = "ECR Push and Pull permissions for GitHub Actions"
  policy = data.aws_s3_object.ecr-pull-push-github-policy.body
}

module "iam_role_github" {
  source             = "../../module/iam_role"
  role_name          = "STDServiceRoleForGitHub"
  assume_role_policy = data.aws_s3_object.oidc-assume-role-github-policy.body
  # apply twice module.iam_policy_ecr_github.iam_policy_arn to ensure it is created before use
  policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", module.iam_policy_ecr_github.iam_policy_arn]
  env_tag            = "stg"
}

module "ecs_task_definition" {
  source                   = "../../module/ecs_task_definition"
  td_family                = "std-stg-ecs-ftask-nginx"
  td_network_mode          = "awsvpc"
  td_compatibilities       = ["FARGATE"]
  td_cpu                   = "256"
  td_memory                = "512"
  td_container_definitions = file("./docs/containers/nginx.json")
  td_execution_role_arn = module.iam_role.iam_role_arn
  env_tag                  = "stg"
}

module "ecs_service" {
  source                  = "../../module/ecs_service"
  svc_name                = "std-stg-ecs-fsvc"
  svc_cluster_id          = module.ecs.ecs_cluster_id
  svc_task_definition_arn = module.ecs_task_definition.task_definition_arn
  svc_launch_type         = "FARGATE"
  svc_desired_count       = 3
  svc_subnets             = [data.terraform_remote_state.stamper-labs.outputs.subnet_id]
  svc_security_groups     = [module.security_group.sg_id]
}

module "ecr_repository" {
  source = "../../module/ecr"
  repository_name = "std-onboarding-api"
}

output "ecr_repository_id" {
  value = module.ecr_repository.ecr_repository_id
}

output "iam_role_github_arn" {
  value = module.iam_role_github.iam_role_arn
}