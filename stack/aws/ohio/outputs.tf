
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

output "stamper_vpc_elastic_ip_id" {
  value = module.stamper_vpc_elastic_ip.id
}

output "stamper_vpc_elastic_ip_public_ip" {
  value = module.stamper_vpc_elastic_ip.public_ip
}

output "stamper_vpc_security_group_id" {
  value = module.stamper_vpc_security_group.id
}

output "stamper_cnd_onboarding_api_ecr_id" {
  value = module.stamper_cnd_onboarding_api_ecr.id
}

output "stamper_cnd_onboarding_api_ecr_url" {
  value = module.stamper_cnd_onboarding_api_ecr.url
}