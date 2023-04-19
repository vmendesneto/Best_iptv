
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/database.dart';
import '../../service/model/lista_model.dart';

class LiveTvStates{

  //LiveTvStates({});
}
class LiveTvController extends StateNotifier<LiveTvStates>{
  LiveTvController([LiveTvStates? state]) : super(LiveTvStates());

  final dbHelper = DatabaseProvider.instance;

  buscarCanalGrupo(String grupo) async {
    List<Data>? listas = await dbHelper.getAllGroup(grupo);
    return listas;
  }
}