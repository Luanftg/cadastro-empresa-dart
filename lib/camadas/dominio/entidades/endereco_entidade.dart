// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Endereco {
  String logradouro;
  String numero;
  String? complemento;
  String bairro;
  String estado;
  String cep;
  String cidade;

  Endereco({
    required this.logradouro,
    required this.numero,
    this.complemento,
    required this.bairro,
    required this.estado,
    required this.cep,
    required this.cidade,
  });

  @override
  String toString() {
    return '''$logradouro, $numero, $bairro, $estado, $cep''';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'estado': estado,
      'cep': cep,
      'cidade': cidade,
    };
  }

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as String,
      complemento:
          map['complemento'] != null ? map['complemento'] as String : null,
      bairro: map['bairro'] as String,
      estado: map['estado'] as String,
      cep: map['cep'] as String,
      cidade: map['cidade'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Endereco.fromJson(String source) =>
      Endereco.fromMap(json.decode(source) as Map<String, dynamic>);
}
