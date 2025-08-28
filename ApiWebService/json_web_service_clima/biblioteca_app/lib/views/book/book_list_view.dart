
import 'package:biblioteca_app/controllers/book_controller.dart';
import 'package:biblioteca_app/models/book_models.dart';
import 'package:biblioteca_app/views/book/book_form_view.dart';
import 'package:flutter/material.dart';

class BookListView extends StatefulWidget {
  const BookListView({super.key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  final _controller = BookControler();
  List<BookModel> _books = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }


  void _load() async {
    setState(() => _loading = true);
    try {
      _books = await _controller.fetchAll();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar livros')),
      );
    }
    setState(() => _loading = false);
  }

  void _openForm({BookModel? book}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookFormView(book: book)),
    );
    if (result == true) _load();
  }

  void _delete(BookModel book) async {
    if (book.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: Livro sem ID! Não é possível excluir.')),
      );
      print('Tentativa de excluir livro sem id!');
      return;
    }
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Text("Deseja realmente excluir o livro '${book.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Excluir")),
        ],
      ),
    );
    if (confirm == true) {
      try {
        await _controller.delete(book.id!);
        _load();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir livro!')),
        );
        print('Erro ao excluir livro: '
            '${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: _books.isEmpty
                        ? Center(child: Text('Nenhum livro cadastrado.'))
                        : ListView.builder(
                            itemCount: _books.length,
                            itemBuilder: (context, index) {
                              final book = _books[index];
                              return Card(
                                child: ListTile(
                                  title: Text(book.title),
                                  subtitle: Text(book.author),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () => _openForm(book: book),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _delete(book),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}