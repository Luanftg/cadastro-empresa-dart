import 'dart:io';
import 'package:cadastro_empresa/cepApi.dart';
import 'package:cadastro_empresa/pessoa_model.dart';
import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/empresa_model.dart';
import 'package:cadastro_empresa/endereco_model.dart';
import 'package:cadastro_empresa/pessoa_fisica_model.dart';
import 'package:cadastro_empresa/pessoa_juridica_model.dart';
import 'package:cadastro_empresa/sistema_io.dart';
import 'package:uuid/uuid.dart';

class Sistema {
  static String? escolha;
  static String? tituloMenu;
  final DAO repo;
  CepApi viaCepApi = CepApi();

  Sistema({required this.repo});

  Future<void> inicializar() async {
    print(SistemaIO.apresentacao);

    do {
      //  menuPrincipal();
      //  escolha = stdin.readLineSync()!;

      escolha = SistemaIO.pergunta(SistemaIO.tituloMenuPrincipal);
      switch (escolha) {
        case '0':
          encerrar();
          break;
        case '1':
          //escolha = SistemaIO.pergunta(SistemaIO.menuGeralCadastro);
          await menuGeralCadastro('1', 'CADASTRO');
          break;
        case '2':
          await repo.encontrarTodos();
          break;
        case '3':
          print(SistemaIO.delecaoID);
          //id = SistemaIO.pergunta(SistemaIO.delecaoID);
          String id = (stdin.readLineSync()!);
          await repo.deletar(id);
          //await repo.deletar(SistemaIO.pergunta(SistemaIO.delecaoID));
          break;
        case '4':
          String documento = funcAuxiliar(SistemaIO.cnpjEmpresa);
          await repo.encontrarUm(documento);
          break;
        case '5':
          String documento = funcAuxiliar(SistemaIO.buscaEmpresaporSocio);
          repo.encontrarUm(documento);
          //repo.encontrarUm(SistemaIO.pergunta(SistemaIO.buscaEmpresaporSocio));
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
      mapDeCepEmJson = await viaCepApi.fetch(cep, 'json');
      //viaCepApi.exibeResultadoCep(mapDeCepEmJson);
      stdout.write(mapDeCepEmJson);
      //resultadoConfirmaCep = viaCepApi.confirmaResultadoCep();
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
      bairro: bairro,
      estado: estado,
      cep: cep,
      cidade: cidade,
    );

    print("\nCadastro do Sócio da Empresa");

    cep = funcAuxiliar("\n Informe o CEP do Sócio:");

    try {
      mapDeCepEmJson = await viaCepApi.fetch(cep, 'json');
      //viaCepApi.exibeResultadoCep(mapDeCepEmJson);
      //resultadoConfirmaCep = viaCepApi.confirmaResultadoCep();
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
      bairro: bairro,
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
      cnpjSocio = PessoaJuridica.validarDocumento(cnpjSocio);
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

String funcAuxiliar(String mensagem) {
  String parametro;
  do {
    print(mensagem);
    parametro = stdin.readLineSync()!;
  } while (parametro.isEmpty);
  return parametro;
}
