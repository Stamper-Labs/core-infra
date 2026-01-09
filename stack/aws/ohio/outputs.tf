
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

output "stamper_vpc_security_group_id" {
  value = module.stamper_vpc_security_group.id
}