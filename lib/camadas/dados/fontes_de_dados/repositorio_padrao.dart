import 'package:cadastro_empresa/camadas/dados/dao.dart';

import '../../dominio/entidades/empresa_entidade.dart';
import '../../dominio/entidades/pessoa_fisica_entidade.dart';
import '../../dominio/entidades/pessoa_juridica_entidade.dart';

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
  Future<void> encontrarUm(String documento) async {
    listaEmpresas.forEach((element) {
      if (documento.length == 14) {
        documento = PessoaJuridica.validarDocumento(documento);
        var listaCNPJ =
            (listaEmpresas.where((element) => element.cnpj == documento));
        print('\n $listaCNPJ');
      } else if (documento.length == 11) {
        documento = PessoaFisica.validarDocumento(documento);
        var listaCPF = (listaEmpresas
            .where((element) => element.socio.documento == documento));
        print('\n $listaCPF');
      } else {
        print('Informe um número de documento válido.');
        return;
      }
    });
  }
}
