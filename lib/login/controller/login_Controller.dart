import 'package:riverpod/riverpod.dart';

import '../../service/conectar_api.dart';

class loginState {
 String? user;
 String? pass;

  loginState({this.user,this.pass});
}

class LoginController extends StateNotifier<loginState> {
  LoginController([loginState? state]) : super(loginState());

  Conectar conectar = Conectar();

  Future login() async {
    String? user = state.user;
    String? pass = state.pass;
    if(user != null && pass != null){
      await conectar.get(state.user!, state.pass!);
    }else {
      print('Usuario inválido no login Controller');
    }

  }


}