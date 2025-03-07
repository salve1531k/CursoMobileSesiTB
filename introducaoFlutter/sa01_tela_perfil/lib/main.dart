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
        backgroundColor: const Color.fromARGB(255, 127, 142, 155),) ,
        //Corpo do aplicativo
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: SizedBox(
            height: 780,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: const Color.fromARGB(255, 118, 142, 161), 

                      ),
                    ),
                    Image.asset("assets/img/image.png",
                    width: 200,
                    height: 200,)
                  ],
                  ),
                  
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star,color: Colors.amberAccent,),
                  Icon(Icons.star,color: Colors.amberAccent,),
                  Icon(Icons.star,color: Colors.amberAccent,),
                  Icon(Icons.star,color: Colors.amberAccent,),
                  Icon(Icons.star,color: Colors.amberAccent,),
                ],
              ),
              SizedBox(height: 20,),
              Text("Matheus", style : TextStyle(fontSize: 50),),
              Text("Limeira SP", style: TextStyle(fontSize: 30),),
            
                Row(  mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribui os widgets uniformemente
  crossAxisAlignment: CrossAxisAlignment.center, // Alinha os widgets ao centro verticalmente

                
                  children: [
                 Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 118, 142, 161),  

                      ),
                    ),


                 Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 118, 142, 161),  

                      ),
                    ),
                    
                 Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 118, 142, 161),  

                      ),
                    ),

                  ],
                ),

              Expanded(child: Container(
                margin: EdgeInsets.only(top:50),
                child: ListView(
      children: [
        ListTile(
          leading: Icon(Icons.home), // Ícone à esquerda
          title: Text('Casa'),
        ),
        ListTile(
          leading: Icon(Icons.search), // Ícone à esquerda
          title: Text('Buscar'),
        ),
        ListTile(
          leading: Icon(Icons.settings), // Ícone à esquerda
          title: Text('Configurações'),
        ),
        ListTile(
          leading: Icon(Icons.notifications), // Ícone à esquerda
          title: Text('Notificações'),
        ),
      ],
    ),
              ))
           ])),   
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