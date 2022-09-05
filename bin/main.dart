import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/repositorio_padrao.dart';
import 'package:cadastro_empresa/sistema.dart';

void main() {
  // var dbEmpresa = File('../database/empresa.json');
  // DAO repoLocalJson = RepositorioLocal(arquivo: dbEmpresa);
  DAO repoLocal = RepositorioPadrao();
  //Sistema(repo: repoLocalJson).inicializar();
  Sistema(repo: repoLocal).inicializar();
}
