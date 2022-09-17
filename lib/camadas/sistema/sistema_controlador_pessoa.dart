import 'package:cadastro_empresa/camadas/sistema/sistema_controlador_endereco.dart';
import 'package:cadastro_empresa/camadas/sistema/sistema_io.dart';

import '../dominio/entidades/pessoa_entidade.dart';
import '../dominio/entidades/pessoa_fisica_entidade.dart';
import '../dominio/entidades/pessoa_juridica_entidade.dart';

class SistemaControladorPessoa {
  static Future<Pessoa> atibuirPessoa(PessoaMenu pessoaMenu) async {
    switch (pessoaMenu) {
      case PessoaMenu.fisica:
        return PessoaFisica(
          documento: PessoaFisica.validarDocumento(
            SistemaIO.pergunta(SistemaIO.cpfSocio, eNumero: true, tamanho: 11),
          ),
          nomeIdentificador: SistemaIO.pergunta(SistemaIO.nomeSocio),
          endereco: await SistemaControladorEndereco.atribuiEndereco(),
          telefone: Pessoa.validarTelefone(
            SistemaIO.pergunta(SistemaIO.telefoneSocio, eNumero: true),
          ),
        );
      case PessoaMenu.juridica:
        return PessoaJuridica(
          documento: PessoaJuridica.validarDocumento(
            SistemaIO.pergunta(
              SistemaIO.cnpjEmpresa,
              eNumero: true,
              tamanho: 14,
            ),
          ),
          nomeIdentificador: SistemaIO.pergunta(SistemaIO.razaoSocial),
          nomeFantasia: SistemaIO.pergunta(SistemaIO.nomeFantasia),
          telefone: Pessoa.validarTelefone(
            SistemaIO.pergunta(SistemaIO.telefoneSocio, eNumero: true),
          ),
          endereco: await SistemaControladorEndereco.atribuiEndereco(),
        );
    }
  }
}
