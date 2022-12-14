import 'package:cadastro_empresa/camadas/sistema/sistema_io.dart';

import '../dados/externos/cepApi.dart';
import '../dominio/entidades/endereco_entidade.dart';

class SistemaControladorEndereco {
  static Future<Endereco> atribuiEndereco() async {
    String? resultadoConfirmaCep;
    Endereco enderecoViaCep;
    String numero =
        SistemaIO.pergunta(SistemaIO.numeroEnderecoEmpresa, eNumero: true);
    String complemento = SistemaIO.pergunta(SistemaIO.complementoEmpresa);
    String cep =
        SistemaIO.pergunta(SistemaIO.cepEmpresa, eNumero: true, tamanho: 8);
    try {
      enderecoViaCep =
          await CepApi.fetchViaCep(cep, 'json', numero, complemento);
      resultadoConfirmaCep = confirmaResultadoEndereco(enderecoViaCep);
      if (resultadoConfirmaCep == '1') {
        enderecoViaCep = Endereco(
          logradouro: SistemaIO.pergunta(SistemaIO.logradouroEmpresa),
          numero: SistemaIO.pergunta(SistemaIO.numeroEnderecoEmpresa,
              eNumero: true),
          cidade: SistemaIO.pergunta(SistemaIO.cidadeEmpressa),
          complemento: SistemaIO.pergunta(SistemaIO.complementoEmpresa),
          bairro: SistemaIO.pergunta(SistemaIO.bairroEmpresa),
          estado: SistemaIO.pergunta(SistemaIO.unidadeFederativaEmpresa),
          cep: formataCepValidado(cep),
        );
      }
      return enderecoViaCep;
    } catch (e) {
      SistemaIO.erroApiCep(e.toString());
      return atribuiEndereco();
    }
  }

  static String? confirmaResultadoEndereco(Endereco endereco) {
    SistemaIO.exibeResultadoCep(endereco.toMap());
    return SistemaIO.menu(
      'Informe:',
      ['Para confirmar', 'Informar os campos manualmente'],
    );
  }

  static String formataCepValidado(String cep) {
    return '${cep.toString().substring(0, 5)} - ${cep.substring(5)}';
  }
}
