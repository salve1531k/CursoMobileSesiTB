import 'package:flutter/material.dart';

void main() { //roda a minha aplicação
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {//janela de aplicação
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp( // Base de construção
      home: Scaffold(// modelo de pagina
      appBar: AppBar(
      title: Text("App Hello World")),
        body: Center(
          child: ElevatedButton(onPressed: () => Fluttertoast.showToast(
            msg: "Hello, World!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.Center
          )
          child: Text("Ver mensagem"),),
        ),
      ),
    );
  }
}
