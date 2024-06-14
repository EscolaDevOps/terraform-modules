variable "projeto" {
  type        = string
  description = "ID do projeto."
  validation {
    condition     = length(trimspace(var.projeto)) > 0
    error_message = "A variável 'projeto' não pode ser vazia. Forneça um ID de projeto válido."
  }
}

variable "regiao" {
  type        = string
  description = "Região onde vai ser aplicado."
  validation {
    condition     = length(trimspace(var.regiao)) > 0
    error_message = "A variável 'regiao' não pode ser vazia. Forneça um ID de região válido."
  }
}

variable "zona" {
  type        = string
  description = "Zona onde vai ser aplicado."
  validation {
    condition     = length(trimspace(var.zona)) > 0
    error_message = "A variável 'zona' não pode ser vazia. Forneça um ID de zona válida."
  }
}

variable "rede_nome" {
  description = "Nome da rede VPC"
  type        = string
  validation {
    condition     = length(trimspace(var.rede_nome)) > 0
    error_message = "A variável 'rede_nome' não pode ser vazia. Forneça um nome de rede válido."
  }
}

