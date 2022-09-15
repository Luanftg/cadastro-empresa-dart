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

- [x] Cadastrar uma nova empresa;
- [x] Buscar Empresa cadastrada por CNPJ;
- [x] Buscar Empresa por CPF/CNPJ do Sócio;
- [x] Listar Empresas cadastradas em ordem alfabética (baseado na Razão Social);
- [x] Excluir uma empresa;
- [x] Sair.

## Requisitos

- [x] Toda pessoa seja física ou jurídica, devem saber validar seu
documento (CPF/CNPJ);
- [x] O programa deve ser criado considerando os recursos disponíveis da
Orientação à Objetos e boas práticas;
- [x] O programa deve ter no mínimo uma herança;
- [x] CPF e CNPJ são do tipo String, mas o input do usuário será apenas
números;
- [x] Telefone é do tipo String, mas o input do usuário será apenas
números, ex.: 11987654321;
- [x] CEP é do tipo String, mas o input do usuário será apenas números;
- [x] O ID deve ser único, para cada Empresa cadastrada;
- [x] O horário de cadastro deve ser obtido automaticamente pelo sistema;
- [x] A impressão do conteúdo de uma empresa deve atender no mínimo a
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
   2. pacotes: *Uuid* - gerador de ID
   3. Estrutura de armazenamento de dados com ``File class``
3. Implementação

4. **Correções para 15/09**

- [ ] Formatar campos na impressao:
  - [ ] cep
  - [ ] data de cadastro
  - [ ] endereco - posição
- [ ] Remover parenteses da empresa retornada : adicionar ``first`` as buscas por documento EM AMBAS AS BUSCAS!
- [ ] Remover impressão de ID duplicado
- [ ] Adicionar quebra de linha na mensagem de confirmação da deleção por ID
- [ ] Adicionar quebra de linha na impressão do rsultado da busca por lista vazia
- [ ] Adicionar quebra de linha na impressão da mensagem de finalização do Sistema

#### Referências

- Bibliotecas utilizadas
  - [pub.dev - Uuid](https://pub.dev/packages/uuid)
  - [pub.dev - File class](https://api.dart.dev/stable/2.18.0/dart-io/File-class.html)
  - [4devs](https://www.4devs.com.br/)
