import 'package:cadastro_empresa/empresa_model.dart';

abstract class DAO {
  Future<void> encontrarUm(String id) async {}
  Future<void> encontrarTodos() async {}
  Future<void> deletar(String id) async {}
  void adicionar(Empresa empresa) {}
}
