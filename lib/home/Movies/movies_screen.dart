import 'dart:async';

import 'package:bestiptv/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/home_provider.dart';
import '../../service/model/lista_model.dart';

class MoviesPage extends ConsumerStatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends ConsumerState<MoviesPage> {
  String group = '';
  List<Data> t = [];
  late Timer _timer;
  String _timeString = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTime());
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _getCurrentTime() {
    var now = DateTime.now();
    setState(() {
      _timeString =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final movie = ref.watch(moviesProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _timeString,
            style: const TextStyle(
              fontSize: 32,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(127, 255, 212, 1),
                  Color.fromRGBO(255, 0, 0, 6)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: 200,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(250, 128, 114, 1),
              Color.fromRGBO(255, 0, 0, 6)
            ])),
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.white,
                    ),
                itemCount: homeState.gruposFilmes!.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () async {
                      t = await movie.buscarCanalGrupo(
                          homeState.gruposFilmes![i].toString());
                      setState(() {
                        group = homeState.gruposFilmes![i].toString();
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromRGBO(250, 128, 114, 1),
                        Color.fromRGBO(255, 0, 0, 6)
                      ])),
                      child: Center(
                          child: Text(
                        homeState.gruposFilmes![i].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(114, 114, 114, 6),
                    Color.fromRGBO(51, 51, 51, 1),
                  ])),
                  child: Column(
                    children: [
                      Expanded(
                          child: group != ''
                              ? _filtro(context, ref, t)
                              : const Center(
                                  child: Text(
                                    "Selecione uma Categoria",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 35.0),
                                  ),
                                )),
                    ],
                  )))
        ]));
  }
}

Widget _filtro(BuildContext context, WidgetRef ref, List<Data> t) {
  return GridView.builder(
      shrinkWrap: true,
      itemCount: t.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 2,
        mainAxisExtent: 170, // here set custom Height You Want
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(127, 255, 212, 1),
                      Color.fromRGBO(64, 224, 208, 6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(127, 255, 212, 1),
                              Color.fromRGBO(64, 224, 208, 6),
                            ])),
                        child: t[index].tvglogo.toString().contains('http')
                            ? Image.network(t[index].tvglogo.toString(),
                                fit: BoxFit.fill)
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(127, 255, 212, 1),
                                      Color.fromRGBO(64, 224, 208, 6),
                                    ])),
                              ),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        color: Colors.redAccent,
                        child: Center(
                            child: Text(t[index].name.toString(),
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2)),
                      ))
                    ])));
      });
}
