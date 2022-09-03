import 'package:cadastro_empresa/pessoa_model.dart';

class PessoaFisica extends Pessoa {
  PessoaFisica(
      {required super.nomeIdentificador,
      required super.documento,
      required super.endereco});

  @override
  String toString() {
    return '''
CPF:            $documento
Nome Completo:  $nomeIdentificador''';
  }

  @override
  void validarDocumento(String documento) {
    if (documento.length != 11) {}
  }
}
