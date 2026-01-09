provider "aws" {
  region  = "us-east-1"
  profile = "owners-virginia"
  alias   = "virginia"
}

module "github_provider_openid" {
  source                 = "../../module/iam_openid"
  connector_url          = "https://token.actions.githubusercontent.com"
  openid_client_id_list  = ["sts.amazonaws.com"]
  openid_thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  stack_tag                = "global"
  tf_name_tag = "github_provider_openid"
  providers = {
    aws = aws.virginia
  }
}

module "stamper_policy_github_actions_provision" {
  source             = "../../module/iam_policy"
  policy_name        = "StamperGitHubActionsProvisioningPolicy"
  policy_description = "IAM permissions required by StamperServiceRoleForGitHubActions to provision and manage AWS resources via Terraform."
  policy             = file("./policy/github-actions-provision-policy.json")
  stack_tag                = "global"
  tf_name_tag = "stamper_policy_github_actions_provision"
  providers = {
    aws = aws.virginia
  }
}

module "stamper_role_github_actions" {
  source             = "../../module/iam_role"
  role_name          = "StamperServiceRoleForGitHubActions"
  assume_role_policy = file("./policy/github-actions-assume-policy.json")
  policy_arns = {
    s3_full_access = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    github_actions_provision  = module.stamper_policy_github_actions_provision.arn
  }
  stack_tag                = "global"
  tf_name_tag = "stamper_role_github_actions"
  providers = {
    aws = aws.virginia
  }
}