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
      return '';
    }
  }

  @override
  String toString() =>
      'Pessoa(nomeIdentificador: $nomeIdentificador, documento: $documento, endereco: $endereco)';
}
