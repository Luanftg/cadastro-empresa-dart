// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cadastro_empresa/pessoa_model.dart';

class PessoaJuridica extends Pessoa {
  String? nomeFantasia;

  PessoaJuridica(
      {required super.nomeIdentificador,
      this.nomeFantasia,
      required super.documento,
      required super.endereco});

  @override
  void validarDocumento(String documento) {
    // TODO: implement validarDocumento
  }

  @override
  String toString() => '''
CNPJ:           $documento
Razão Social:   $nomeIdentificador
Nome Fantasia:  $nomeFantasia''';
}
