# Módulo de Instâncias GCP

- Este módulo cria instâncias de Virtual Machine (VM) no Google Cloud Platform (GCP) utilizando Terraform e fornece várias saídas úteis.
- É possível adicionar discos adicionais, script de inicialização (sysprep) em sistemas Windows e script de boot.

## Variáveis de entrada

### `projeto`
- **Tipo**: `string`
- **Descrição**: ID do projeto.
- **Validação**: Não pode ser vazia.

### `regiao`
- **Tipo**: `string`
- **Descrição**: Região onde vai ser aplicado.
- **Validação**: Não pode ser vazia.

### `zona`
- **Tipo**: `string`
- **Descrição**: Zona onde vai ser aplicado.
- **Validação**: Não pode ser vazia.

### `nome_vm`
- **Tipo**: `string`
- **Descrição**: Nome da instância/VM.
- **Validação**: Não pode ser vazia.

### `tipo_vm`
- **Tipo**: `string`
- **Descrição**: Tipo de instância a ser aplicada.
- **Validação**: Não pode ser vazia.

### `sistema_operacional`
- **Tipo**: `string`
- **Descrição**: Nome ou família do sistema operacional a ser utilizado. Será utilizada a última imagem disponível do sistema operacional. Se informar a variável `sistema_operacional_imagem`, essa configuração será ignorada.
- **Padrão**: `""`
- **Validação**: Deve ser um dos valores: `centos-7`, `centos-stream-9`, `debian-10`, `debian-11`, `debian-12`, `rhel-7`, `rhel-8`, `rhel-9`, `rocky-linux-8`, `rocky-linux-9`, `sles-12`, `sles-15`, `ubuntu-2004-lts`, `ubuntu-2204-lts`, `ubuntu-2404-lts-amd64`, `ubuntu-minimal-2004-lts`, `ubuntu-minimal-2204-lts`, `ubuntu-minimal-2404-lts-amd64`, `ubuntu-pro-1604-lts`, `ubuntu-pro-1804-lts`, `ubuntu-pro-2004-lts`, `ubuntu-pro-2204-lts`, `ubuntu-pro-2404-lts-amd64`, `windows-2016-core`, `windows-2016`, `windows-2019-core`, `windows-2019`, `windows-2022-core`, `windows-2022`

### `sistema_operacional_projeto`
- **Tipo**: `string`
- **Descrição**: Nome do projeto GCP do sistema operacional. Opcional se for informada uma imagem ou for da família `windows`, `ubuntu`, `centos`, `rhel`, `debian`, `rocky`, `suse` ou `sles`.
- **Padrão**: `""`

### `sistema_operacional_imagem`
- **Tipo**: `string`
- **Descrição**: Nome da imagem do sistema operacional. Deve ser usada quando não é informada uma família de sistema operacional.
- **Padrão**: `""`

### `tamanho_disco_boot`
- **Tipo**: `number`
- **Descrição**: Tamanho em GB do disco de boot.
- **Padrão**: `100`

### `tipo_disco_boot`
- **Tipo**: `string`
- **Descrição**: Tipo do disco de boot.
- **Padrão**: `pd-standard`

### `script_boot`
- **Tipo**: `string`
- **Descrição**: Caminho do script a ser executado a cada boot da instância/VM. Bash para Linux ou PowerShell para Windows.
- **Padrão**: `""`

### `script_sysprep`
- **Tipo**: `string`
- **Descrição**: Caminho do script a ser executado na criação da instância/VM. Não disponível para Linux. Apenas PowerShell para Windows.
- **Padrão**: `""`

### `rede`
- **Tipo**: `string`
- **Descrição**: Nome da rede da instância.
- **Padrão**: `default`

### `subrede`
- **Tipo**: `string`
- **Descrição**: Nome da subrede da instância.
- **Padrão**: `default`

### `ip_privado_fixo`
- **Tipo**: `string`
- **Descrição**: Define um IP privado fixo para a instância.
- **Padrão**: `""`

### `ip_publico`
- **Tipo**: `bool`
- **Descrição**: Indica se a instância terá um IP público.
- **Padrão**: `false`

### `ip_publico_fixo`
- **Tipo**: `string`
- **Descrição**: Define um IP público fixo para a instância. Precisa existir a reserva de IP estático no GCP.
- **Padrão**: `""`

### `tags_rede`
- **Tipo**: `list(string)`
- **Descrição**: Lista de regras de firewall.
- **Padrão**: `[]`

### `disco_adicional`
- **Tipo**: `map(object({ tamanho = number, tipo = string }))`
- **Descrição**: Lista de discos adicionais. Variáveis do objeto: 'tamanho' em GB do disco adicional e 'tipo' do disco adicional. A chave de cada objeto será o sufixo do nome do disco. Não é permitido usar a chave 'boot-disk'.
- **Padrão**: `{}`
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

### `instancia_imagem`
- **Descrição**: Nome da imagem que foi utilizada na criação da instância.
- **Valor**: Nome da imagem que foi utilizada na criação da instância.

