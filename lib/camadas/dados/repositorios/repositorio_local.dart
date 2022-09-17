// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cadastro_empresa/camadas/dados/repositorios/repositorio.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/pessoa_fisica_entidade.dart';
import 'package:cadastro_empresa/camadas/dominio/entidades/pessoa_juridica_entidade.dart';

import '../../dominio/entidades/empresa_entidade.dart';

class RepositorioLocal implements Repositorio {
  final File arquivo;
  int registro = 0;

  RepositorioLocal({
    required this.arquivo,
  });

  @override
  Future<void> adicionar(Empresa content) async {
    var fluxoDeArquivo = arquivo.openWrite(mode: FileMode.append);
    registro++;
    fluxoDeArquivo.write('${content.toJson()}\n');
    fluxoDeArquivo.close();
  }

  @override
  Future<void> deletar(String id) async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    var fluxoDeArquivo = arquivo.openWrite(mode: FileMode.append);
    try {
      await for (var linha in linhas) {
        if (linha.contains(id)) {
          for (int i = 0; i <= 8; i++) {
            fluxoDeArquivo.write('');
            fluxoDeArquivo.close();
          }
          print('\n [removida] $linha');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    registro--;
  }

  @override
  Future<void> encontrarTodos() async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var linha in linhas) {
        linha = Empresa.fromMap(jsonDecode(linha)).toString();
        print(linha);
      }
    } catch (e) {
      print('[Error]: $e');
    }
  }

  @override
  Future<void> encontrarUm(String documento) async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    try {
      (documento.length == 11)
          ? documento = PessoaFisica.validarDocumento(documento)
          : documento = PessoaJuridica.validarDocumento(documento);

      await for (var linha in linhas) {
        if (linha.contains(documento)) {
          print(linha);
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
