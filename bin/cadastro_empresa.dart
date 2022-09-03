import 'package:cadastro_empresa/empresa_model.dart';
import 'package:cadastro_empresa/endereco_model.dart';
import 'package:cadastro_empresa/pessoaFisica.dart';
import 'package:cadastro_empresa/pessoaJuridica.dart';
import 'package:uuid/uuid.dart';

void main() {
  print('\n');
  var enderecoLuan = Endereco(
    logradouro: 'Avendia Rui Barbosa',
    numero: 2053,
    complemento: 'casa04',
    bairo: 'Santana',
    estado: 'São Paulo',
    cep: '12211-105',
  );

  var luan = PessoaFisica(
    nomeIdentificador: 'Luan Fonseca',
    documento: '35214200862',
    endereco: enderecoLuan,
  );

  var luanJuridico = PessoaJuridica(
    nomeIdentificador: 'Luan Fonseca 35214200862',
    nomeFantasia: 'MEI do Luan Fonseca',
    documento: '40245842000128',
    endereco: enderecoLuan,
  );

  var empresaLuan = Empresa(
    razaoSocial: 'Luan Fonseca Produções',
    nomeFantasia: 'Luan Fonseca352',
    cnpj: '40242842000128',
    endereco: enderecoLuan,
    telefone: '12997213383',
    socio: luan,
  );

  var empresaLuan2 = Empresa(
    razaoSocial: 'Luan Gimenez Dança',
    nomeFantasia: 'Dança em Video',
    cnpj: '53478145000178',
    endereco: enderecoLuan,
    telefone: '12997213383',
    socio: luanJuridico,
  );

  print(empresaLuan);
  print('\n');
  print(empresaLuan2);
}
