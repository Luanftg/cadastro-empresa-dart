import 'dart:io';

void main() {
  // test(
  //     'Espero receber uma String como reposta a função pergunta passando um tamanho de 11 caracteres',
  //     () {
  //   var resultadoEsperado = '35214200862';
  //var resposta = pergunta("mensagem", eNumero: true, tamanho: 11);
  print('8984a890-2ca2-11ed-93cd-b13e3bab036b'.length);
  //   expect(resposta, resultadoEsperado);
  // });
}

String pergunta(String mensagem, {bool? eNumero, int? tamanho}) {
  String parametro;
  do {
    stdout.writeln(mensagem);
    parametro = stdin.readLineSync()!;
    if (eNumero != null) {
      int.tryParse(parametro) != null ? parametro : parametro = '';
    }

    if (tamanho != null) {
      parametro.length == tamanho ? parametro : parametro = '';
    }
  } while (parametro.isEmpty);
  return parametro;
}
