import 'dart:io';

import 'package:cadastro_empresa/repositorio_local.dart';
import 'package:cadastro_empresa/empresa_model.dart';
import 'package:cadastro_empresa/endereco_model.dart';
import 'package:cadastro_empresa/pessoa_fisica_model.dart';
import 'package:cadastro_empresa/pessoa_juridica_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  print('\n');
  var enderecoLuan = Endereco(
      logradouro: 'Avendia Rui Barbosa',
      numero: '2053',
      complemento: 'casa04',
      bairro: 'Santana',
      estado: 'São Paulo',
      cep: '12211-105',
      cidade: 'São José dos Campos');

  var luan = PessoaFisica(
      nomeIdentificador: 'Luan Fonseca',
      documento: '35214200862',
      endereco: enderecoLuan,
      telefone: '997213383');

  var luanJuridico = PessoaJuridica(
      nomeIdentificador: 'Luan Fonseca 35214200862',
      nomeFantasia: 'MEI do Luan Fonseca',
      documento: '40245842000128',
      endereco: enderecoLuan,
      telefone: '12997213383');

  var empresaLuan = Empresa(
    id: Uuid().v1(),
    criadoEm: DateTime.now(),
    razaoSocial: 'Luan Fonseca Produções',
    nomeFantasia: 'Luan Fonseca352',
    cnpj: '40242842000128',
    endereco: enderecoLuan,
    telefone: '12997213383',
    socio: luan,
  );

  var empresaLuan2 = Empresa(
    id: Uuid().v1(),
    criadoEm: DateTime.now(),
    razaoSocial: 'Luan Gimenez Dança',
    nomeFantasia: 'Dança em Video',
    cnpj: '53478145000178',
    endereco: enderecoLuan,
    telefone: '12997213383',
    socio: luanJuridico,
  );

  // print(empresaLuan);
  // print('\n');
  // print(empresaLuan2);

  //var dbPessoaFisica = File('./database/pessoa_fisica.json');
  //var dbPessoaJuridica = File('./database/pessoa_juridica.json');
  var dbEmpresa = File('./database/empresa.json');

  //var daoPessoaFisica = RepositorioLocal(arquivo: dbPessoaFisica);
  //var daoPessoaJuridica = RepositorioLocal(arquivo: dbPessoaJuridica);
  var daoEmpresa = RepositorioLocal(arquivo: dbEmpresa);

  //daoPessoaFisica.encontrarTodos();
  //daoPessoaJuridica.encontrarTodos();
  daoEmpresa.encontrarTodos();
  daoEmpresa.adicionar(empresaLuan2);
  //daoPessoaFisica.adicionar(luan);
  //daoPessoaJuridica.adicionar(luanJuridico);
  //daoPessoaFisica.encontrarTodos();
  //daoPessoaJuridica.encontrarTodos();
  daoEmpresa.encontrarTodos();
}
