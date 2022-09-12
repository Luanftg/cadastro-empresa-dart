import 'dart:io';
import 'dart:convert';
import 'package:cadastro_empresa/pessoa_model.dart';
import 'package:http/http.dart' as http;
import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/empresa_model.dart';
import 'package:cadastro_empresa/endereco_model.dart';
import 'package:cadastro_empresa/pessoa_fisica_model.dart';
import 'package:cadastro_empresa/pessoa_juridica_model.dart';
import 'package:uuid/uuid.dart';

class Sistema {
  static String? escolha;
  static String? tituloMenu;
  final DAO repo;

  Sistema({required this.repo});

  Future<void> inicializar() async {
    print('\n Inicializado Sistema para Cadastro de Empresas');

    do {
      menuPrincipal();
      escolha = stdin.readLineSync()!;

      switch (escolha) {
        case '0':
          encerrar();
          break;
        case '1':
          await menuGeralCadastro('1', 'CADASTRO');
          break;
        case '2':
          await repo.encontrarTodos();
          break;
        case '3':
          print('Informe o ID da empresa para EXCLUIR do Sistema.');
          String id = (stdin.readLineSync()!);
          await repo.deletar(id);
          break;
        case '4':
          String documento = funcAuxiliar("Informe o CNPJ da Empresa:");
          await repo.encontrarUm(documento);
          break;
        case '5':
          String documento = funcAuxiliar(
              "Informe o CPF ou CNPJ do Sócio para buscar uma Empresa:");
          repo.encontrarUm(documento);
          break;
        default:
          erroEscolhaOpcao();
      }
    } while (escolha != '0');
  }

  void encerrar() {
    print('Sistema finalizado.');
    return;
  }

  void menuPrincipal() {
    print('''

[Menu Principal] : Informe a opção desejada
[0] -> Encerramento
[1] -> Cadastro
[2] -> Visualização
[3] -> Deleção
[4] -> Busca por CNPJ da empresa
[5] -> Busca por CPF ou CNPJ de um sócio
''');
  }

  Future<void> menuGeralCadastro(String escolha, String titulo) async {
    print('''

[Menu $titulo] : Informe uma opção para $titulo
[1] -> Pessoa Física
[2] -> Pessoa Jurídica
''');
    escolha = stdin.readLineSync()!;
    switch (escolha) {
      case '1':
        await cadastrarEmpresa("1");
        break;
      case '2':
        await cadastrarEmpresa('2');
        break;
      default:
        erroEscolhaOpcao();
        break;
    }
  }

