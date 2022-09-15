import '../dominio/entidades/empresa_entidade.dart';

abstract class DAO {
  Future<void> encontrarUm(String id) async {}
  Future<void> encontrarTodos() async {}
  Future<void> deletar(String id) async {}
  void adicionar(Empresa empresa) {}
}
