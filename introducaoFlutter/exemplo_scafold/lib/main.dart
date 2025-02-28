// vid main
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Estudo do scaffold
      home: Scaffold(
        //Barra de navegação superior
        appBar: AppBar(title: Text("Exemplo AppBar"),
        backgroundColor: Colors.blue,) ,
        //Corpo do aplicativo
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Coluna 1"),
              Text("Coluna 2"),
              Text("Coluna 3")
            ]),
            Text("Linha 2"),
            Text("Linha 3")
          ],
        ),
        //Barra lateral (menu Hamburguer)
        drawer:Drawer(child: ListView(
          children: [
            Text("Inicio"),
            Text("Conteúdo"),
            Text("Contato"),
          ],
        ),),
        //Barra de navegação inferior
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "pesquisa"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuario"),
        ]),
        //Botão flutuante
        floatingActionButton: FloatingActionButton(onPressed: (){
          print("Botão Clicado");
        } ,
        child: Icon(Icons.add),
      ),)
    );

  }

}