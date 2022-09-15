import 'package:cadastro_empresa/sistema_io.dart';

import 'cepApi.dart';
import 'endereco_model.dart';

class SistemaControlador {
  static Future<Endereco> atribuiEndereco() async {
    String? resultadoConfirmaCep;
    Endereco enderecoViaCep;
    String numero = SistemaIO.pergunta(SistemaIO.numeroEnderecoEmpresa);
    String complemento = SistemaIO.pergunta(SistemaIO.complementoEmpresa);
    String cep = SistemaIO.pergunta(SistemaIO.cepEmpresa);
    try {
      enderecoViaCep =
          await CepApi.fetchViaCep(cep, 'json', numero, complemento);
      SistemaControlador.confirmaResultadoEndereco(enderecoViaCep);
      if (resultadoConfirmaCep == '1') {
        enderecoViaCep = Endereco(
          logradouro: SistemaIO.pergunta(SistemaIO.logradouroEmpresa),
          numero: SistemaIO.pergunta(SistemaIO.numeroEnderecoEmpresa),
          cidade: SistemaIO.pergunta(SistemaIO.cidadeEmpressa),
          complemento: SistemaIO.pergunta(SistemaIO.complementoEmpresa),
          bairro: SistemaIO.pergunta(SistemaIO.bairroEmpresa),
          estado: SistemaIO.pergunta(SistemaIO.unidadeFederativaEmpresa),
          cep: cep,
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
}
