import 'dart:io';

class Endereco {
  String logradouro;
  String numero;
  String? complemento;
  String bairo;
  String estado;
  String cep;
  String cidade;

  Endereco({
    required this.logradouro,
    required this.numero,
    this.complemento,
    required this.bairo,
    required this.estado,
    required this.cep,
    required this.cidade,
  });

  @override
  String toString() {
    return '''$logradouro, $numero, $bairo, $estado, $cep''';
  }
}
