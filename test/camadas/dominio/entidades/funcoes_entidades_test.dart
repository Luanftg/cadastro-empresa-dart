import 'package:cadastro_empresa/pessoa_fisica_model.dart';
import 'package:cadastro_empresa/pessoa_juridica_model.dart';
import 'package:cadastro_empresa/pessoa_model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

main() {
  test('Espero numero de telefone celular no formato: 99721 - 3383', () {
    var result = Pessoa.validarTelefone('997213383');
    expect(result, '99721 - 3383');
  });

  test('Espero numero de telefone fixo no formato: 3883 - 1195', () {
    var result = Pessoa.validarTelefone('38831195');
    expect(result, '3883 - 1195');
  });

  test('Espero numero de documento Pessoa Fisica no formato: 352.142.008-62',
      () {
    var result = PessoaFisica.validarDocumento('35214200862');
    expect(result, '352.142.008-62');
  });

  test(
      'Espero numero de documento Pessoa Jurídica no formato: 13.251.867/0001-61',
      () {
    var result = PessoaJuridica.validarDocumento('13251867000161');
    expect(result, '13.251.867/0001-61');
  });
}
