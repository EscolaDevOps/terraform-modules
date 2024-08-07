# Modelos para GCP - Google Cloud Platform

Lista de modelos disponíves para GCP:

### gcp-instancia-vm.tf
- Cria uma instância de VM usando Compute Engines. É possível adicionar discos adicionais, script de inicialização (sysprep) para sistemas Windows e script de boot.

## Exemplo de Uso

```hcl
module "minhavm" {
  source = "github.com/EscolaDevOps/terraform-modules//gcp/instancia-vm?ref=v0.0.1"

  projeto                    = "meu-projeto"
  regiao                     = "us-central1"
  zona                       = "us-central1-a"
  nome_vm                    = "minha-instancia"
  tipo_vm                    = "n1-standard-1"
  sistema_operacional        = "ubuntu-2404-lts-amd64"
  sistema_operacional_projeto= ""
  sistema_operacional_imagem = ""
  tamanho_disco_boot         = 100
  tipo_disco_boot            = "pd-standard"
  script_boot                = "path/to/script.sh"
  script_sysprep             = "path/to/sysprep.ps1"
  rede                       = "default"
  subrede                    = "default"
  ip_privado_fixo            = ""
  ip_publico                 = true
  ip_publico_fixo            = ""
  tags_rede                  = ["http-server", "https-server"]
  disco_adicional = {
    "extra-disk-1" = {
      tamanho = 50
      tipo    = "pd-standard"
    }
    "extra-disk-2" = {
      tamanho = 100
      tipo    = "pd-ssd"
    }
  }
}

output "ip_privado" {
  value = module.gcp_instance.instancia_ip_privado
}

output "ip_publico" {
  value = module.gcp_instance.instancia_ip_publico
}

output "id_instancia" {
  value = module.gcp_instance.instancia_id
}

output "imagem_so" {
  value = module.gcp_instance.instancia_imagem
}
```

### gcp-vpc-rede.tf
- Cria uma rede VPC. É possível adicionar subredes e regras de firewall.

```hcl
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
```
