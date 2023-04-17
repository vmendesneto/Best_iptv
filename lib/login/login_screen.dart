import 'package:bestiptv/providers/login_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../screens_global/transition_screen.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  TextEditingController loginController =
      TextEditingController(text: '5473003172');
  TextEditingController passController = TextEditingController(text: '7148');

  bool click = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final login = ref.watch(loginProvider.notifier);

    return Scaffold(
        //backgroundColor: Colors.grey,
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(top: 50),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.redAccent),
                                    child: TextField(
                                      controller: loginController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Login",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.redAccent),
                                    child: TextField(
                                      controller: passController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                loginState.user = loginController.text;
                                loginState.pass = passController.text;
                                setState(() {
                                  click = true;
                                });
                                await login.login();
                                pressButton(context, ref, click);
                              },
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(127, 255, 212, 1),
                                      Color.fromRGBO(64, 224, 208, 6),
                                    ])),
                                child: Center(
                                  child: click == false
                                      ? const Text(
                                          "Enter",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const CircularProgressIndicator(
                                          color: Colors.yellow),
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   height: 70,
                            // ),
                          ],
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

pressButton(BuildContext context, WidgetRef ref, bool click) {
  final loginState = ref.watch(loginProvider);
  if (loginState.validation == true) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Transition()));
  } else {
    AlertDialog alerta = AlertDialog(
      title: Text(loginState.message!),
      //content: Text("Erro: ${loginState.message!}"),
      actions: [
        ElevatedButton(
            onPressed: () {
              click = false;
              Navigator.pop(context);
            },
            child: const Text("OK"))
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
