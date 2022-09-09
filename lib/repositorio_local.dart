// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cadastro_empresa/dao.dart';
import 'package:cadastro_empresa/empresa_model.dart';

class RepositorioLocal implements DAO {
  final File arquivo;
  int registro = 0;

  RepositorioLocal({
    required this.arquivo,
  });

  @override
  Future<void> adicionar(Empresa content) async {
    var sink = arquivo.openWrite(mode: FileMode.append);
    registro++;
    sink.write('${content.toString()} \n');
    sink.close();
  }

  @override
  Future<void> deletar(String id) async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    var sink = arquivo.openWrite(mode: FileMode.append);
    try {
      await for (var linha in linhas) {
        if (linha.contains(id)) {
          for (int i = 0; i <= 8; i++) {
            sink.write('');
            sink.close();
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
      print('Arquivo fechado.');
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
