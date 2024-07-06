locals {
  # completa com o valor padrão para subrede_privado
  subredes_com_defaults = [for subrede in var.subredes : merge(
    {
      subrede_privado = false
    },
    subrede
  )]

  subnets = [for subrede in local.subredes_com_defaults : {
    subnet_name           = subrede.subrede_nome
    subnet_ip             = subrede.subrede_ip
    subnet_region         = subrede.subrede_regiao
    subnet_private_access = subrede.subrede_privado
    subnet_description    = subrede.subrede_descricao
  }]

  ingress = [for regra in var.regras_entrada : {
    name               = regra.regra_nome
    description        = regra.regra_descricao
    disabled           = regra.regra_desativada
    priority           = regra.regra_prioridade
    destination_ranges = regra.regra_destino_ip
    source_ranges      = regra.regra_origem_ip
    target_tags        = regra.regra_tags_rede

    allow = [for permite in regra.regra_permite : {
      protocol = permite.protocolo
      ports    = permite.portas
    }]
    deny = [for bloqueia in regra.regra_bloqueia : {
      protocol = bloqueia.protocolo
      ports    = bloqueia.portas
    }]
  }]

  egress = [for regra in var.regras_saida : {
    name               = regra.regra_nome
    description        = regra.regra_descricao
    disabled           = regra.regra_desativada
    priority           = regra.regra_prioridade
    destination_ranges = regra.regra_destino_ip
    source_ranges      = regra.regra_origem_ip
    target_tags        = regra.regra_tags_rede

    allow = [for permite in regra.regra_permite : {
      protocol = permite.protocolo
      ports    = permite.portas
    }]
    deny = [for bloqueia in regra.regra_bloqueia : {
      protocol = bloqueia.protocolo
      ports    = bloqueia.portas
    }]
  }]
}
