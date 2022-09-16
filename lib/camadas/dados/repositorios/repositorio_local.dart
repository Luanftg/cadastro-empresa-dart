// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cadastro_empresa/camadas/dados/dao.dart';

import '../../dominio/entidades/empresa_entidade.dart';

class RepositorioLocal implements DAO {
  final File arquivo;
  int registro = 0;

  RepositorioLocal({
    required this.arquivo,
  });

  @override
  Future<void> adicionar(Empresa content) async {
    var streamDeArquivo = arquivo.openWrite(mode: FileMode.append);
    registro++;
    streamDeArquivo.write('\n ${content} \n');
    streamDeArquivo.close();
  }

  @override
  Future<void> deletar(String id) async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    var streamDeArquivo = arquivo.openWrite(mode: FileMode.append);
    try {
      await for (var linha in linhas) {
        if (linha.contains(id)) {
          for (int i = 0; i <= 8; i++) {
            streamDeArquivo.write('');
            streamDeArquivo.close();
          }
          print('\n [removida] $linha');
        }
      }
      print('File is now closed.');
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
        print(linha);
      }
      //print('Arquivo fechado.');
    } catch (e) {
      print('[Error]: $e');
    }
  }

  @override
  Future<void> encontrarUm(String id) async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var linha in linhas) {
        if (linha.contains(id)) {
          print(linha);
        }
      }
      print('File is now closed.');
    } catch (e) {
      print('Error: $e');
    }
  }
}