  Future<void> cadastrarEmpresa(String escolha) async {
    String razaoSocial = '';
    String nomeFantasia = '';
    String cnpj = '';
    String telefone = '';
    String cep = '';
    String cepSocio = '';
    String complemento = '';
    String logradouro = '';
    String numero = "";
    String bairro = '';
    String estado = '';
    String nome = '';
    String cpf = '';
    String cpfSocio = '';
    String razaoSocialSocio = '';
    String nomeFantasiaSocio = '';
    String cnpjSocio = '';
    String cidade = '';
    var mapDeCepEmJson;
    String resultadoConfirmaCep = '';
    String telefoneSocio = '';

    razaoSocial = funcAuxiliar('Informe a Razão Social da Empresa:');
    nomeFantasia = funcAuxiliar('Informe o Nome Fantasia da Empresa:');

    cnpj = funcAuxiliar('Informe o CNPJ da Empresa');
    cnpj = PessoaJuridica.validarDocumento(cnpj);

    telefone = funcAuxiliar('Informe o Telefone da Empresa:');
    telefone = Pessoa.validarTelefone(telefone);

    cep = funcAuxiliar("Informe o CEP da Empresa:");

    try {
      mapDeCepEmJson = await fetch(cep, 'json');
      exibeResultadoCep(mapDeCepEmJson);
      resultadoConfirmaCep = confirmaResultadoCep();
      if (resultadoConfirmaCep == '2') {
        logradouro = funcAuxiliar('Informe o Logradouro da Empresa:');
        bairro = funcAuxiliar('Informe o Bairro da Empresa:');
        estado = funcAuxiliar('Informe a Unidade Federativa da Empresa:');
        cidade = funcAuxiliar('Informe a Cidade sede da Empresa');
      } else {
        logradouro = mapDeCepEmJson['logradouro'];
        bairro = mapDeCepEmJson['bairro'];
        estado = mapDeCepEmJson['uf'];
        cidade = mapDeCepEmJson['localidade'];
        telefone = '(${mapDeCepEmJson['ddd']}) $telefone';
      }
    } catch (e) {
      print('Erro $e na chamada da Api. Informe os Campos manualmente.');
      resultadoConfirmaCep == '2';
    }

    numero = funcAuxiliar('Informe o Número de Endereço da Empresa:');
    complemento =
        funcAuxiliar('Informe um complemento para o Endereço da Empresa:');

    Endereco endereco = Endereco(
      logradouro: logradouro,
      numero: numero,
      complemento: complemento,
      bairo: bairro,
      estado: estado,
      cep: cep,
      cidade: cidade,
    );

    print("\nCadastro do Sócio da Empresa");

    cep = funcAuxiliar("\n Informe o CEP do Sócio:");

    try {
      mapDeCepEmJson = await fetch(cep, 'json');
      exibeResultadoCep(mapDeCepEmJson);
      resultadoConfirmaCep = confirmaResultadoCep();
      if (resultadoConfirmaCep == '2') {
        logradouro = funcAuxiliar('Informe o Logradouro do Sócio:');
        bairro = funcAuxiliar('Informe o Bairro do Sócio');
        estado = funcAuxiliar('Informe a Unidade Federativa do Sócio:');
        cidade = funcAuxiliar('Informe a Cidade do Sócio:');
      } else {
        logradouro = mapDeCepEmJson['logradouro'];
        bairro = mapDeCepEmJson['bairro'];
        estado = mapDeCepEmJson['uf'];
        cidade = mapDeCepEmJson['localidade'];
        telefone = '(${mapDeCepEmJson['ddd']}) $telefone';
      }
    } catch (e) {
      print('Erro $e na chamada da Api. Informe os Campos manualmente.');
      resultadoConfirmaCep == '2';
    }

    Endereco enderecoSocio = Endereco(
      logradouro: logradouro,
      numero: numero,
      bairo: bairro,
      estado: estado,
      cep: cep,
      cidade: cidade,
    );

    if (escolha == '1') {
      nome = funcAuxiliar('Informe o Nome do Sócio da Empresa');
      cpf = funcAuxiliar('Informe o CPF do Sócio da Empresa');
      cpf = PessoaFisica.validarDocumento(cpf);
      telefoneSocio = funcAuxiliar('Informe o Telefone do Sócio da Empresa');
      telefoneSocio = Pessoa.validarTelefone(telefoneSocio);

      PessoaFisica pf = PessoaFisica(
        documento: cpf,
        nomeIdentificador: nome,
        endereco: enderecoSocio,
        telefone: telefoneSocio,
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

      try {
        repo.adicionar(novaEmpresa);
        print('\nEmpresa cadastrada com sucesso!');
      } catch (e) {
        print(e);
      }
    } else if (escolha == '2') {
      razaoSocialSocio =
          funcAuxiliar('Informe a Razão Social do Sócio da Empresa');
      nomeFantasiaSocio =
          funcAuxiliar('Informe o Nome Fantasia do Sócio da Empresa');
      cnpjSocio = funcAuxiliar('Informe o CNPJ do Sócio:');
      cnpjSocio = PessoaJuridica.validarDocumento('cnpjSocio');
      telefoneSocio = funcAuxiliar('Informe o Telefone do Sócio da Empresa:');
      telefoneSocio = Pessoa.validarTelefone(telefoneSocio);

      PessoaJuridica pj = PessoaJuridica(
        documento: cnpjSocio,
        endereco: enderecoSocio,
        nomeIdentificador: razaoSocialSocio,
        nomeFantasia: nomeFantasiaSocio,
        telefone: telefoneSocio,
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

void exibeResultadoCep(Map<dynamic, dynamic> json) {
  print('''

Confirme as informações para o CEP: ${json['cep']}
Logradouro: ${json['logradouro']}
Bairro: ${json['bairro']}
Cidade: ${json['localidade']}
Estado: ${json['uf']}
''');
}

String confirmaResultadoCep() {
  String resultadoConfirmaCep;
  do {
    print('''

Informe:
[1] -> Para confirmar.
[2] -> Informar os campos manualmente
''');
    resultadoConfirmaCep = stdin.readLineSync()!;
  } while (resultadoConfirmaCep.isEmpty ||
      resultadoConfirmaCep != '1' && resultadoConfirmaCep != '2');
  return resultadoConfirmaCep;
}

String funcAuxiliar(String mensagem) {
  String parametro;
  do {
    print(mensagem);
    parametro = stdin.readLineSync()!;
  } while (parametro.isEmpty);
  return parametro;
}

Future<Map> fetch(String cep, String formato) async {
  var authority = 'viacep.com.br';
  var unencodedPath = 'ws/$cep/$formato';
  var url = Uri.https(authority, unencodedPath);
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  return json;
}
