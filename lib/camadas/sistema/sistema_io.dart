import 'dart:io';

enum MenuPrincipal {
  encerrar,
  cadastrar,
  deletar,
  listarTodos,
  buscarPorCNPJEmpresa,
  buscarPorCNPJCPFSocio,
}

enum PessoaMenu {
  fisica,
  juridica,
}

class SistemaIO {
  static late String escolha;

  static List<String> listaDeOpcoesMenuPrincipal = [
    'Encerramento',
    'Cadastro',
    'Visualização',
    'Deleção',
    'Busca por CNPJ da empresa',
    'Busca por CPF ou CNPJ do Sócio',
  ];

  static List<String> listaDeOpcoesMenuCadastroPessoa = [
    'Pessoa Fisica',
    'Pessoa Juridica',
  ];

  static String pergunta(String mensagem, {bool? eNumero, int? tamanho}) {
    String parametro;
    do {
      stdout.writeln(mensagem);
      parametro = stdin.readLineSync()!;
      if (eNumero == true) {
        int.tryParse(parametro) != null ? parametro : parametro = '';
      }

      if (tamanho != null) {
        parametro.length == tamanho ? parametro : parametro = '';
      }
    } while (parametro.isEmpty);
    return parametro;
  }

  static String menu(
    String pergunta,
    List<String> opcoes,
  ) {
    int? escolhaInt;
    int limite;
    do {
      stdout.writeln(pergunta);
      for (var i = 0; i < opcoes.length; i++) {
        stdout.writeln('[$i] -> ${opcoes[i]} ');
      }
      limite = opcoes.length - 1;
      escolha = stdin.readLineSync()!;
      escolhaInt = int.tryParse(escolha);
      if (escolhaInt != null) {}
    } while (escolha.isEmpty || escolha.length > 1 || escolhaInt! > limite);
    return escolha;
  }

  static MenuPrincipal converteRespostaMenu(String respostaMenu) {
    if (respostaMenu == '0') {
      return MenuPrincipal.encerrar;
    } else if (respostaMenu == '1') {
      return MenuPrincipal.cadastrar;
    } else if (respostaMenu == '2') {
      return MenuPrincipal.listarTodos;
    } else if (respostaMenu == '3') {
      return MenuPrincipal.deletar;
    } else if (respostaMenu == '4') {
      return MenuPrincipal.buscarPorCNPJEmpresa;
    } else {
      return MenuPrincipal.buscarPorCNPJCPFSocio;
    }
  }

  static PessoaMenu converteRespostaMenuCadastroDePessoa(String? respostaMenu) {
    if (respostaMenu == '0') {
      return PessoaMenu.fisica;
    } else {
      return PessoaMenu.juridica;
    }
  }

  static MenuPrincipal menuPrincipal() {
    return converteRespostaMenu(
      menu(tituloMenuPrincipal, listaDeOpcoesMenuPrincipal),
    );
  }

  static PessoaMenu menuPessoa() {
    return converteRespostaMenuCadastroDePessoa(
      menu(tituloMenuPrincipal, listaDeOpcoesMenuCadastroPessoa),
    );
  }

  static exibe(String mensagem) {
    stdout.writeln(mensagem);
  }

  static String apresentacao = 'Inicializado Sistema para Cadastro de Empresas';

  static String tituloMenuGeralCadastro = '''

[Menu Cadastro] : Informe uma opção para a natureza do sócio da empresa
''';

  static String tituloMenuPrincipal = '''

[Menu Principal] : Informe a opção desejada
''';

  static erroAoAdicionarEmpresa(String e) {
    stdout.writeln('[Erro] -> $e - ao tentar salvar Empresa');
  }

  static String configuraRepositorio = '''
Você deseja persistir os dados localmente ?
[Sim] -> O cadastro de uma empresa será armezenado em um arquivo local em 'camadas/dados/fonte_de_dados/'
[Não] -> Os dados serão perdidos ao encerrar o programa.
''';

  static List<String> opcoesRepositorio = ['Sim', 'Não'];
  static String confirmaEmpresaCadastrada = 'Empresa cadastrada com sucesso!';

  static String delecaoID = 'Informe o ID da empresa para EXCLUIR do Sistema.';
  static String cnpjEmpresa = "Informe o CNPJ da Empresa:";
  static String erroOpcao =
      '\n[ERRO!] -> Você deve informar uma das opções válidas.\n';
  static String buscaEmpresaporSocio =
      "Informe o CPF ou CNPJ do Sócio para buscar uma Empresa";

  static String razaoSocial = 'Informe a Razão Social ';
  static String nomeFantasia = 'Informe o Nome Fantasia da Empresa';
  static String telefoneEmpresa = 'Informe o Telefone da Empresa';
  static String cepEmpresa = "Informe o CEP";
  static String logradouroEmpresa = 'Informe o Logradouro';
  static String bairroEmpresa = 'Informe o Bairro';
  static String unidadeFederativaEmpresa = 'Informe a Unidade Federativa';
  static String cidadeEmpressa = 'Informe a Cidade';
  static String numeroEnderecoEmpresa = 'Informe o Número do Endereço';
  static String complementoEmpresa = 'Informe um complemento para o Endereço';
  static String nomeSocio = 'Informe o Nome do Sócio da Empresa';
  static String cpfSocio = 'Informe o CPF do Sócio da Empresa';
  static String telefoneSocio = 'Informe o Telefone do Sócio da Empresa';

  static String confirmacaoCep = 'Informe:';
  static String cadastroSocio = '\nCadastro do Sócio da Empresa\n';
  static String endereco = 'Informações sobre o Endereço do Sócio da empresa\n';

  static String encerrar = 'Sistema Finalizado!';
  static String erroApiCep(String e) =>
      'Erro [$e] na chamada da Api.\nInforme os Campos manualmente';

  static void exibeResultadoCep(Map<String, dynamic> json) {
    stdout.writeln('''

Confirme as informações para o Endereço informado
CEP:          ${json['cep']}
Logradouro:   ${json['logradouro']}
Bairro:       ${json['bairro']}
Cidade:       ${json['cidade']}
Estado:       ${json['estado']}
Número:       ${json['numero']}
Complemento:  ${json['complemento']}
''');
  }
}
