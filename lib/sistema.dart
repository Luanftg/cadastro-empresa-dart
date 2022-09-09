import 'dart:io';
import 'dart:convert';
import 'package:cadastro_empresa/pessoa_model.dart';
import 'package:http/http.dart' as http;
import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/empresa_model.dart';
import 'package:cadastro_empresa/endereco_model.dart';
import 'package:cadastro_empresa/pessoaFisica_model.dart';
import 'package:cadastro_empresa/pessoaJuridica_model.dart';
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
          menuGeralCadastro('4', 'DELEÇÃO');
          break;
        case '5':
          encerrar();
          break;
        default:
          erroEscolhaOpcao();
      }
    } while (escolha != '5');
  }

  void encerrar() {
    print('Sistema finalizado.');
    return;
  }

  void menuPrincipal() {
    print('''

[Menu Principal] : Informe a opção desejada
[1] -> Cadastro
[2] -> Visualização
[3] -> Deleção
[4] -> Atualização
[5] -> Encerramento
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
    String razaoSocial = 'Razao Social';
    String nomeFantasia = 'Nome Fantasia';
    String cnpj = 'CNPJ';
    String telefone = 'Telefone';
    String cep = 'CEP';
    String complemento = 'Complemento';
    String logradouro = 'Logradouro';
    String numero = "Número";
    String bairro = 'Bairro';
    String estado = 'Estado';
    String nome = 'Nome';
    String cpf = 'CPF';
    String razaoSocialSocio = 'Razão Social do Sócio';
    String nomeFantasiaSocio = 'Nome Fantasia do Sócio';
    String cnpjSocio = 'CNPJ do Sócio';
    String cidade = 'Cidade';
    var mapDeCepEmJson;
    String resultadoConfirmaCep = '';

    razaoSocial = funcAuxiliar(razaoSocial);
    nomeFantasia = funcAuxiliar(nomeFantasia);

    cnpj = funcAuxiliar(cnpj);
    cnpj = PessoaJuridica.validarDocumento(cnpj);

    telefone = funcAuxiliar(telefone);
    telefone = Pessoa.validarTelefone(telefone);

    numero = funcAuxiliar(numero);
    complemento = funcAuxiliar(complemento);
    cep = funcAuxiliar(cep);

    try {
      mapDeCepEmJson = await fetch(cep, 'json');
      exibeResultadoCep(mapDeCepEmJson);
      resultadoConfirmaCep = confirmaResultadoCep();
      if (resultadoConfirmaCep == '2') {
        logradouro = funcAuxiliar(logradouro);
        bairro = funcAuxiliar(bairro);
        estado = funcAuxiliar(estado);
        cidade = funcAuxiliar(cidade);
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

    Endereco endereco = Endereco(
      logradouro: logradouro,
      numero: numero,
      complemento: complemento,
      bairo: bairro,
      estado: estado,
      cep: cep,
      cidade: cidade,
    );

    if (escolha == '1') {
      nome = funcAuxiliar(nome);
      cpf = funcAuxiliar(cpf);
      cpf = PessoaFisica.validarDocumento(cpf);

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

      try {
        repo.adicionar(novaEmpresa);
        print('Empresa cadastrada com sucesso!');
      } catch (e) {
        print(e);
      }
    } else if (escolha == '2') {
      razaoSocialSocio = funcAuxiliar(razaoSocialSocio);
      nomeFantasiaSocio = funcAuxiliar(nomeFantasiaSocio);
      cnpjSocio = funcAuxiliar(cnpjSocio);
      cnpjSocio = PessoaJuridica.validarDocumento(cnpjSocio);

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

String funcAuxiliar(String parametro) {
  do {
    print('Informe o $parametro');
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
