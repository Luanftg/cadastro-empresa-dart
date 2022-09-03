# Desafio Módulo Dart

Foi solicitado a criação de um sistema de registros de empresas. Toda
empresa nesse sistema deve ter um sócio associado a ela, que pode ser uma
Pessoa Física ou uma Pessoa Jurídica.
Sobre as entidades:

- Uma Empresa no sistema tem os seguintes dados: ID, Razão Social,
Nome Fantasia, CNPJ, Endereço (Logradouro, Número, Complemento,
Bairro, Estado e CEP), Telefone, Horário do Cadastro e Sócio.
- Uma Pessoa Física tem os seguintes dados: Nome, CPF e Endereço
(Logradouro, Número, Complemento, Bairro, Estado e CEP).
- Uma Pessoa Jurídica tem os seguintes dados: Razão Social, Nome
Fantasia, CNPJ, Endereço (Logradouro, Número, Complemento, Bairro,
Estado e CEP).

O sistema ao ser executado deve oferecer as seguintes opções:

- [] Cadastrar uma nova empresa;
- [] Buscar Empresa cadastrada por CNPJ;
- [] Buscar Empresa por CPF/CNPJ do Sócio;
- [] Listar Empresas cadastradas em ordem alfabética (baseado na Razão
Social);
- [] Excluir uma empresa;
- [] Sair.

## Requisitos

- Toda pessoa seja física ou jurídica, devem saber validar seu
documento (CPF/CNPJ);
- O programa deve ser criado considerando os recursos disponíveis da
Orientação à Objetos e boas práticas;
- O programa deve ter no mínimo uma herança;
- CPF e CNPJ são do tipo String, mas o input do usuário será apenas
números;
- Telefone é do tipo String, mas o input do usuário será apenas
números, ex.: 11987654321;
- CEP é do tipo String, mas o input do usuário será apenas números;
- O ID deve ser único, para cada Empresa cadastrada;
- O horário de cadastro deve ser obtido automaticamente pelo sistema;
- A impressão do conteúdo de uma empresa deve atender no mínimo a
seguinte formatação:

![image](https://i.imgur.com/rxxhn4U.png)
