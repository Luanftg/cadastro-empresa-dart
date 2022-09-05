import 'package:cadastro_empresa/empresa_model.dart';

abstract class DAO {
  void encontrarUm(String id) {}
  void encontrarTodos() async {}
  void deletar(String id) async {}
  void adicionar(Empresa empresa) {}
}


//   void buscaEmpresaPeloCNPJ() {}
//   void buscaEmpresaPeloDocumentoDoSocio() {}
//   void listarEmpresas() {}
//   void excluirEmpresa() {}