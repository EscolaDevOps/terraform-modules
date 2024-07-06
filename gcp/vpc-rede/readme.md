# Módulo de Redes VPC

- Este módulo cria redes VPC Google Cloud Platform (GCP) utilizando Terraform, implementa diversos recursos de redes e fornece várias saídas úteis.
- É possível gerenciar subredes e regras de firewall.

## Variáveis de entrada

| Variável | Descrição | Tipo | Padrão | Validação |
|----------|-----------|------|--------|-----------|
| `projeto` | ID do projeto. | `string` | nenhum | Não pode ser vazia. |
| `rede_nome` | Nome da rede VPC. | `string` | nenhum | Não pode ser vazia. |
| `descricao` | Descrição da rede VPC. | `string` | `""` | Nenhuma. |
| `cria_subredes_auto` | Indica se serão criadas subredes automaticamente para cada região. Quando verdadeiro, cria redes com tamanho /20 a partir do endereço 10.128.0.0/9. Quando falso, as subredes devem ser criadas manualmente. | `bool` | `false` | Nenhuma. |
| `tipo_roteamento` | Tipo de modo de roteamento. | `string` | `GLOBAL` | Se informada, deve ser um dos valores: `GLOBAL` ou `REGIONAL` |
| `subredes` | Lista de subredes que serão criadas. Variáveis da lista: `subrede_nome`: nome da subrede, `subrede_ip`: IP da subrede em formato CIDR, `subrede_regiao`: região onde vai ser criada a subrede, `subrede_privado` (opcional): indica se a subrede vai ter somente IPs privados, `subrede_descricao` (opcional): descrição da subrede. | <pre>list(object({<br>  subrede_nome      = string<br>  subrede_ip        = string<br>  subrede_regiao    = string<br>  subrede_privado   = optional(bool)<br>  subrede_descricao = optional(string)<br>}))</pre> | `[]` | Nenhuma. |
| `regras_entrada` | Lista de regras de firewall de tráfego de entrada (ingress). Variáveis da lista: `regra_nome`: nome da regra, `regra_descricao` (opcional): descrição da regra, `regra_desativada` (opcional): indica se a regra deve ser desativada, `regra_prioridade` (opcional): prioridade da regra (maior melhor), `regra_destino_ip` (opcional): IP de destino do tráfego em formato CIDR, `regra_origem_ip` (opcional): IP de origem do tráfego em formato CIDR, `regra_tags_rede` (opcional): tag da regra de firewall pra ser usado nos recursos, `regra_permite` (opcional): lista de protocolos e portas para liberação de acesso com `protocolo` e `portas`, `regra_bloqueia` (opcional): lista de protocolos e portas para bloqueio de acesso com `protocolo` e `portas`. | <pre>list(object({<br>  regra_nome       = string<br>  regra_descricao  = optional(string, null)<br>  regra_desativada = optional(bool, null)<br>  regra_prioridade = optional(number, null)<br>  regra_destino_ip = optional(list(string), [])<br>  regra_origem_ip  = optional(list(string), [])<br>  regra_tags_rede  = optional(list(string), [])<br>  regra_permite = optional(list(object({<br>    protocolo = string<br>    portas    = optional(list(string))<br>  })), [])<br>  regra_bloqueia = optional(list(object({<br>    protocolo = string<br>    portas    = optional(list(string))<br>  })), [])<br>}))</pre> | `[]` | Nenhuma. |
| `regras_saida` | Lista de regras de firewall de tráfego de saída (egress). Variáveis da lista: `regra_nome`: nome da regra, `regra_descricao` (opcional): descrição da regra, `regra_desativada` (opcional): indica se a regra deve ser desativada, `regra_prioridade` (opcional): prioridade da regra (maior melhor), `regra_destino_ip` (opcional): IP de destino do tráfego em formato CIDR, `regra_origem_ip` (opcional): IP de origem do tráfego em formato CIDR, `regra_tags_rede` (opcional): tag da regra de firewall pra ser usado nos recursos, `regra_permite` (opcional): lista de protocolos e portas para liberação de acesso com `protocolo` e `portas`, `regra_bloqueia` (opcional): lista de protocolos e portas para bloqueio de acesso com `protocolo` e `portas`. | <pre>list(object({<br>  regra_nome       = string<br>  regra_descricao  = optional(string, null)<br>  regra_desativada = optional(bool, null)<br>  regra_prioridade = optional(number, null)<br>  regra_destino_ip = optional(list(string), [])<br>  regra_origem_ip  = optional(list(string), [])<br>  regra_tags_rede  = optional(list(string), [])<br>  regra_permite = optional(list(object({<br>    protocolo = string<br>    portas    = optional(list(string))<br>  })), [])<br>  regra_bloqueia = optional(list(object({<br>    protocolo = string<br>    portas    = optional(list(string))<br>  })), [])<br>}))</pre> | `[]` | Nenhuma. |


## Variáveis de Saída

| Variável | Descrição |
|----------|-----------|
| `rede_id` | ID da rede VPC criada. |
| `rede_self_link` | IURI da rede VPC criada. |
| `subnets_self_links` | URIs das subnets criadas. |


## Exemplo de Uso

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
