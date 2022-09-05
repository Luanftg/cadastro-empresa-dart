import 'dart:io';

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
    while (documento.length != 11 && int.parse(documento).isNaN) {
      print(
          'CPF inválido. Informe uma sequência de 11 digitos sem caracteres especiais');
      documento = stdin.readLineSync()!;
    }

    // if (documento.length != 11) {
    //
    // }
  }
}
