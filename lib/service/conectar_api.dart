import 'package:bestiptv/home/controller/home_Controller.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';


import '../db/database.dart';
import 'model/lista_model.dart';

final dio = Dio();
final dbHelper = DatabaseProvider.instance;
HomeController home = HomeController();

class Conectar {
  List<String> listaBruta = [];
  List<Data>? lista;

//Pegou o Html e transformou em uma lista com as informações
  Future get(String user, String pass) async {
   // if (await dbHelper.database == null) {
      var tvglogo = RegExp(r'(?<=tvglogo:)(.*)(?= grouptitle)');
      var grouptitle = RegExp(r'(?<=grouptitle:)(.*)(?= name)');
      var name = RegExp(r'(?<=name:)(.*)(?=http)');
      var link = RegExp(r'(?<=http://pfsv)(.*)');

      final response = await dio.get('http://cgold.me/$user/$pass');
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
      //Salvou a lista com as informações em uma tabela
      //Salvando no Banco
      //for (int i = 0; i < lista!.length; i++) {
        if (lista != null) {
         await dbHelper.insertCanal(lista!);
       // }
      }
      await home.getAllProjects();
  //  } else {
   //   return await home.getAllProjects();
  //  }
  }
}
