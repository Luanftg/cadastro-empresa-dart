// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'endereco_entidade.dart';
import 'pessoa_entidade.dart';

class Empresa {
  String? id;
  String razaoSocial;
  String nomeFantasia;
  String cnpj;
  Endereco endereco;
  String telefone;
  DateTime? criadoEm;
  Pessoa socio;

  Empresa({
    required this.id,
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.cnpj,
    required this.endereco,
    required this.telefone,
    required this.criadoEm,
    required this.socio,
  });

  @override
  String toString() {
    return '''
ID: $id
CNPJ: $cnpj     Data Cadastro: $criadoEm 
Razão Social:   $razaoSocial
Nome Fantasia:  $nomeFantasia
Endereço: $endereco
Telefone:       $telefone
SÓCIO
$socio
    ''';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'cnpj': cnpj,
      'endereco': endereco.toMap(),
      'telefone': telefone,
      'criadoEm': criadoEm?.millisecondsSinceEpoch,
      'socio': socio.toMap(),
    };
  }

  factory Empresa.fromMap(Map<String, dynamic> map) {
    return Empresa(
      id: map['id'] != null ? map['id'] as String : null,
      razaoSocial: map['razaoSocial'] as String,
      nomeFantasia: map['nomeFantasia'] as String,
      cnpj: map['cnpj'] as String,
      endereco: Endereco.fromMap(map['endereco'] as Map<String, dynamic>),
      telefone: map['telefone'] as String,
      criadoEm: map['criadoEm'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['criadoEm'] as int)
          : null,
      socio: Pessoa.fromMap(map['socio'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Empresa.fromJson(String source) =>
      Empresa.fromMap(json.decode(source) as Map<String, dynamic>);
}
