output "github_provider_openid_arn" {
  value = module.github_provider_openid.arn
}

output "stamper_policy_github_actions_provision_arn" {
  value = module.stamper_policy_github_actions_provision.arn
}

output "stamper_role_github_actions_arn" {
  value = module.stamper_role_github_actions.arn
}