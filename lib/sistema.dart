import 'dart:io';
import 'package:cadastro_empresa/camadas/dados/externos/cepApi.dart';
import 'package:cadastro_empresa/camadas/dados/dao.dart';
import 'package:cadastro_empresa/camadas/apresentacao/sistema_controlador.dart';
import 'package:cadastro_empresa/camadas/apresentacao/sistema_io.dart';
import 'package:uuid/uuid.dart';

import 'camadas/dominio/entidades/empresa_entidade.dart';
import 'camadas/dominio/entidades/pessoa_entidade.dart';
import 'camadas/dominio/entidades/pessoa_fisica_entidade.dart';
import 'camadas/dominio/entidades/pessoa_juridica_entidade.dart';

class Sistema {
  static Enum? escolha;
  //static String? tituloMenu;
  final DAO repo;
  CepApi viaCepApi = CepApi();
  late Pessoa pessoa;
  late Empresa empresa;

  Sistema({required this.repo});

  Future<void> inicializar() async {
    stdout.writeln(SistemaIO.apresentacao);

    do {
      escolha = SistemaIO.menuPrincipal();

      switch (escolha) {
        case MenuPrincipal.encerrar:
          encerrar();
          break;
        case MenuPrincipal.cadastrar:
          escolha = SistemaIO.menuPessoa();
          await cadastrarEmpresa(escolha);
          break;
        case MenuPrincipal.listarTodos:
          await repo.encontrarTodos();
          break;
        case MenuPrincipal.deletar:
          print(SistemaIO.delecaoID);
          await repo.deletar(
            SistemaIO.pergunta(SistemaIO.delecaoID),
          );
          break;
        case MenuPrincipal.buscarPorCNPJEmpresa:
          await repo.encontrarUm(
            SistemaIO.pergunta(SistemaIO.cnpjEmpresa),
          );
          break;
        case MenuPrincipal.buscarPorCNPJCPFSocio:
          repo.encontrarUm(
            SistemaIO.pergunta(SistemaIO.buscaEmpresaporSocio),
          );
          break;
        default:
          stdout.write(SistemaIO.erroOpcao);
      }
    } while (escolha != null);
  }

  void encerrar() {
    stdout.write(SistemaIO.encerrar);
    escolha = null;
  }

  Future<void> cadastrarEmpresa(Enum? escolha) async {
    // Se Pessoa Fisica
    if (escolha == PessoaMenu.fisica) {
      //Informações da Pessoa Fisica
      stdout.writeln(SistemaIO.cadastroSocio);
      stdout.writeln(SistemaIO.endereco);

      pessoa = PessoaFisica(
        documento: PessoaFisica.validarDocumento(
          SistemaIO.pergunta(SistemaIO.cpfSocio),
        ),
        nomeIdentificador: SistemaIO.pergunta(SistemaIO.nomeSocio),
        endereco: await SistemaControlador.atribuiEndereco(),
        telefone: Pessoa.validarTelefone(
          SistemaIO.pergunta(SistemaIO.telefoneSocio),
        ),
      );
      //Se for PESSOA JURIDICA
    } else if (escolha == PessoaMenu.juridica) {
      pessoa = PessoaJuridica(
        documento: PessoaJuridica.validarDocumento(
          SistemaIO.pergunta(SistemaIO.cnpjEmpresa),
        ),
        nomeIdentificador: SistemaIO.pergunta(SistemaIO.razaoSocial),
        nomeFantasia: SistemaIO.pergunta(SistemaIO.nomeFantasia),
        telefone: Pessoa.validarTelefone(
          SistemaIO.pergunta(SistemaIO.telefoneSocio),
        ),
        endereco: await SistemaControlador.atribuiEndereco(),
      );
    } else {
      stdout.write(SistemaIO.erroOpcao);
    }

    //DADOS DA EMPRESA
    stdout.writeln("Dados da empresa");
    empresa = Empresa(
      id: Uuid().v1(),
      criadoEm: DateTime.now(),
      razaoSocial: SistemaIO.pergunta(SistemaIO.razaoSocial),
      nomeFantasia: SistemaIO.pergunta(SistemaIO.nomeFantasia),
      cnpj: PessoaJuridica.validarDocumento(
        SistemaIO.pergunta(SistemaIO.cnpjEmpresa),
      ),
      endereco: await SistemaControlador.atribuiEndereco(),
      telefone: Pessoa.validarTelefone(
        SistemaIO.pergunta(SistemaIO.telefoneEmpresa),
      ),
      socio: pessoa,
    );

    try {
      repo.adicionar(empresa);
      SistemaIO.exibe(SistemaIO.confirmaEmpresaCadastrada);
    } catch (e) {
      SistemaIO.erroAoAdicionarEmpresa(e.toString());
    }
  }
}
