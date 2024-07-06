provider "google" {
  project = var.projeto
}

module "rede" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1.0"

  project_id   = var.projeto
  network_name = var.rede_nome
  description  = var.descricao
  routing_mode = var.tipo_roteamento
  subnets      = local.subnets

  auto_create_subnetworks = var.cria_subredes_auto

  ingress_rules = local.ingress
  egress_rules  = local.egress
}
