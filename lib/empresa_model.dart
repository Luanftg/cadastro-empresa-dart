import 'package:cadastro_empresa/pessoa_model.dart';
import 'package:cadastro_empresa/endereco_model.dart';

class Empresa {
  String id;
  String razaoSocial;
  String nomeFantasia;
  String cnpj;
  Endereco endereco;
  String telefone;
  DateTime criadoEm;
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
}
