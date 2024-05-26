# Módulo de Instâncias GCP

Este módulo cria instâncias de Virtual Machine (VM) no Google Cloud Platform (GCP) utilizando Terraform e fornece várias saídas úteis.

## Variáveis de entrada

### `projeto`
- **Tipo**: `string`
- **Descrição**: ID do projeto.
- **Validação**: Não pode ser vazia.

### `regiao`
- **Tipo**: `string`
- **Descrição**: Região onde a instância será aplicada.
- **Validação**: Não pode ser vazia.

### `zona`
- **Tipo**: `string`
- **Descrição**: Zona onde a instância será aplicada.
- **Validação**: Não pode ser vazia.

### `nome_vm`
- **Tipo**: `string`
- **Descrição**: Nome da instância/VM.
- **Validação**: Não pode ser vazia.

### `tipo_vm`
- **Tipo**: `string`
- **Descrição**: Tipo de instância a ser aplicada.
- **Validação**: Não pode ser vazia.

### `imagem`
- **Tipo**: `string`
- **Descrição**: Nome da imagem do sistema operacional.
- **Validação**: Não pode ser vazia.

### `tamanho_disco_boot`
- **Tipo**: `number`
- **Descrição**: Tamanho em GB do disco de boot.
- **Opcional**
- **Padrão**: `100`

### `tipo_disco_boot`
- **Tipo**: `string`
- **Descrição**: Tipo do disco de boot.
- **Opcional**
- **Padrão**: `pd-standard`

### `script_boot`
- **Tipo**: `string`
- **Descrição**: Caminho do script a ser executado a cada boot da instância/VM. Bash para Linux ou PowerShell para Windows.
- **Opcional**
- **Padrão**: Em branco

### `script_sysprep`
- **Tipo**: `string`
- **Descrição**: Caminho do script a ser executado na criação da instância/VM. Não disponível para Linux. Apenas PowerShell para Windows.
- **Opcional**
- **Padrão**: Em branco

### `rede`
- **Tipo**: `string`
- **Descrição**: Nome da rede da instância.
- **Opcional**
- **Padrão**: `default`

### `subrede`
- **Tipo**: `string`
- **Descrição**: Nome da subrede da instância.
- **Opcional**
- **Padrão**: `default`

### `ip_publico`
- **Tipo**: `bool`
- **Descrição**: Indica se a instância terá um IP público.
- **Opcional**
- **Padrão**: `false`

### `tags_rede`
- **Tipo**: `list(string)`
- **Descrição**: Lista de regras de firewall.
- **Opcional**
- **Padrão**: Em branco

### `disco_adicional`
- **Tipo**: `map(object({ tamanho = number, tipo = string }))`
- **Descrição**: Lista de discos adicionais. Variáveis do objeto: 'tamanho' em GB do disco adicional e 'tipo' do disco adicional. A chave de cada objeto será o sufixo do nome do disco. Não é permitido usar a chave 'boot-disk'.
- **Opcional**
- **Padrão**: Em branco
- **Validação**: A chave 'boot-disk' não é permitida.

## Variáveis de Saída

### `instancia_ip_privado`
- **Descrição**: IP privado da instância.
- **Valor**: O IP privado da instância criada.

### `instancia_ip_publico`
- **Descrição**: IP público da instância.
- **Valor**: O IP público da instância criada, se `var.ip_publico` for `true`. Caso contrário, retorna uma string vazia.

### `instancia_id`
- **Descrição**: ID da instância.
- **Valor**: O ID da instância criada.

### `imagem_linux`
- **Descrição**: Indica se a imagem é Linux.
- **Valor**: `true` se a imagem for Linux, `false` caso contrário.

### `imagem_windows`
- **Descrição**: Indica se a imagem é Windows.
- **Valor**: `true` se a imagem for Windows, `false` caso contrário.

## Exemplo de Uso

```hcl
module "gcp_instance" {
  source = "github.com/EscolaDevOps/terraform-modules//gcp/instancia-vm"

  projeto              = "meu-projeto"
  regiao               = "us-central1"
  zona                 = "us-central1-a"
  nome_vm              = "minha-instancia"
  tipo_vm              = "n1-standard-1"
  imagem               = "debian-9"
  tamanho_disco_boot   = 100
  tipo_disco_boot      = "pd-standard"
  script_boot          = "path/to/script.sh"
  script_sysprep       = "path/to/sysprep.ps1"
  rede                 = "default"
  subrede              = "default"
  ip_publico           = true
  tags_rede            = ["tag1", "tag2"]
  disco_adicional      = {
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
```
