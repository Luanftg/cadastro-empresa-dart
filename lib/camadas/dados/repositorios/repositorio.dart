import '../../dominio/entidades/empresa_entidade.dart';

abstract class Repositorio {
  Future<void> encontrarUm(String id) async {}
  Future<void> encontrarTodos() async {}
  Future<void> deletar(String id) async {}
  void adicionar(Empresa empresa) {}
}
