// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

import 'package:cadastro_empresa/endereco_model.dart';
import 'package:cadastro_empresa/pessoa_model.dart';

class Empresa {
  String? _id;
  String razaoSocial;
  String nomeFantasia;
  String cnpj;
  Endereco endereco;
  String telefone;
  DateTime? criadoEm;
  Pessoa socio;

  Empresa({
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.cnpj,
    required this.endereco,
    required this.telefone,
    required this.socio,
  }) {
    _id = Uuid().v1();
    criadoEm = DateTime.now();
  }

  @override
  String toString() {
    return '''
ID: $_id
CNPJ: $cnpj     Data Cadastro: $criadoEm 
Razão Social:   $razaoSocial
Nome Fantasia:  $nomeFantasia 
Telefone:       $telefone
Socio: 
$socio
Endereço: $endereco
''';
  }
}
