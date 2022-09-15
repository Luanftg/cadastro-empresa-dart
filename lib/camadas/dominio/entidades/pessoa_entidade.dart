// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'endereco_entidade.dart';

class Pessoa {
  String nomeIdentificador;
  String documento;
  Endereco endereco;

  Pessoa({
    required this.nomeIdentificador,
    required this.documento,
    required this.endereco,
  });

  static void validarDocumento(String documento) {}
  static String validarTelefone(String telefone) {
    if (telefone.startsWith('9') && telefone.length == 9) {
      //telefone celular
      return telefone =
          '${telefone.substring(0, 5)} - ${telefone.substring(5)}';
    } else if (telefone.startsWith('9') == false && telefone.length == 8) {
      //telefone residencial
      return telefone =
          '${telefone.substring(0, 4)} - ${telefone.substring(4)}';
    } else {
      return telefone;
    }
  }

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
