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
  static int? escolha;
  static String? tituloMenu;
  final DAO repo;

  Sistema({required this.repo});

  Future<void> inicializar() async {
    print('\n Inicializado Sistema para Cadastro de Empresas');

    do {
      menuPrincipal();
      escolha = int.parse(stdin.readLineSync()!);

      switch (escolha) {
        case 1:
          await menuGeralCadastro(1, 'CADASTRO');
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

  Future<void> menuGeralCadastro(int escolha, String titulo) async {
    print('''

[Menu $titulo] : Informe uma opção para $titulo
[1] -> Pessoa Física
[2] -> Pessoa Jurídica
''');
    escolha = int.parse(stdin.readLineSync()!);
    switch (escolha) {
      case 1:
        await cadastrarEmpresa(1);
        break;
      case 2:
        cadastrarEmpresa(2);
        break;
      default:
        erroEscolhaOpcao();
        break;
    }
  }

  Future<void> cadastrarEmpresa(int escolha) async {
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

    razaoSocial = funcAuxiliar(razaoSocial);
    nomeFantasia = funcAuxiliar(nomeFantasia);
    cnpj = funcAuxiliar(cnpj);
    cnpj = PessoaJuridica.validarDocumento(cnpj);
    // do {
    //   razaoSocial = setRazaoSocial();
    // } while (razaoSocial.isEmpty);
    // do {
    //   nomeFantasia = setNomeFantasia();
    // } while (nomeFantasia.isEmpty);
    // do {
    //   cnpj = setCNPJ();
    //   cnpj = PessoaJuridica.validarDocumento(cnpj);
    // } while (cnpj.isEmpty);
    do {
      telefone = setTelefone();
      telefone = Pessoa.validarTelefone(telefone);
    } while (telefone.isEmpty);
    do {
      numero = setNumero();
    } while (numero.isEmpty);
    do {
      complemento = setComplemento();
    } while (complemento.isEmpty);

    do {
      cep = setCep();
      var json = await fetch(cep, 'json');
      if (json.isNotEmpty) {
        logradouro = json['logradouro'];
        bairro = json['bairro'];
        estado = json['uf'];
        cidade = json['localidade'];
        telefone = '(${json['ddd']}) $telefone';
        confirmaResultadoCep(json);
      } else {
        print(
            "Erro na busca do Edereço pelo CEP. Informe os campos manuealmente.");
        do {
          logradouro = setLogradouro();
        } while (logradouro.isEmpty);
        do {
          bairro = setBairro();
        } while (bairro.isEmpty);
        do {
          estado = setEstado();
        } while (estado.isEmpty);
        do {
          cidade = setCidade();
        } while (cidade.isEmpty);
      }
    } while (cep.isEmpty);

    Endereco endereco = Endereco(
      logradouro: logradouro,
      numero: numero,
      complemento: complemento,
      bairo: bairro,
      estado: estado,
      cep: cep,
      cidade: cidade,
    );

    if (escolha == 1) {
      do {
        nome = setNome();
      } while (nome.isEmpty);
      do {
        cpf = setCPF();
        cpf = PessoaFisica.validarDocumento(cpf);
      } while (cpf.isEmpty);

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
    } else if (escolha == 2) {
      do {
        razaoSocialSocio = setRazaoSocialSocio();
      } while (razaoSocialSocio.isEmpty);
      do {
        nomeFantasiaSocio = setNomeFantasiaSocio();
      } while (nomeFantasiaSocio.isEmpty);
      do {
        cnpjSocio = setCnpjSocio();
      } while (cnpjSocio.isEmpty);

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

String setRazaoSocial() {
  print('Informe a Razão Social da Empresa:');
  return stdin.readLineSync()!;
}

String setNomeFantasia() {
  print('Informe o nome fantasia da Empresa:');
  return stdin.readLineSync()!;
}

String setCNPJ() {
  print('Informe o CNPJ da Empresa:');
  return stdin.readLineSync()!;
}

String setTelefone() {
  print('Informe o Telefone da Empresa:');
  return stdin.readLineSync()!;
}

String setCep() {
  print('Informe o Cep da Empresa:');
  return stdin.readLineSync()!;
}

void confirmaResultadoCep(Map<dynamic, dynamic> json) {
  print('''

Confirme as informasções para o CEP: ${json['cep']}
Logradouro: ${json['logradouro']}
Bairro: ${json['bairro']}
Cidade: ${json['localidade']}
Estado: ${json['uf']}

Informe:
[1] -> Para confirmar.
[2] -> Informar os campos manualmente
''');
  String cep = stdin.readLineSync()!;
  switch (cep) {
    case '1':
      break;
    case '2':
      json.clear();
      return;
    default:
      print(
          'Você deve informar 1 para confirmar os dados do Endereço ou 2 para inseri-los manualmente.');
  }
}

String setComplemento() {
  print('Informe um complemento para o endereço da Empresa:');
  return stdin.readLineSync()!;
}

String setLogradouro() {
  print('Informe o logradouro da Empresa:');
  return stdin.readLineSync()!;
}

String setNumero() {
  print('Informe o número do Endereço da Empresa:');
  return stdin.readLineSync()!;
}

String setBairro() {
  print('Informe o bairro da Empresa:');
  return stdin.readLineSync()!;
}

String setEstado() {
  print('Informe a unidade federativa da Empresa:');
  return stdin.readLineSync()!;
}

String setNome() {
  print('Infrome o nome do sócio responsável');
  return stdin.readLineSync()!;
}

String setCPF() {
  print('Infrome o cpf do sócio responsável');
  return stdin.readLineSync()!;
}

String setRazaoSocialSocio() {
  print('Informe a Razão Social do sócio responsável');
  return stdin.readLineSync()!;
}

String setNomeFantasiaSocio() {
  print('Infrome o Nome Fantasia do sócio responsável');
  return stdin.readLineSync()!;
}

String setCnpjSocio() {
  print('Infrome o cnpj do sócio responsável');
  return stdin.readLineSync()!;
}

String setCidade() {
  print('Informe a cidade em que a Empresa esta sediada');
  return stdin.readLineSync()!;
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
