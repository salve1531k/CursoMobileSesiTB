import 'package:biblioteca_app/views/book/book_list_view.dart';
import 'package:biblioteca_app/views/loan/loan_list_view.dart';
import 'package:biblioteca_app/views/user/user_list_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0;//indice de navegação da páginas

  final List<Widget> _pages = [
    const BookListView(),
    const LoanListView(),
    const UserListView()
  ];

  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciador de Biblioteca"),),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(()=> _index = value),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Livros"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Emprétimos"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Usuarios"),
        ]),
    );
  }
}