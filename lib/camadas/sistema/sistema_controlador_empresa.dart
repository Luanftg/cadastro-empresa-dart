import 'package:cadastro_empresa/camadas/sistema/sistema_controlador_endereco.dart';
import 'package:cadastro_empresa/camadas/sistema/sistema_io.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/empresa_entidade.dart';
import 'package:uuid/uuid.dart';

import '../dominio/entidades/pessoa_entidade.dart';
import '../dominio/entidades/pessoa_juridica_entidade.dart';

class SistemaControladorEmpresa {
  static Future<Empresa> atribuiEmpresa(Pessoa pessoa) async {
    return Empresa(
      id: Uuid().v1(),
      criadoEm: DateTime.now(),
      razaoSocial: SistemaIO.pergunta(SistemaIO.razaoSocial),
      nomeFantasia: SistemaIO.pergunta(SistemaIO.nomeFantasia),
      cnpj: PessoaJuridica.validarDocumento(
        SistemaIO.pergunta(SistemaIO.cnpjEmpresa),
      ),
      endereco: await SistemaControladorEndereco.atribuiEndereco(),
      telefone: Pessoa.validarTelefone(
        SistemaIO.pergunta(SistemaIO.telefoneEmpresa, eNumero: true),
      ),
      socio: pessoa,
    );
  }
}
