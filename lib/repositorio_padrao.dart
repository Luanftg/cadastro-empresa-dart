import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/empresa_model.dart';
import 'package:cadastro_empresa/pessoa_fisica_model.dart';
import 'package:cadastro_empresa/pessoa_juridica_model.dart';

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

  // @override
  // void encontrarUm(String documento) {
  //   listaEmpresas.forEach((element) {
  //     var lista =
  //         (listaEmpresas.where((element) => element.cnpj == documento)).first;
  //     print(lista);
  //   });
  // }

  @override
  Future<void> encontrarUm(String documento) async {
    listaEmpresas.forEach((element) {
      if (documento.length == 14) {
        documento = PessoaJuridica.validarDocumento(documento);
        var listaCNPJ =
            (listaEmpresas.where((element) => element.cnpj == documento)).first;
        print('\n $listaCNPJ');
      } else if (documento.length == 11) {
        documento = PessoaFisica.validarDocumento(documento);
        var listaCPF = (listaEmpresas
            .where((element) => element.socio.documento == documento)).first;
        print('\n $listaCPF');
      } else {
        print('Informe um numero de domento válido.');
        return;
      }
    });
  }
}
