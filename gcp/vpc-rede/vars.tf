variable "projeto" {
  type        = string
  description = "ID do projeto."
  validation {
    condition     = length(trimspace(var.projeto)) > 0
    error_message = "A variável 'projeto' não pode ser vazia. Forneça um ID de projeto válido."
  }
}

variable "rede_nome" {
  type        = string
  description = "Nome da rede VPC."
  validation {
    condition     = length(trimspace(var.rede_nome)) > 0
    error_message = "A variável 'rede_nome' não pode ser vazia. Forneça um nome de rede válido."
  }
}

variable "cria_subredes_auto" {
  type        = bool
  description = "Indica se serão criadas subredes automaticamente para cada região. Quando verdadeiro, cria redes com tamanho /20 a partir do endereço 10.128.0.0/9. Quando falso, as subredes devem ser criadas manualmente. Padrão é false."
  default     = false
}

variable "descricao" {
  type        = string
  description = "Descrição da rede VPC."
  default     = ""
}

variable "tipo_roteamento" {
  type        = string
  description = "Tipo de modo de roteamento. Padrão é 'GLOBAL'."
  default     = "GLOBAL"
}

variable "subredes" {
  type = list(object({
    subrede_nome      = string
    subrede_ip        = string
    subrede_regiao    = string
    subrede_privado   = optional(bool)
    subrede_descricao = optional(string)
  }))
  description = "Lista de subredes que serão criadas. Variáveis da lista: 'subrede_nome': nome da subrede, 'subrede_ip': IP da subrede em formato CIDR, 'subrede_regiao': região onde vai ser criada a subrede, 'subrede_privado' (opcional): indica se a subrede vai ter somente IPs privados, 'subrede_descricao' (opcional): descrição da subrede."
  default     = []
}

variable "regras_entrada" {
  type = list(object({
    regra_nome       = string
    regra_descricao  = optional(string, null)
    regra_desativada = optional(bool, null)
    regra_prioridade = optional(number, null)
    regra_destino_ip = optional(list(string), [])
    regra_origem_ip  = optional(list(string), [])
    regra_tags_rede  = optional(list(string), [])

    regra_permite = optional(list(object({
      protocolo = string
      portas    = optional(list(string))
    })), [])
    regra_bloqueia = optional(list(object({
      protocolo = string
      portas    = optional(list(string))
    })), [])
  }))
  description = "Lista de regras de firewall de tráfego de entrada (ingress). Variáveis da lista: 'regra_nome': nome da regra, 'regra_descricao' (opcional): descrição da regra, 'regra_desativada' (opcional): indica se a regra deve ser desativada, 'regra_prioridade' (opcional): prioridade da regra (maior melhor), 'regra_destino_ip' (opcional): IP de destino do tráfego em formato CIDR, 'regra_origem_ip' (opcional): IP de origem do tráfego em formato CIDR, 'regra_tags_rede' (opcional): tag da regra de firewall pra ser usado nos recursos, 'regra_permite' (opcional): lista de protocolos e portas para liberação de acesso com 'protocolo' e 'portas', 'regra_bloqueia' (opcional): lista de protocolos e portas para bloqueio de acesso com 'protocolo' e 'portas'."
  default     = []
}

variable "regras_saida" {
  type = list(object({
    regra_nome       = string
    regra_descricao  = optional(string, null)
    regra_desativada = optional(bool, null)
    regra_prioridade = optional(number, null)
    regra_destino_ip = optional(list(string), [])
    regra_origem_ip  = optional(list(string), [])
    regra_tags_rede  = optional(list(string), [])

    regra_permite = optional(list(object({
      protocolo = string
      portas    = optional(list(string))
    })), [])
    regra_bloqueia = optional(list(object({
      protocolo = string
      portas    = optional(list(string))
    })), [])
  }))
  description = "Lista de regras de firewall de tráfego de saída (egress). Variáveis da lista: 'regra_nome': nome da regra, 'regra_descricao': descrição da regra, 'regra_desativada': indica se a regra deve ser desativada, 'regra_prioridade': prioridade da regra (maior melhor), 'regra_destino_ip': IP de destino do tráfego em formato CIDR, 'regra_origem_ip': IP de origem do tráfego em formato CIDR, 'regra_tags_rede': tag da regra de firewall pra ser usado nos recursos, 'regra_permite': lista de protocolos e portas para liberação de acesso, 'regra_bloqueia': lista de protocolos e portas para bloqueio de acesso."
  default     = []
}
