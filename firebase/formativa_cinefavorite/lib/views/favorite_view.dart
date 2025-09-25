import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formativa_cinefavorite/controllers/firesstore_controller.dart';
import 'package:formativa_cinefavorite/models/movie.dart';
import 'package:formativa_cinefavorite/views/search_movie_view.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _firestoreController = FirestoreController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes Favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut, 
            icon: Icon(Icons.logout))
        ],
      ),
      // criar um gridView com os filmes favoritos
      body: StreamBuilder<List<Movie>>(
        stream: _firestoreController.getFavoriteMovies(), 
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(child: Text("Erro ao carregar Lista de Filmes"),);
          }
          if(!snapshot.hasData){
            return Center(child:CircularProgressIndicator());
          }
          if(snapshot.data!.isEmpty){
            return Center(child: Text("Nenhum Filme adicionado ao Favoritos"),);
          }
          final favoriteMovies = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index){
              final movie = favoriteMovies[index];
              return Card(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.file(
                            File(movie.posterPath),
                            fit: BoxFit.cover,
                          ),),
                          Padding(padding: EdgeInsets.all(8),
                          child: Text(movie.title),),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Nota: ${movie.rating.toStringAsFixed(2)}"))
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _firestoreController.removeFavoriteMovie(movie.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${movie.title} removido dos favoritos"))
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, 
          MaterialPageRoute(builder: (context) => SearchMovieView())),
        child: Icon(Icons.search),),
    );
  }
}