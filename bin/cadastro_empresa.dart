import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/repositorio_padrao.dart';
import 'package:cadastro_empresa/sistema.dart';

void main() {
  DAO repoLocal = RepositorioPadrao();
  Sistema(repo: repoLocal).inicializar();
}
