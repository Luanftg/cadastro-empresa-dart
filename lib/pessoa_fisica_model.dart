import 'dart:io';

import 'package:cadastro_empresa/pessoa_model.dart';

class PessoaFisica extends Pessoa {
  String telefone;
  PessoaFisica(
      {required super.nomeIdentificador,
      required super.documento,
      required super.endereco,
      required this.telefone});

  @override
  String toString() {
    return '''
CPF:            $documento
Nome Completo:  $nomeIdentificador
Endereço:       $endereco
Telefone:       $telefone
''';
  }

  static String validarDocumento(String documento) {
    int cpf = int.parse(documento);
    while (documento.length != 11 || cpf.isNaN) {
      print(
          'CPF inválido. Informe uma sequência de 11 digitos sem caracteres especiais');
      documento = stdin.readLineSync()!;
    }
    return '${documento.substring(0, 3)}.${documento.substring(3, 6)}.${documento.substring(6, 9)}-${documento.substring(9)}';
  }
}
