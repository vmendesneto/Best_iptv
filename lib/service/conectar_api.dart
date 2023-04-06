
import 'package:dio/dio.dart';

import 'model/lista_model.dart';

final dio = Dio();

class Conectar {
  List<String> listaBruta = [];
  List<Data>? lista;
  List<Data>? canais;
  List<Data>? filmes;
  List<Data>? series;
  List<Data>? radios;
  List<Data>? outros;
  List<Data>? cameras;
  List<Data>? documentarios;
  List<Data>? shows;

  Future get() async {
    var tvglogo = RegExp(r'(?<=tvglogo:)(.*)(?= grouptitle)');
    var grouptitle = RegExp(r'(?<=grouptitle:)(.*)(?= name)');
    var name = RegExp(r'(?<=name:)(.*)(?=http)');
    var link = RegExp(r'(?<=http://pfsv)(.*)');

    final response = await dio.get('http://cgold.me/5473003172/7148');
    List resposta = response.data.split('#EXTINF:-1 ');
    if (resposta[0] == "#EXTM3U\n") {
      resposta.remove(resposta[0]);
    }
    for (int i = 0; i < resposta.length; i++) {
      listaBruta.add(resposta[i]
          .replaceAll("=", ":")
          .replaceAll(",", " name:")
          .replaceAll("-", "")
          .replaceAll("\"", "")
          .replaceAll("\n", "")
          .replaceAll("\r", ""));
    }
    for (int i = 0; i < listaBruta.length; i++) {
      var match = tvglogo.stringMatch(listaBruta[i]);
      var matchG = grouptitle.stringMatch(listaBruta[i]);
      var matchN = name.stringMatch(listaBruta[i]);
      var matchL = link.stringMatch(listaBruta[i]);
      Map<String, dynamic> result = {
        "tvglogo": match!,
        "grouptitle": matchG!,
        "name": matchN!,
        "link": "http://pfsv${matchL!}"
      };
      Data data = Data.fromMap(result);
      if (lista != null) {
        lista!.add(data);
      } else {
        lista = [data];
      }
    }
    for (int i = 0; i < lista!.length; i++) {
      if (lista![i].grouptitle!.toLowerCase().contains("canais")) {
        if (canais != null) {
          canais!.add(lista![i]);
        } else {
          canais = [lista![i]];
        }
      } else if (lista![i].grouptitle!.toLowerCase().contains("filmes")) {
        if (filmes != null) {
          filmes!.add(lista![i]);
        } else {
          filmes = [lista![i]];
        }
      } else if (lista![i].grouptitle!.toLowerCase().contains("series")) {
        if (series != null) {
          series!.add(lista![i]);
        } else {
          series = [lista![i]];
        }
      } else if (lista![i].grouptitle!.toLowerCase().contains("radios")) {
        if (radios != null) {
          radios!.add(lista![i]);
        } else {
          radios = [lista![i]];
        }
      } else if (lista![i].grouptitle!.toLowerCase().contains("document")) {
        if (documentarios != null) {
          documentarios!.add(lista![i]);
        } else {
          documentarios = [lista![i]];
        }
      } else if (lista![i].grouptitle!.toLowerCase().contains("show")) {
        if (shows != null) {
          shows!.add(lista![i]);
        } else {
          shows = [lista![i]];
        }
      } else if (lista![i].grouptitle!.toLowerCase().contains("cameras")) {
        if (cameras != null) {
          cameras!.add(lista![i]);
        } else {
          cameras = [lista![i]];
        }
      } else if (lista![i].grouptitle!.isEmpty) {
        if (series != null) {
          series!.add(lista![i]);
        } else {
          series = [lista![i]];
        }
      }
      else {
        if (outros != null) {
          outros!.add(lista![i]);
        } else {
          outros = [lista![i]];
        }
      }
    }
  }
}