import 'package:cadastro_empresa/camadas/dados/dao.dart';

import 'package:cadastro_empresa/camadas/dados/fontes_de_dados/repositorio_padrao.dart';
import 'package:cadastro_empresa/sistema.dart';

void main() {
  //DAO repoLocal = RepositorioLocal(arquivo: File('./database/empresa.txt'));
  DAO repoLocal = RepositorioPadrao();
  Sistema(repo: repoLocal).inicializar();
}
