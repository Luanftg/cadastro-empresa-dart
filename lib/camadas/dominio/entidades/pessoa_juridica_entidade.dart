// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cadastro_empresa/camadas/dominio/entidades/endereco_entidade.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/pessoa_entidade.dart';

class PessoaJuridica extends Pessoa {
  String? nomeFantasia;
  //String telefone;

  PessoaJuridica(
      {required super.nomeIdentificador,
      this.nomeFantasia,
      required super.documento,
      required super.endereco,
      required super.telefone});

  static String validarDocumento(String documento) {
    int? cnpj = int.tryParse(documento);

    if (documento.length != 14 || cnpj == null) {
      print(
          'CNPJ inválido. Informe uma sequência de 14 digitos sem caracteres especiais');
      do {
        documento = stdin.readLineSync()!;
      } while (documento.isEmpty);
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

  factory PessoaJuridica.fromMap(Map<String, dynamic> map) {
    return PessoaJuridica(
      nomeFantasia:
          map['nomeFantasia'] != null ? map['nomeFantasia'] as String : null,
      documento: map['documento'] as String,
      endereco: map['endereco'] as Endereco,
      nomeIdentificador: map['nomeIdentificador'] as String,
      telefone: map['telefone'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PessoaJuridica.fromJson(String source) =>
      PessoaJuridica.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomeFantasia': nomeFantasia,
    };
  }
}
