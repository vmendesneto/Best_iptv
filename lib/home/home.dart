import 'package:bestiptv/providers/home_provider.dart';
import 'package:bestiptv/service/conectar_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Conectar conectar = Conectar();

  @override
  Widget build(BuildContext context) {
  //  final home = ref.watch(homeProvider.notifier);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
        appBar: AppBar(),
        body: Container(
            width: 200,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  homeState.canais![index].name.toString(),
                  style: const TextStyle(color: Colors.blue),
                );
              },
            )));
  }
}
