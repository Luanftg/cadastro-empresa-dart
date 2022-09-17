import 'dart:io';
import 'package:cadastro_empresa/camadas/dados/repositorios/repositorio_local.dart';
import 'package:cadastro_empresa/camadas/dados/repositorios/repositorio_padrao.dart';
import 'package:cadastro_empresa/camadas/sistema/sistema_controlador_empresa.dart';
import 'package:cadastro_empresa/camadas/sistema/sistema_controlador_pessoa.dart';
import 'package:cadastro_empresa/camadas/dados/externos/cepApi.dart';
import 'package:cadastro_empresa/camadas/sistema/sistema_io.dart';
import 'package:cadastro_empresa/camadas/dados/repositorios/repositorio.dart';
import '../dominio/entidades/empresa_entidade.dart';
import '../dominio/entidades/pessoa_entidade.dart';

class Sistema {
  static late Enum? escolhaMenu;
  static late PessoaMenu escolhaPessoa;

  static final Repositorio repo = RepositorioPadrao();
  CepApi viaCepApi = CepApi();
  late Pessoa pessoa;
  late Empresa empresa;

  // static void configuracao() {
  //   String respostaRepositorio = SistemaIO.menu(
  //       SistemaIO.configuraRepositorio, SistemaIO.opcoesRepositorio);
  //   respostaRepositorio == '0'
  //       ? Sistema.repo = RepositorioLocal(
  //           arquivo: File('lib/camadas/dados/fonte_de_dados/empresa.json'))
  //       : Sistema.repo = RepositorioPadrao();
  // }

  Future<void> inicializar() async {
    SistemaIO.exibe(SistemaIO.apresentacao);

    do {
      escolhaMenu = SistemaIO.menuPrincipal();

      switch (escolhaMenu) {
        case MenuPrincipal.encerrar:
          encerrar();
          break;
        case MenuPrincipal.cadastrar:
          escolhaPessoa = SistemaIO.menuPessoa();
          await cadastrar(escolhaPessoa);
          break;
        case MenuPrincipal.listarTodos:
          await repo.encontrarTodos();
          break;
        case MenuPrincipal.deletar:
          await repo.deletar(
            SistemaIO.pergunta(
              SistemaIO.delecaoID,
              tamanho: 36,
            ),
          );
          break;
        case MenuPrincipal.buscarPorCNPJEmpresa:
          await repo.encontrarUm(
            SistemaIO.pergunta(SistemaIO.cnpjEmpresa,
                eNumero: true, tamanho: 14),
          );
          break;
        case MenuPrincipal.buscarPorCNPJCPFSocio:
          repo.encontrarUm(
            SistemaIO.pergunta(SistemaIO.buscaEmpresaporSocio, eNumero: true),
          );
          break;
        default:
          stdout.write(SistemaIO.erroOpcao);
      }
    } while (escolhaMenu != null);
  }

  void encerrar() {
    stdout.write(SistemaIO.encerrar);
    escolhaMenu = null;
  }

  Future<void> cadastrar(Enum escolha) async {
    SistemaIO.exibe(SistemaIO.cadastroSocio);
    SistemaIO.exibe(SistemaIO.endereco);

    pessoa = await SistemaControladorPessoa.atibuirPessoa(escolhaPessoa);
    empresa = await SistemaControladorEmpresa.atribuiEmpresa(pessoa);

    try {
      repo.adicionar(empresa);
      SistemaIO.exibe(SistemaIO.confirmaEmpresaCadastrada);
    } catch (e) {
      SistemaIO.erroAoAdicionarEmpresa(e.toString());
    }
  }
}
