import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../../service/conectar_api.dart';

class loginState {
  String? user;
  String? pass;
  bool? validation;
  String? message;

  loginState({this.user, this.pass, this.validation, this.message});
}

class LoginController extends StateNotifier<loginState> {
  LoginController([loginState? state]) : super(loginState());

  Conectar conectar = Conectar();

  Response? response;

  //SE URL EXISTE TROCA DE TELA
  Future login() async {
    String? user = state.user;
    String? pass = state.pass;
    if (user != null && pass != null) {
      BaseOptions options = BaseOptions(
        baseUrl: 'http://cgold.me/',
        connectTimeout: 10 * 1000,
        receiveTimeout: 25 * 1000,
      );
      Dio dio = Dio(options);
      try {
        response = await dio.get('http://cgold.me/$user/$pass');
        print(response!.data);
        if (response!.statusCode == 200) {
          String m = "OK";
          state = loginState(
              validation: true, pass: state.pass, user: state.user, message: m);
          //  await conectar.get(state.user!, state.pass!, response);
        }
      } on DioError catch (e) {
        if (e.response != null) {
          //  Usuario ou senha inválido
          String m = e.message.toString();
          state = loginState(
              validation: false,
              pass: state.pass,
              user: state.user,
              message: "Usuario ou senha Inválido.");
          // print(e.message);
        } else {
          //Sem Internet
          String m = e.message.toString();
          state = loginState(
              validation: false,
              pass: state.pass,
              user: state.user,
              message: "Sem conexão com a Internet");
          //print(e.requestOptions);
          //print(e.message);
        }
      }
    } else {
      print('Usuario inválido no login Controller');
    }
  }

  Future getLogin() async {
    if (response != null && state.user != null && state.pass != null) {
      await conectar.get(state.user!, state.pass!, response!);
    } else {
      print("Recebeu algo nulo no Login Controller getLogin()");
    }
  }
}
