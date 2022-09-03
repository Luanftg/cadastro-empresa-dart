import 'package:cadastro_empresa/pessoa_model.dart';

class PessoaJuridica extends Pessoa {
  String? nomeFantasia;

  PessoaJuridica(
      {required super.nomeIdentificador,
      String? nomefantasia,
      required super.documento,
      required super.endereco});

  @override
  void validarDocumento(String documento) {
    // TODO: implement validarDocumento
  }
}
