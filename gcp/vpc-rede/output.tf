output "rede_id" {
  value       = module.rede.network_id
  description = "ID da rede VPC criada."
}

output "rede_self_link" {
  value = module.rede.network_self_link
  description = "URI da rede VPC criada."
}

output "subnets_self_links" {
  value = module.rede.subnets_self_links
  description = "URIs das subnets criadas."
}