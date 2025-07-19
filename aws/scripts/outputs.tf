
output "stamper_vpc_id" {
  value = module.stamper_vpc.id
}

output "stamper_vpc_internet_gw_id" {
  value = module.stamper_vpc_internet_gw.id
}

output "stamper_vpc_subnet_a_public_id" {
  value = module.stamper_vpc_subnet_a_public.id
}

output "stamper_vpc_route_table_id" {
  value = module.stamper_vpc_route_table.id
}

output "stamper_vpc_subnet_b_private_id" {
  value = module.stamper_vpc_subnet_b_private.id
}

output "stamper_vpc_elastic_ip_id" {
  value = module.stamper_vpc_elastic_ip.id
}

output "stamper_vpc_elastic_ip_public_ip" {
  value = module.stamper_vpc_elastic_ip.public_ip
}

output "stamper_vpc_nat_gw_id" {
  value = module.stamper_vpc_nat_gw.id
}

output "stamper_vpc_route_table_private_id" {
  value = module.stamper_vpc_route_table_private.id
}

output "github_provider_openid_arn" {
  value = module.github_provider_openid.arn
}

output "stamper_vpc_security_group_id" {
  value = module.stamper_vpc_security_group.id
}

output "stamper_policy_github_actions_provision_arn" {
  value = module.stamper_policy_github_actions_provision.arn
}

output "stamper_role_github_actions_arn" {
  value = module.stamper_role_github_actions.arn
}

output "stamper_cnd_onboarding_api_ecr_id" {
  value = module.stamper_cnd_onboarding_api_ecr.id
}

output "stamper_cnd_onboarding_api_ecr_url" {
  value = module.stamper_cnd_onboarding_api_ecr.url
}

output "cnd_ecs_cluster_staging_id" {
  value = module.cnd_ecs_cluster_staging.id
}

output "cnd_ecs_cluster_staging_name" {
  value = module.cnd_ecs_cluster_staging.name
}
