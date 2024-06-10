locals {
  so_windows      = can(regex("(?i)windows", var.sistema_operacional)) || can(regex("(?i)windows", var.sistema_operacional_imagem))
  so_ubuntu       = can(regex("(?i)ubuntu", var.sistema_operacional)) || can(regex("(?i)ubuntu", var.sistema_operacional_imagem))
  so_centos       = can(regex("(?i)centos", var.sistema_operacional)) || can(regex("(?i)centos", var.sistema_operacional_imagem))
  so_rhel         = can(regex("(?i)rhel", var.sistema_operacional)) || can(regex("(?i)rhel", var.sistema_operacional_imagem))
  so_debian       = can(regex("(?i)debian", var.sistema_operacional)) || can(regex("(?i)debian", var.sistema_operacional_imagem))
  so_rocky        = can(regex("(?i)rocky", var.sistema_operacional)) || can(regex("(?i)rocky", var.sistema_operacional_imagem))
  so_suse         = can(regex("(?i)suse", var.sistema_operacional)) || can(regex("(?i)suse", var.sistema_operacional_imagem)) || can(regex("(?i)sles", var.sistema_operacional)) || can(regex("(?i)sles", var.sistema_operacional_imagem))
  so_desconhecido = !local.so_windows && !local.so_ubuntu && !local.so_centos && !local.so_rhel && !local.so_debian && !local.so_rocky && !local.so_suse
  use_imagem_so   = length(trimspace(var.sistema_operacional_imagem)) > 0
}
