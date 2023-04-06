import 'package:bestiptv/service/conectar_api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Conectar conectar = Conectar();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: conectar.get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(
            color: Colors.red,
          ));
        } else {
          return Container(
              height: 70,
              width: 200,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                 return Text(conectar.canais![index].name.toString(),style: const TextStyle(color: Colors.blue),);
                },
              ));
        }
      },
    );
  }
}
