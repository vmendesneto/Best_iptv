
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/database.dart';
import '../../service/model/lista_model.dart';

class SeriesStates{


}
class SeriesController extends StateNotifier<SeriesStates>{
  SeriesController([SeriesStates? state]) : super(SeriesStates());

  final dbHelper = DatabaseProvider.instance;

  buscarCanalGrupo(String grupo) async {
    List<Map<String, dynamic>>? series = [];
    var SerieNome = RegExp(r'(.*)(?= S)');
    List<Data>? listas = await dbHelper.getAllGroup(grupo);
    for (var i = 0; i < listas.length; i++) {
      String nome = listas[i].name.toString();
      var match = SerieNome.stringMatch(nome);
      var contain = series.where((element) => element['name'] == match);
      if (contain == null || contain.isEmpty) {
        series.add({'name': match, 'logo': listas[i].tvglogo.toString()});
      }
    }
    return series;
  }

}