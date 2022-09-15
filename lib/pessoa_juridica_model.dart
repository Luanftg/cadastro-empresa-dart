// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cadastro_empresa/pessoa_model.dart';

class PessoaJuridica extends Pessoa {
  String? nomeFantasia;
  String telefone;

  PessoaJuridica(
      {required super.nomeIdentificador,
      this.nomeFantasia,
      required super.documento,
      required super.endereco,
      required this.telefone});

  static String validarDocumento(String documento) {
    int? cnpj = int.tryParse(documento);
    while (documento.length != 14 || cnpj == null) {
      print(
          'CNPJ inválido. Informe uma sequência de 14 digitos sem caracteres especiais');
      documento = stdin.readLineSync()!;
    }
    return '${documento.substring(0, 2)}.${documento.substring(2, 5)}.${documento.substring(5, 8)}/0001-${documento.substring(12)}';
  }

  @override
  String toString() => '''
CNPJ:           $documento
Razão Social:   $nomeIdentificador
Nome Fantasia:  $nomeFantasia
Endereço:       $endereco
Telefone:       $telefone
''';
}
