// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cadastro_empresa/camadas/dominio/entidades/endereco_entidade.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/pessoa_entidade.dart';

class PessoaFisica extends Pessoa {
  //String telefone;
  PessoaFisica(
      {required super.nomeIdentificador,
      required super.documento,
      required super.endereco,
      required super.telefone});

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
    int? cpf = int.tryParse(documento);
    while (documento.length != 11 || cpf == null) {
      print(
          'CPF inválido. Informe uma sequência de 11 digitos sem caracteres especiais');
      documento = stdin.readLineSync()!;
    }
    return '${documento.substring(0, 3)}.${documento.substring(3, 6)}.${documento.substring(6, 9)}-${documento.substring(9)}';
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'telefone': telefone,
      'documento': documento,
      'nomeIdentificador': nomeIdentificador,
      'endereco': endereco,
    };
  }

  factory PessoaFisica.fromMap(Map<String, dynamic> map) {
    return PessoaFisica(
      telefone: map['telefone'] as String,
      documento: map['documento'] as String,
      endereco: map['endereco'] as Endereco,
      nomeIdentificador: map['nomeIdentificador'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PessoaFisica.fromJson(String source) =>
      PessoaFisica.fromMap(json.decode(source) as Map<String, dynamic>);
}
