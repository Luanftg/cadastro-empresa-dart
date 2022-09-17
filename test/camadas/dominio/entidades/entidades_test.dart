import 'package:cadastro_empresa/camadas/dominio/entidades/endereco_entidade.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/pessoa_entidade.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/pessoa_fisica_entidade.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/pessoa_juridica_entidade.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

main() {
  test('Espero que a entidade Pessoa não seja nula', () {
    Endereco enderecoLuan = Endereco(
      logradouro: 'Rua Olímpio Santa Rosa',
      numero: '2053',
      bairro: 'Santa Cecília',
      estado: 'MG',
      cep: '36201560',
      cidade: 'Barbacena',
    );
    Pessoa luan = Pessoa(
        nomeIdentificador: 'Luan Fonseca',
        documento: '84499357098',
        endereco: enderecoLuan,
        telefone: '997213383');
    expect(luan, isNotNull);
  });
  test('Espero que a entidade Endereço não seja nula', () {
    Endereco enderecoLuan = Endereco(
      logradouro: 'Rua Olímpio Santa Rosa',
      numero: '2053',
      bairro: 'Santa Cecília',
      estado: 'MG',
      cep: '36201560',
      cidade: 'Barbacena',
    );
    Pessoa luan = Pessoa(
      nomeIdentificador: 'Luan Fonseca',
      documento: '84499357098',
      endereco: enderecoLuan,
      telefone: '997213383',
    );
    expect(enderecoLuan, isNotNull);
  });

  test('Espero que a entidade Pessoa Física não seja nula', () {
    Endereco enderecoLuan = Endereco(
      logradouro: 'Rua Olímpio Santa Rosa',
      numero: '2053',
      bairro: 'Santa Cecília',
      estado: 'MG',
      cep: '36201560',
      cidade: 'Barbacena',
    );
    PessoaFisica luan = PessoaFisica(
        nomeIdentificador: 'Luan Fonseca',
        documento: '84499357098',
        endereco: enderecoLuan,
        telefone: '997213383');
    expect(luan, isNotNull);
  });
  test('Espero que a entidade Pesoa Jurídica não seja nula', () {
    Endereco enderecoLuan = Endereco(
      logradouro: 'Rua Olímpio Santa Rosa',
      numero: '2053',
      bairro: 'Santa Cecília',
      estado: 'MG',
      cep: '36201560',
      cidade: 'Barbacena',
    );
    PessoaJuridica luan = PessoaJuridica(
        nomeIdentificador: 'Luan Fonseca',
        documento: '13251867000161',
        endereco: enderecoLuan,
        telefone: '997213383',
        nomeFantasia: 'Luanftgimenez');
    expect(luan, isNotNull);
  });
}
