import 'package:bestiptv/providers/home_provider.dart';
import 'package:bestiptv/service/conectar_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/model/lista_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Conectar conectar = Conectar();
  String group = '';
  List<Data> t = [];

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
        appBar: AppBar(),
        body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: 200,
            height: double.infinity,
            color: Colors.yellow,
            child: ListView.builder(
                itemCount: homeState.gruposCanais!.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () async {
                      t = await home.buscarCanalGrupo(
                          homeState.gruposCanais![i].toString());
                      setState(() {
                        group = homeState.gruposCanais![i].toString();
                      });
                    },
                    child: Container(
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Text(homeState.gruposCanais![i].toString()),
                            Container(
                              width: double.infinity,
                              height: 2,
                              color: Colors.red,
                            )
                          ],
                        )),
                  );
                }),
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: group != '' ?
                _filtro(context, ref,t) :
                Container(),
              ),
              Expanded(
                  child: Container(
                height: 300,
                color: Colors.green,
                //child: const Text("test"),
              )),
            ],
          ))
        ]));
  }
}

Widget _filtro(BuildContext context, WidgetRef ref, List<Data> t) {
  final homeState = ref.watch(homeProvider);
  print("tamanho de t : ${t.length}");
  return GridView.builder(
      shrinkWrap: true,
      itemCount: t.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 2,
        mainAxisExtent: 200, // here set custom Height You Want
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                height: 120,
                color: Colors.red,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                color: Colors.grey,
                child: Text(t[index].name.toString(),
                    style: const TextStyle(color: Colors.blue)),
              ))
            ]));
      });
}
