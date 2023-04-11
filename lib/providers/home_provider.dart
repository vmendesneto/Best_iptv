
import 'package:riverpod/riverpod.dart';

import '../home/controller/home_Controller.dart';


final homeProvider = StateNotifierProvider<HomeController, HomeState>(
      (ref) => HomeController(),
);