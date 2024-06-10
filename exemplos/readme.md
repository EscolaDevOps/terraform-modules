# Modelos para GCP - Google Cloud Platform

Lista de modelos disponíves para GCP:

### gcp-instancia-vm.tf
- Cria uma instância de VM usando Compute Engines. É possível adicionar discos adicionais, script de inicialização (sysprep) para sistemas Windows e script de boot.

## Exemplo de Uso

```hcl
module "gcp_instance" {
  source = "github.com/EscolaDevOps/terraform-modules//gcp/instancia-vm"

  projeto                    = "meu-projeto"
  regiao                     = "us-central1"
  zona                       = "us-central1-a"
  nome_vm                    = "minha-instancia"
  tipo_vm                    = "n1-standard-1"
  sistema_operacional        = "ubuntu"
  sistema_operacional_projeto= "ubuntu-os-cloud"
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
