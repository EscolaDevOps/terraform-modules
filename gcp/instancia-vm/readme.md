# Módulo de Instâncias GCP

- Este módulo cria instâncias de Virtual Machine (VM) no Google Cloud Platform (GCP) utilizando Terraform e fornece várias saídas úteis.
- É possível adicionar discos adicionais, script de inicialização (sysprep) em sistemas Windows e script de boot.

## Variáveis de entrada

| Variável | Descrição | Tipo | Padrão | Validação |
|----------|-----------|------|--------|-----------|
| `projeto` | ID do projeto. | `string` | nenhum | Não pode ser vazia. |
| `regiao` | Região onde vai ser aplicado. | `string` | nenhum | Não pode ser vazia. |
| `zona` | Zona onde vai ser aplicado. | `string` | nenhum | Não pode ser vazia. |
| `vm_nome` | Nome da instância/VM. | `string` | nenhum | Não pode ser vazia. |
| `vm_tipo` | Tipo de instância a ser aplicada. | `string` | nenhum | Não pode ser vazia. |
| `sistema_operacional` | Nome ou família do sistema operacional a ser utilizado. Será utilizada a última imagem disponível do sistema operacional. Se informar a variável `sistema_operacional_imagem`, essa configuração será ignorada. | `string` | `""` | Se informada, deve ser um dos valores: `centos-7`, `centos-stream-9`, `debian-10`, `debian-11`, `debian-12`, `rhel-7`, `rhel-8`, `rhel-9`, `rocky-linux-8`, `rocky-linux-9`, `sles-12`, `sles-15`, `ubuntu-2004-lts`, `ubuntu-2204-lts`, `ubuntu-2404-lts-amd64`, `ubuntu-minimal-2004-lts`, `ubuntu-minimal-2204-lts`, `ubuntu-minimal-2404-lts-amd64`, `ubuntu-pro-1604-lts`, `ubuntu-pro-1804-lts`, `ubuntu-pro-2004-lts`, `ubuntu-pro-2204-lts`, `ubuntu-pro-2404-lts-amd64`, `windows-2016-core`, `windows-2016`, `windows-2019-core`, `windows-2019`, `windows-2022-core`, `windows-2022` |
| `sistema_operacional_projeto` | Nome do projeto GCP do sistema operacional. Opcional se for informada uma imagem ou for da família `windows`, `ubuntu`, `centos`, `rhel`, `debian`, `rocky`, `suse` ou `sles`. | `string` | `""` | Nenhuma. |
| `sistema_operacional_imagem` | Nome da imagem do sistema operacional. Deve ser usada quando não é informada uma família de sistema operacional. | `string` | `""` | Nenhuma. |
| `tamanho_disco_boot` | Tamanho em GB do disco de boot. | `number` | `100` | Nenhuma. |
| `tipo_disco_boot` | Tipo do disco de boot. | `string` | `pd-standard` | Nenhuma. |
| `script_boot` | Caminho do script a ser executado a cada boot da instância/VM. Bash para Linux ou PowerShell para Windows. | `string` | `""` | Nenhuma. |
| `script_sysprep` | Caminho do script a ser executado na criação da instância/VM. Não disponível para Linux. Apenas PowerShell para Windows. | `string` | `""` | Nenhuma. |
| `rede` | Nome da rede da instância. | `string` | `default` | Nenhuma. |
| `subrede` | Nome da subrede da instância. | `string` | `default` | Nenhuma. |
| `ip_privado_fixo` | Define um IP privado fixo para a instância. | `string` | `""` | Nenhuma. |
| `ip_publico` | Indica se a instância terá um IP público. | `bool` | `false` | Nenhuma. |
| `ip_publico_fixo` | Define um IP público fixo para a instância. Precisa existir a reserva de IP estático no GCP. | `string` | `""` | Nenhuma. |
| `tags_rede` | Lista de regras de firewall. | `list(string)` | `[]` | Nenhuma. |
| `disco_adicional` | Lista de discos adicionais. Variáveis do objeto: `tamanho` em GB do disco adicional e `tipo` do disco adicional. A chave de cada objeto será o sufixo do nome do disco. | `map(object({ tamanho = number, tipo = string }))` | `{}` | A chave 'boot-disk' não é permitida. |


## Variáveis de Saída

| Variável | Descrição |
|----------|-----------|
| `instancia_id` | O ID da instância criada. |
| `instancia_imagem` | Nome da imagem que foi utilizada na criação da instância. |
| `instancia_ip_privado` | O IP privado da instância criada. |
| `instancia_ip_publico` | O IP público da instância criada, se `ip_publico` for `true`. Caso contrário, retorna uma string vazia. |


## Exemplo de Uso

```hcl
module "gcp_instance" {
  source = "github.com/EscolaDevOps/terraform-modules//gcp/instancia-vm"

  projeto                    = "meu-projeto"
  regiao                     = "us-central1"
  zona                       = "us-central1-a"
  nome_vm                    = "minha-instancia"
  tipo_vm                    = "n1-standard-1"
  sistema_operacional        = "ubuntu-2404-lts-amd64"
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
