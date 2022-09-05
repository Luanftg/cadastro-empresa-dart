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
  void adicionar(Empresa content) async {
    var sink = arquivo.openWrite(mode: FileMode.append);
    registro++;
    //sink.write('PESSOA FISICA N° $registro: $content \n');
    sink.write('${content.toString()} \n');
    sink.close();
  }

  @override
  void deletar(String id) async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var linha in linhas) {
        if (linha.contains(id)) {
          linha.replaceRange(0, null, ' ');
          print('${linha.length} removida!');
        }
      }
      print('File is now closed.');
    } catch (e) {
      print('Error: $e');
    }
    registro--;
  }

  @override
  void encontrarTodos() async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var linha in linhas) {
        print('$linha: ${linha.length} characters');
      }
      print('File is now closed.');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void encontrarUm(String id) async {
    Stream<String> linhas =
        arquivo.openRead().transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var linha in linhas) {
        if (linha.contains(id)) {
          print('$linha: ${linha.length} characters');
        }
      }
      print('File is now closed.');
    } catch (e) {
      print('Error: $e');
    }
  }
}
