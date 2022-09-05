import 'dart:io';

import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/empresa_model.dart';
import 'package:cadastro_empresa/endereco_model.dart';
import 'package:cadastro_empresa/pessoaFisica.dart';
import 'package:cadastro_empresa/pessoaJuridica.dart';
import 'package:uuid/uuid.dart';

class Sistema {
  static int? escolha;
  static String? tituloMenu;
  final DAO repo;

  Sistema({required this.repo});

  void inicializar() {
    print('Inicializado Sistema para Cadastro de Empresas');

    do {
      menuPrincipal();
      escolha = int.parse(stdin.readLineSync()!);

      switch (escolha) {
        case 1:
          menuGeralCadastro(1, 'CADASTRO');
          break;
        case 2:
          repo.encontrarTodos();
          break;
        case 3:
          print('Informe o ID da empresa para EXCLUIR do Sistema.');
          String id = (stdin.readLineSync()!);
          repo.deletar(id);
          break;
        case 4:
          menuGeralCadastro(4, 'DELEÇÃO');
          break;
        case 5:
          encerrar();
          break;
        default:
          erroEscolhaOpcao();
          return;
      }
    } while (escolha != 5);
  }

  void encerrar() {
    print('Sistema finalizado.');
    return;
  }

  void menuPrincipal() => print('''

[Menu Principal] : Informe a opção desejada
[1] -> Cadastro
[2] -> Visualização
[3] -> Deleção
[4] -> Atualização
[5] -> Encerramento
''');

  void menuGeralCadastro(int escolha, String titulo) {
    print('''

[Menu $titulo] : Informe uma opção para $titulo
[1] -> Pessoa Física
[2] -> Pessoa Jurídica
''');
    escolha = int.parse(stdin.readLineSync()!);
    switch (escolha) {
      case 1:
        cadastrarEmpresa(1);
        break;
      case 2:
        cadastrarEmpresa(2);
        break;
      default:
        erroEscolhaOpcao();
        break;
    }
  }

  void cadastrarEmpresa(int escolha) {
    print('Informe a Razão Social da Empresa:');
    String razaoSocial = stdin.readLineSync()!;
    print('Informe o nome fantasia da Empresa:');
    String nomeFantasia = stdin.readLineSync()!;
    print('Informe o CNPJ da Empresa:');
    String cnpj = stdin.readLineSync()!;
    print('Informe o Telefone da Empresa:');
    String telefone = stdin.readLineSync()!;
    print('Informe o logradouro da Empresa:');
    String logradouro = stdin.readLineSync()!;
    print('Informe o número da Empresa:');
    int numero = int.parse(stdin.readLineSync()!);
    print('Informe o complemento da Empresa:');
    String complemento = stdin.readLineSync()!;
    print('Informe o bairro da Empresa:');
    String bairro = stdin.readLineSync()!;
    print('Informe o estado da Empresa:');
    String estado = stdin.readLineSync()!;
    print('Informe o CEP da Empresa:');
    String cep = stdin.readLineSync()!;

    Endereco endereco = Endereco(
      logradouro: logradouro,
      numero: numero,
      complemento: complemento,
      bairo: bairro,
      estado: estado,
      cep: cep,
    );

    if (escolha == 1) {
      print('Infrome o nome do sócio responsável');
      String nome = stdin.readLineSync()!;
      print('Infrome o cpf do sócio responsável');
      String cpf = stdin.readLineSync()!;

      PessoaFisica pf = PessoaFisica(
        documento: cpf,
        nomeIdentificador: nome,
        endereco: endereco,
      );

      Empresa novaEmpresa = Empresa(
        id: Uuid().v1(),
        criadoEm: DateTime.now(),
        razaoSocial: razaoSocial,
        nomeFantasia: nomeFantasia,
        cnpj: cnpj,
        endereco: endereco,
        telefone: telefone,
        socio: pf,
      );
      repo.adicionar(novaEmpresa);
      print('Empresa cadastrada com sucesso!');
    } else if (escolha == 2) {
      print('Infrome a Razão Social do sócio responsável');
      String razaoSocialSocio = stdin.readLineSync()!;
      print('Infrome o nomeFantasia do sócio responsável');
      String nomeFantasiaSocio = stdin.readLineSync()!;
      print('Infrome o cnpj do sócio responsável');
      String cnpjSocio = stdin.readLineSync()!;

      PessoaJuridica pj = PessoaJuridica(
        documento: cnpjSocio,
        endereco: endereco,
        nomeIdentificador: razaoSocialSocio,
        nomeFantasia: nomeFantasiaSocio,
      );

      Empresa novaEmpresa = Empresa(
        id: Uuid().v1(),
        criadoEm: DateTime.now(),
        razaoSocial: razaoSocial,
        nomeFantasia: nomeFantasia,
        cnpj: cnpj,
        endereco: endereco,
        telefone: telefone,
        socio: pj,
      );

      try {
        repo.adicionar(novaEmpresa);
        print('Empresa cadastrada com sucesso!');
      } catch (e) {
        print(e);
      }
    } else {
      erroEscolhaOpcao();
    }
  }

  void erroEscolhaOpcao() =>
      print('[ERRO!] -> Você deve informar uma das opções válidas.');
}
