import 'package:cadastro_empresa/camadas/dados/repositorios/repositorio.dart';

import 'package:cadastro_empresa/camadas/dados/repositorios/repositorio_padrao.dart';
import 'package:cadastro_empresa/camadas/sistema/sistema.dart';

void main() {
  //DAO repoLocal = RepositorioLocal(arquivo: File('./database/empresa.txt'));
  Repositorio repoLocal = RepositorioPadrao();
  Sistema(repo: repoLocal).inicializar();
}
