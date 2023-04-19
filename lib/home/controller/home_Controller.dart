import 'package:bestiptv/db/database.dart';
import 'package:bestiptv/home/LiveTv/liveTv_controller.dart';
import 'package:riverpod/riverpod.dart';

import '../../service/model/lista_model.dart';

class HomeState {
  List<Data>? lista;
  List<Data>? canais;
  List<Data>? filmes;
  List<Data>? series;
  List<Data>? radios;
  List<Data>? outros;
  List<Data>? cameras;
  List<Data>? documentarios;
  List<Data>? shows;
  List<String>? gruposCanais;
  List<String>? gruposFilmes;

  HomeState({
    this.lista,
    this.canais,
    this.documentarios,
    this.series,
    this.outros,
    this.cameras,
    this.filmes,
    this.radios,
    this.shows,
    this.gruposCanais,
    this.gruposFilmes,
  });
}

class HomeController extends StateNotifier<HomeState> {
  HomeController([HomeState? state]) : super(HomeState());

  final dbHelper = DatabaseProvider.instance;
  LiveTvController livetv = LiveTvController();

  getAllProjects() async {
    List<Data>? canal;
    List<Data>? filme;
    List<Data>? serie;
    List<Data>? radio;
    List<Data>? outro;
    List<Data>? camera;
    List<Data>? documentario;
    List<Data>? show;
    List<String> gCanais = [];
    List<String> gFilmes = [];
    List<Data>? listas = await dbHelper.getAllCanais();

    for (var i = 0; i < listas.length; i++) {
      if (listas[i].grouptitle!.toLowerCase().contains("canais")) {
        if (canal != null) {
          canal.add(listas[i]);
          var contain = gCanais
              .where((element) => element == listas[i].grouptitle.toString());
          if (contain.isEmpty) {
            gCanais.add(listas[i].grouptitle.toString());
            gCanais.sort((a, b) => a
                .toLowerCase()
                .toString()
                .compareTo(b.toLowerCase().toString()));
          }
        } else {
          canal = [listas[i]];
        }
      } else if (listas[i].grouptitle!.toLowerCase().contains("filmes")) {
        if (filme != null) {
          filme.add(listas[i]);
          var contain = gFilmes
              .where((element) => element == listas[i].grouptitle.toString());
          if (contain.isEmpty) {
            gFilmes.add(listas[i].grouptitle.toString());
            gFilmes.sort((a, b) => a
                .toLowerCase()
                .toString()
                .compareTo(b.toLowerCase().toString()));
          }
        } else {
          filme = [listas[i]];
        }
      } else if (listas[i].grouptitle!.toLowerCase().contains("series")) {
        if (serie != null) {
          serie.add(listas[i]);
        } else {
          serie = [listas[i]];
        }
      } else if (listas[i].grouptitle!.toLowerCase().contains("radios")) {
        if (radio != null) {
          radio.add(listas[i]);
        } else {
          radio = [listas[i]];
        }
      } else if (listas[i].grouptitle!.toLowerCase().contains("document")) {
        if (documentario != null) {
          documentario.add(listas[i]);
        } else {
          documentario = [listas[i]];
        }
      } else if (listas[i].grouptitle!.toLowerCase().contains("show")) {
        if (show != null) {
          show.add(listas[i]);
        } else {
          show = [listas[i]];
        }
      } else if (listas[i].grouptitle!.toLowerCase().contains("cameras")) {
        if (camera != null) {
          camera.add(listas[i]);
        } else {
          camera = [listas[i]];
        }
      } else if (listas[i].grouptitle!.isEmpty) {
        if (serie != null) {
          serie.add(listas[i]);
        } else {
          serie = [listas[i]];
        }
      } else {
        if (outro != null) {
          outro.add(listas[i]);
        } else {
          outro = [listas[i]];
        }
      }
    }
    state = HomeState(
        lista: listas,
        cameras: camera,
        canais: canal,
        filmes: filme,
        radios: radio,
        documentarios: documentario,
        outros: outro,
        shows: show,
        series: serie,
        gruposCanais: gCanais,
        gruposFilmes: gFilmes);
    //print(state.canais);
    //return listas;
  }

  buscarCanalGrupo(String grupo) async {
    List<Data>? listas = await dbHelper.getAllGroup(grupo);
    state = HomeState(
        lista: state.lista,
        cameras: state.cameras,
        canais: state.canais,
        filmes: state.filmes,
        radios: state.radios,
        documentarios: state.documentarios,
        outros: state.outros,
        shows: state.shows,
        series: state.series,
        gruposCanais: state.gruposCanais,
        gruposFilmes: state.gruposFilmes);
    return listas;
  }
}
