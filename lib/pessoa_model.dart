// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cadastro_empresa/endereco_model.dart';

class Pessoa {
  String nomeIdentificador;
  String documento;
  Endereco endereco;

  Pessoa({
    required this.nomeIdentificador,
    required this.documento,
    required this.endereco,
  });

  void validarDocumento(String documento) {}

  @override
  String toString() =>
      'Pessoa(nomeIdentificador: $nomeIdentificador, documento: $documento, endereco: $endereco)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomeIdentificador': nomeIdentificador,
      'documento': documento,
      'endereco': endereco.toMap(),
    };
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      nomeIdentificador: map['nomeIdentificador'] as String,
      documento: map['documento'] as String,
      endereco: Endereco.fromMap(map['endereco'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pessoa.fromJson(String source) =>
      Pessoa.fromMap(json.decode(source) as Map<String, dynamic>);
}
