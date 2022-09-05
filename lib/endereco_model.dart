import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Endereco {
  String logradouro;
  int numero;
  String? complemento;
  String bairo;
  String estado;
  String cep;

  Endereco({
    required this.logradouro,
    required this.numero,
    this.complemento,
    required this.bairo,
    required this.estado,
    required this.cep,
  });

  @override
  String toString() {
    return '''$logradouro, $numero, $bairo, $estado, $cep''';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairo': bairo,
      'estado': estado,
      'cep': cep,
    };
  }

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as int,
      complemento:
          map['complemento'] != null ? map['complemento'] as String : null,
      bairo: map['bairo'] as String,
      estado: map['estado'] as String,
      cep: map['cep'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Endereco.fromJson(String source) =>
      Endereco.fromMap(json.decode(source) as Map<String, dynamic>);
}
