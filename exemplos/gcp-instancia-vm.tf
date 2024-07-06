module "minhavm" {
  source = "github.com/EscolaDevOps/terraform-modules//gcp/instancia-vm?ref=v0.0.1"

  projeto             = "meu-projeto"
  regiao              = "us-central1"
  zona                = "us-central1-a"
  nome_vm             = "minha-instancia"
  tipo_vm             = "n1-standard-1"
  sistema_operacional = "ubuntu-2404-lts-amd64"
  tamanho_disco_boot  = 100
  tipo_disco_boot     = "pd-standard"
  script_boot         = "path/to/script.sh"
  script_sysprep      = "path/to/sysprep.ps1"
  rede                = "default"
  subrede             = "default"
  ip_privado_fixo     = ""
  ip_publico          = true
  ip_publico_fixo     = ""
  tags_rede           = ["http-server", "https-server"]
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

output "ip_da_maquina" {
  value = module.minhavm.instancia_ip_privado
}

output "ip_publico" {
  value = module.minhavm.instancia_ip_publico
}

output "id_da_instancia" {
  value = module.minhavm.instancia_id
}

output "imagem" {
  value = module.minhavm.instancia_imagem
}