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

variable "nome_vm" {
  type        = string
  description = "Nome da instância/VM."
  validation {
    condition     = length(trimspace(var.nome_vm)) > 0
    error_message = "A variável 'nome_vm' não pode ser vazia. Forneça um nome de instância/VM válido."
  }
}

variable "tipo_vm" {
  type        = string
  description = "Tipo de instância a ser aplicada."
  validation {
    condition     = length(trimspace(var.tipo_vm)) > 0
    error_message = "A variável 'tipo_vm' não pode ser vazia. Forneça um tipo de instância/VM válido."
  }
}

variable "sistema_operacional" {
  type        = string
  description = "Nome ou familia do sistema operacional a seu utilizado. Será utilizada a última imagem disponível do sistema operacional. Se informar uma imagem, essa configuração será ignorada."
  default     = ""
}

variable "sistema_operacional_projeto" {
  type        = string
  description = "Nome do projeto GCP do sistema operacional. Opcional se for informada uma imagem ou for da familia 'windows', 'ubuntu', 'centos', 'rhel', 'debian', 'rocky' ou 'suse'"
  default     = ""
}

variable "sistema_operacional_imagem" {
  type        = string
  description = "Nome da imagem do sistema operacional. Deve ser usada quando não é informada uma familia de sistema operacional."
  default     = ""
}

variable "tamanho_disco_boot" {
  type        = number
  description = "Tamanho em GB do disco de boot."
  default     = 100
}

variable "tipo_disco_boot" {
  type        = string
  description = "Tipo do disco de boot."
  default     = "pd-standard"
}

variable "script_boot" {
  type        = string
  description = "Caminho do script a ser executado a cada boot da instância/VM. Bash para Linux ou PowerShell para Windows."
  default     = ""
}

variable "script_sysprep" {
  type        = string
  description = "Caminho do script a ser executado na criação da instância/VM. Não dispoível para Linux. Apenas PowerShell para Windows."
  default     = ""
}

variable "rede" {
  type        = string
  description = "Nome da rede da instância."
  default     = "default"
}

variable "subrede" {
  type        = string
  description = "Nome da subrede da instância."
  default     = "default"
}

variable "ip_privado_fixo" {
  type        = string
  description = "Define um IP privado fixo para a instância."
  default     = ""
}

variable "ip_publico" {
  type        = bool
  description = "Indica se tem IP público."
  default     = false
}

variable "ip_publico_fixo" {
  type        = string
  description = "Define um IP publico fixo para a instância. Precisa existir a reserva de IP estático no GCP."
  default     = ""
}

variable "tags_rede" {
  type        = list(string)
  description = "Lista de regras de firewall."
  default     = []
}

variable "disco_adicional" {
  type = map(object({
    tamanho = number
    tipo    = string
  }))
  description = "Lista de discos adicionais. Variaveis do objeto: 'tamanho' em GB do disco adicional e 'tipo' do disco adicional. A chave de cada objeto vai ser o sufixo do nome do disco. Não é permitido usar a chave 'boot-disk'."
  default     = {}
  validation {
    condition     = alltrue([for key in keys(var.disco_adicional) : key != "boot-disk"])
    error_message = "A chave 'boot-disk' não é permitida para lista de discos adicionais."
  }
}
