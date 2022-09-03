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
}
