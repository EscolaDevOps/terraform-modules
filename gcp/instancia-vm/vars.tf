variable "projeto" {
  type        = string
  description = "ID do projeto."
  validation {
    condition     = length(trimspace(var.projeto)) > 0
    error_message = "A variavel 'projeto' não pode ser vazia. Forneça um ID de projeto válido."
  }
}

variable "regiao" {
  type        = string
  description = "Região onde vai ser aplicado."
  validation {
    condition     = length(trimspace(var.regiao)) > 0
    error_message = "A variavel 'regiao' não pode ser vazia. Forneça um ID de região válido."
  }
}

variable "zona" {
  type        = string
  description = "Zona onde vai ser aplicado."
  validation {
    condition     = length(trimspace(var.zona)) > 0
    error_message = "A variavel 'zona' não pode ser vazia. Forneça um ID de zona válida."
  }
}

variable "nome_vm" {
  type        = string
  description = "Nome da instância/VM."
  validation {
    condition     = length(trimspace(var.nome_vm)) > 0
    error_message = "A variavel 'nome_vm' não pode ser vazia. Forneça um nome de instância/VM válido."
  }
}

variable "tipo_vm" {
  type        = string
  description = "Tipo de instância a ser aplicada."
  validation {
    condition     = length(trimspace(var.tipo_vm)) > 0
    error_message = "A variavel 'tipo_vm' não pode ser vazia. Forneça um tipo de instância/VM válido."
  }
}

variable "imagem" {
  type        = string
  description = "Nome da imagem do sistema operacional."
  validation {
    condition     = length(trimspace(var.imagem)) > 0
    error_message = "A variavel 'projeto' não pode ser vazia. Forneça um ID de projeto válido."
  }
}

variable "tamanho_disco_boot" {
  type        = number
  description = "Tamanho em GB do disco de boot."
  default = 100
}

variable "tipo_disco_boot" {
  type        = string
  description = "Tipo do disco de boot."
  default = "pd-standard"
}

variable "script_boot" {
  type = string
  description = "Caminho do script a ser executado a cada boot da instância/VM. Bash para Linux ou PowerShell para Windows."
  default = ""
}

variable "script_sysprep" {
  type = string
  description = "Caminho do script a ser executado na criação da instância/VM. Não dispoível para Linux. Apenas PowerShell para Windows."
  default = ""
}

variable "rede" {
  type        = string
  description = "Nome da rede da instância."
  default = "default"
}

variable "subrede" {
  type        = string
  description = "Nome da subrede da instância."
  default = "default"
}

variable "ip_publico" {
  type = bool
  description = "Indica se tem IP público."
  default = false
}

variable "tags_rede" {
  type = list(string)
  description = "Lista de regras de firewall."
  default = [ ]
}

variable "disco_adicional" {
  type = map(object({
    tamanho = number
    tipo    = string
  }))
  description = "Lista de discos adicionais. Variaveis do objeto: 'tamanho' em GB do disco adicional e 'tipo' do disco adicional. A chave de cada objeto vai ser o sufixo do nome do disco. Não é permitido usar a chave 'boot-disk'."
  default = { }
  validation {
    condition = alltrue([for key in keys(var.disco_adicional) : key != "boot-disk"])
    error_message = "A chave 'boot-disk' não é permitida para lista de discos adicionais."
  }
}
