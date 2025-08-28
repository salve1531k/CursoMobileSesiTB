
import 'package:biblioteca_app/models/book_models.dart';
import 'package:biblioteca_app/services/api_service.dart';

class BookControler {
  // Não precisa instanciar ApiService (métodos estáticos)

  // GET dos Livros
  Future<List<BookModel>> fetchAll() async {
    final list = await ApiService.getList("books?_sort=title"); // Ordena por título
    print('Lista de livros recebida do backend:');
    print(list);
    // Retorna a lista de livros convertida para BookModel
    return list.map<BookModel>((item) => BookModel.fromMap(item)).toList();
  }

  // POST -> Criar novo livro
  Future<BookModel> create(BookModel book) async {
    final created = await ApiService.post("books", book.toMap());
    print('Livro criado no backend:');
    print(created);
    // Retorna o livro criado
    return BookModel.fromMap(created);
  }

  // GET -> Buscar um livro
  Future<BookModel> fetchOne(String id) async {
    final book = await ApiService.getOne("books", id);
    // Retorna o livro encontrado
    return BookModel.fromMap(book);
  }

  // PUT -> Atualizar livro
  Future<BookModel> update(BookModel book) async {
    final updated = await ApiService.put("books", book.toMap(), book.id!);
    // Retorna o livro atualizado
    return BookModel.fromMap(updated);
  }

  // DELETE -> Apagar livro
  Future<void> delete(String id) async {
    await ApiService.delete("books", id);
    // Não há retorno, livro deletado com sucesso
  }

}