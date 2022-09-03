// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cadastro_empresa/endereco_model.dart';

abstract class Pessoa {
  String nomeIdentificador;
  String documento;
  Endereco endereco;

  Pessoa({
    required this.nomeIdentificador,
    required this.documento,
    required this.endereco,
  });

  void validarDocumento(String documento);

  @override
  String toString() =>
      'Pessoa(nomeIdentificador: $nomeIdentificador, documento: $documento, endereco: $endereco)';
}
