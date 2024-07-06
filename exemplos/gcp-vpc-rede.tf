module "redes-gcp" {
  source = "github.com/EscolaDevOps/terraform-modules//gcp/vpc-rede?ref=v0.0.1"

  projeto         = "meu-projeto"
  rede_nome       = "default"
  descricao       = "Default network for the project"
  tipo_roteamento = "GLOBAL"

  cria_subredes_auto = false

  subredes = [
    {
      subrede_nome   = "default"
      subrede_ip     = "10.138.0.0/20"
      subrede_regiao = "us-west1"
    },
    {
      subrede_nome   = "default"
      subrede_ip     = "10.158.0.0/20"
      subrede_regiao = "southamerica-east1"
    },
  ]

  regras_entrada = [
    {
      regra_nome      = "http-server"
      regra_descricao = "Permite acesso HTTP porta 80"
      regra_tags_rede = "http-server"
      regra_permite = [
        {
          protocolo = "TCP"
          portas    = ["80"]
        }
      ]
    },
    {
      regra_nome      = "https-server"
      regra_descricao = "Permite acesso HTTPS porta 443"
      regra_tags_rede = "https-server"
      regra_permite = [
        {
          protocolo = "TCP"
          portas    = ["443"]
        },
        {
          protocolo = "UDP"
          portas    = ["443"]
        },
      ]
    }
  ]
}

output "id_rede_vpc" {
  value = module.redes-gcp.rede_id
}

output "uri_rede_vpc" {
  value = module.redes-gcp.rede_self_link
}
