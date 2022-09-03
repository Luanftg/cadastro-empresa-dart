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
}
