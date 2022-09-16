import 'dart:convert';
import 'package:cadastro_empresa/camadas/sistema/sistema_controlador_endereco.dart';
import 'package:http/http.dart' as http;

import '../../dominio/entidades/endereco_entidade.dart';

class CepApi {
  static final baseUrlViaCep = 'viacep.com.br';

  Future<Map> fetch(String cep, String formato) async {
    var unencodedPath = 'ws/$cep/$formato';
    var url = Uri.https(baseUrlViaCep, unencodedPath);
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return json;
  }

  static Future<Endereco> fetchViaCep(
      String cep, String formato, String numero, String complemento) async {
    var caminhoCodificado = 'ws/$cep/$formato';
    var url = Uri.https(baseUrlViaCep, caminhoCodificado);
    var resposta = await http.get(url);
    var json = jsonDecode(resposta.body);

    String logradouro = json['logradouro'];
    String bairro = json['bairro'];
    String estado = json['uf'];
    String cidade = json['localidade'];
    cep = SistemaControladorEndereco.formataCepValidado(cep);
    Endereco endereco = Endereco(
      logradouro: logradouro,
      numero: numero,
      bairro: bairro,
      estado: estado,
      cep: cep,
      cidade: cidade,
      complemento: complemento,
    );
    return endereco;
  }
}
