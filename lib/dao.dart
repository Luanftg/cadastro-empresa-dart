import 'package:cadastro_empresa/empresa_model.dart';

abstract class DAO {
  void encontrarUm(String id) {}
  Future<void> encontrarTodos() async {}
  Future<void> deletar(String id) async {}
  void adicionar(Empresa empresa) {}
}


//   void buscaEmpresaPeloCNPJ() {}
//   void buscaEmpresaPeloDocumentoDoSocio() {}
//   void listarEmpresas() {}
//   void excluirEmpresa() {}