import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/database.dart';
import '../../service/model/lista_model.dart';

class MoviesStates {}

class MoviesController extends StateNotifier<MoviesStates> {
  MoviesController([MoviesStates? state]) : super(MoviesStates());

  final dbHelper = DatabaseProvider.instance;

  buscarCanalGrupo(String grupo) async {
    List<Data>? listas = await dbHelper.getAllGroup(grupo);
    return listas;
  }
}
