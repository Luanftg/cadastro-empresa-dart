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
  Future<void> deletar(String id) async {
    listaEmpresas.removeWhere((element) => element.id == id);
    print('Empresa de id: $id removida da lista de cadastro!');
  }

  @override
  Future<void> encontrarTodos() async {
    if (listaEmpresas.isEmpty) {
      print('A lista está vazia');
    } else {
      listaEmpresas.sort(((a, b) => a.razaoSocial.compareTo(b.razaoSocial)));
      listaEmpresas.forEach(print);
    }
  }

  @override
  void encontrarUm(String documento) {
    for (int index = 0; index < listaEmpresas.length; index++) {
      listaEmpresas.any((element) => element.socio.documento == documento)
          ? print(listaEmpresas[index])
          : print('Empresa com documento: $documento não encontrada na lista');
    }
  }
}


// void encontraEmpresaPorCNPJ() {
//     for (int index = 0; index < listaEmpresas.length; index++) {
//     listaEmpresas.any((element) => element.socio.documento == documento)
//         ? print(listaEmpresas[index])
//         : print('Empresa com documento: $documento não encontrada na lista');
//   } 
// }
   
//   //   String documento, List<Empresa> listaEmpresas) {
//   // for (int index = 0; index < listaEmpresas.length; index++) {
//   //   listaEmpresas.any((element) => element.cnpj == documento)
//   //       ? print(listaEmpresas[index])
//   //       : print('Empresa com documento: $documento não encontrada na lista');
//   // }

// }
// void encontraEmpresaDocumento(
//     String documento, List<Empresa> listaEmpresas) {
//   for (int index = 0; index < listaEmpresas.length; index++) {
//     listaEmpresas.any((element) => element.socio.documento == documento)
//         ? print(listaEmpresas[index])
//         : print('Empresa com documento: $documento não encontrada na lista');
//   }
// }