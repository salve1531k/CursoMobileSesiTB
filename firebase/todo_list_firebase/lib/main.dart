import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //garantir a inicialização dos bindings
  //Inicializa o firebase no mesmo tempo que abre as telas
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions().currentPlatform
  );
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: AutenticaçãoView(), //direciona para a tela de autenticação
  ));
}