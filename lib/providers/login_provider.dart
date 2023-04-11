
import 'package:riverpod/riverpod.dart';

import '../login/controller/login_Controller.dart';



final loginProvider = StateNotifierProvider<LoginController, loginState>(
      (ref) => LoginController(),
);