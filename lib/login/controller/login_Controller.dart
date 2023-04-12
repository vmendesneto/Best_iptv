import 'package:bestiptv/home/controller/home_Controller.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../../service/conectar_api.dart';

class loginState {
  String? user;
  String? pass;
  bool? validation;
  String? message;
  loginState({this.user, this.pass, this.validation,this.message});
}

class LoginController extends StateNotifier<loginState> {
  LoginController([loginState? state]) : super(loginState());

  Conectar conectar = Conectar();



  //SE URL EXISTE TROCA DE TELA
  Future login() async {
    String? user = state.user;
    String? pass = state.pass;
    Response? response = null;

    if (user != null && pass != null) {
      try {
        response = await dio.get('http://cgold.me/$user/$pass');
        if(response.statusCode == 200){
          String m = "OK";
          state = loginState(validation: true,pass: state.pass,user: state.user, message: m);
          await conectar.get(state.user!, state.pass!);
        }
      } on DioError catch (e) {
        if (e.response != null) {
        //  print("Erro 404");
          String m = e.message.toString();
          state = loginState(validation: false,pass: state.pass,user: state.user, message: m);
         // print(e.message);
        } else {
          String m = e.message.toString();
          state = loginState(validation: false,pass: state.pass,user: state.user,message: m);
          //print(e.requestOptions);
          //print(e.message);
        }
      }
    } else {
      print('Usuario inválido no login Controller');
    }
  }
}


