# Estudo servidor openVPN  

## Objetivo

Estudo sobre a criação de infraestrutura automatizada de um servidor para hospedar [OpenVPN][1]

## Tecnologias

- Terraform 1.6
- Provider AWS 5.23
- Debian 11
- Ansible

## Requerimentos



## Estrutura

### IaC - Terraform

Codificação terraform dividida em *"módulos"* pensando em uma tática de manutenibilidade

**c1-providers.tf** - Configuração básica para funcionamento do terraform
> Ao trabalhar em uma squad que tem o foco no versionamento da infraestrutura como código ( IaC ) com terraform, é de extrama importância utilizar os backend remotos - AWS [S3][3] para compartilhar o estado da infraestrutura com o time.

## Referências

https://openvpn.net/vpn-software-packages/debian/


[1]:https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11
[3]:https://developer.hashicorp.com/terraform/language/settings/backends/s3