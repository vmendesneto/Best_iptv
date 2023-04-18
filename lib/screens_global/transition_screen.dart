import 'package:bestiptv/providers/login_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:bestiptv/providers/home_provider.dart';

import '../home/home.dart';

class Transition extends ConsumerStatefulWidget {
  const Transition({Key? key}) : super(key: key);

  @override
  ConsumerState<Transition> createState() => _Transition();
}

class _Transition extends ConsumerState<Transition> {
  bool puxando = false;
  bool salvando = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginProvider.notifier);
    final home = ref.watch(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: login.getLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading(puxando, salvando);
          } else {
            puxando = true;
            return FutureBuilder(
              future: home.getAllProjects(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loading(puxando, salvando);
                } else {
                  salvando = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  });
                  //return const HomePage();
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}

Widget loading(bool p, bool s) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: p == false
                ? const LinearGradient(colors: [
                    Color.fromRGBO(250, 128, 114, 1),
                    Color.fromRGBO(255, 0, 0, 6)
                  ])
                : const LinearGradient(colors: [
                    Color.fromRGBO(127, 255, 212, 1),
                    Color.fromRGBO(64, 224, 208, 6),
                  ])),
        child: Center(
            child: Column(
          children: [
            const Center(child: Text("CANAIS")),
            Center(child: Text(p == false ? "Carregando" : "Sucesso")),
          ],
        ))),
    Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: s == false
                ? const LinearGradient(colors: [
                    Color.fromRGBO(250, 128, 114, 1),
                    Color.fromRGBO(255, 0, 0, 6)
                  ])
                : const LinearGradient(colors: [
                    Color.fromRGBO(127, 255, 212, 1),
                    Color.fromRGBO(64, 224, 208, 6),
                  ])),
        child: Center(
            child: Column(
          children: [
            const Center(child: Text("Filmes e Series")),
            Center(child: Text(s == false ? "Carregando" : "Sucesso")),
          ],
        ))),
    Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: s == false
                ? const LinearGradient(colors: [
                    Color.fromRGBO(250, 128, 114, 1),
                    Color.fromRGBO(255, 0, 0, 6)
                  ])
                : const LinearGradient(colors: [
                    Color.fromRGBO(127, 255, 212, 1),
                    Color.fromRGBO(64, 224, 208, 6),
                  ])),
        child: Center(
            child: Column(
          children: [
            const Center(child: Text("EPG")),
            Center(child: Text(s == false ? "Carregando" : "Sucesso")),
          ],
        ))),
  ]);
}
