import 'package:cadastro_empresa/pessoa_model.dart';

class PessoaFisica extends Pessoa {
  PessoaFisica(
      {required super.nomeIdentificador,
      required super.documento,
      required super.endereco});

  @override
  void validarDocumento(String documento) {
    // TODO: implement validarDocumento
  }
}
