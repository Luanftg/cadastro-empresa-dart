import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/empresa_model.dart';

class RepositorioPadrao implements DAO {
  List<Empresa> listaEmpresas = [];
  @override
  void adicionar(Empresa empresa) {
    listaEmpresas.contains(empresa)
        ? print('Empresa já cadastrada na lista')
        : listaEmpresas.add(empresa);
  }

  @override
  void deletar(String id) {
    listaEmpresas.forEach((element) {
      if (element.id == id) {
        listaEmpresas.removeWhere(
          (element) => element.id == id,
        );
      }
    });
  }

  @override
  void encontrarTodos() {
    listaEmpresas.forEach(print);
  }

  @override
  void encontrarUm(String id) {
    for (int index = 0; index < listaEmpresas.length; index++) {
      listaEmpresas[index].id == id
          ? print(listaEmpresas[index])
          : print('Empresa com id $id não encontrada na lista');
    }
  }
}
