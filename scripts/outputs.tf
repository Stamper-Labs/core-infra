
output "stamper_vpc_id" {
  value = module.stamper_vpc.id
}

output "stamper_internet_gw_id" {
  value = module.stamper_internet_gw.id
}

output "stamper_public_subnet_a_id" {
  value = module.stamper_public_subnet_a.id
}

output "stamper_public_route_table_id" {
  value = module.stamper_public_route_table.id
}

output "stamper_private_subnet_b_id" {
  value = module.stamper_private_subnet_b.id
}

output "stamper_eip_vpc_id" {
  value = module.stamper_eip_vpc.id
}

output "stamper_eip_vpc_public_ip" {
  value = module.stamper_eip_vpc.public_ip
}

output "stamper_nat_gw_id" {
  value = module.stamper_nat_gw.id
}

output "stamper_route_table_private_id" {
  value = module.stamper_route_table_private.id
}

output "stamper_iam_openid_github_provider_arn" {
  value = module.stamper_iam_openid_github_provider.arn
}

output "stamper_iam_role_ecs_tasks_execution_arn" {
  value = module.stamper_iam_role_ecs_tasks_execution.arn
}

output "stamper_security_group_allow_http_id" {
  value = module.stamper_security_group_allow_http.id
}

output "stamper_policy_ecr_push_and_pull_arn" {
  value = module.stamper_policy_ecr_push_and_pull.arn
}

output "stamper_iam_role_github_actions_arn" {
  value = module.stamper_iam_role_github_actions.arn 
}