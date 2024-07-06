# Módulos para terraform

Este repositório contém um módulo Terraform para criar e gerenciar instâncias de máquinas virtuais (VMs), redes e sub-redes no Google Cloud Platform (GCP). Ele também inclui a configuração de regras de firewall.

# Lista de módulos disponíveis

## gcp
- Grupo de módulos para uso no Google Cloud Platform (GCP).

### gcp/instancia-vm
- Este módulo cria instâncias de Virtual Machine (VM) no Google Cloud Platform (GCP) utilizando Terraform e fornece várias saídas úteis.
- É possível adicionar discos adicionais, script de inicialização (sysprep) e script de boot.

### gcp/vpc-rede
- Este módulo cria redes VPC Google Cloud Platform (GCP) utilizando Terraform, implementa diversos recursos de redes e fornece várias saídas úteis.
- É possível gerenciar subredes e regras de firewall.

Uma lista de templates com exemplos de implementação estão disponíveis na [pasta de exemplos](https://github.com/EscolaDevOps/terraform-modules/tree/main/exemplos).
