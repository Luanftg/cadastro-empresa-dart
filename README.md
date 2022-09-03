# Desafio Módulo Dart

Foi solicitado a criação de um *sistema* de **registros de empresas**.
Toda *empresa* nesse sistema deve ter um sócio associado a ela, que pode ser uma *Pessoa Física* ou uma *Pessoa Jurídica*.

## [ESTRUTURA DE DADOS]: Sobre as entidades

- [x] Uma **Empresa** no sistema tem os seguintes dados:
  - `Uuid` ID
  - `String` Razão Social
  - `String` Nome Fantasia
  - `String` CNPJ
  - `String` Telefone
  - `DateTime` Horário do Cadastro
  - `String` Sócio
  - *`Endereco` Endereço (Logradouro, Número, Complemento, Bairro,Estado e CEP).*

- [x] Uma **Pessoa Física** tem os seguintes dados:
  - `String` Nome
  - `String` CPF
  - *`Endereco` Endereço (Logradouro, Número, Complemento, Bairro,Estado e CEP).*

- [x] Uma **Pessoa Jurídica** tem os seguintes dados:
  - `String`Razão Social
  - `String` Nome Fantasia
  - `String` CNPJ
  - *`Endereco` Endereço (Logradouro, Número, Complemento, Bairro,Estado e CEP).*

O sistema ao ser executado deve oferecer as seguintes opções:

- [ ] Cadastrar uma nova empresa;
- [ ] Buscar Empresa cadastrada por CNPJ;
- [ ] Buscar Empresa por CPF/CNPJ do Sócio;
- [ ] Listar Empresas cadastradas em ordem alfabética (baseado na Razão Social);
- [ ] Excluir uma empresa;
- [ ] Sair.

## Requisitos

- [x] Toda pessoa seja física ou jurídica, devem saber validar seu
documento (CPF/CNPJ);
- [x] O programa deve ser criado considerando os recursos disponíveis da
Orientação à Objetos e boas práticas;
- [ ] O programa deve ter no mínimo uma herança;
- [x] CPF e CNPJ são do tipo String, mas o input do usuário será apenas
números;
- [x] Telefone é do tipo String, mas o input do usuário será apenas
números, ex.: 11987654321;
- [x] CEP é do tipo String, mas o input do usuário será apenas números;
- [ ] O ID deve ser único, para cada Empresa cadastrada;
- [ ] O horário de cadastro deve ser obtido automaticamente pelo sistema;
- [ ] A impressão do conteúdo de uma empresa deve atender no mínimo a
seguinte formatação:

![image](https://i.imgur.com/rxxhn4U.png)

### Solução

1. Abstração
   1. Criação dos 'contratos':
      1. ``abstract class`` Sistema
      2. ``abstract class`` Objeto de Acesso aos Dados
   2. Implementação dos 'contratos'
      1. ``class`` Sistema_Cadastro_Empresa ``implements`` Sistema
      2. ``class`` Lista_Objeto_Acesso_Dados ``implements`` Objeto de Acesso aos Dados
   3. Criação dos 'modelos'
      1. ``class`` Pessoa_Fisica ``extends`` Pessoa
      2. ``class`` Pessoa Jurídica ``extends`` Pessoa
      3. ``class`` Empresa
2. Testes
   1. Estrutura das classes
   2. pacotes: *Uuid*
3. Implementação

#### Referências

- Bibliotecas utilizadas
[pub.dev - Uuid](https://pub.dev/packages/uuid)
