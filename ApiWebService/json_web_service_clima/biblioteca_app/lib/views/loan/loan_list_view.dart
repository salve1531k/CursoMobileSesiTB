import 'package:biblioteca_app/models/loans_models.dart';
import 'package:biblioteca_app/controllers/loan_controller.dart';
import 'package:biblioteca_app/views/loan/loan_form_view.dart';
import 'package:flutter/material.dart';

class LoanListView extends StatefulWidget {
  const LoanListView({super.key});

  @override
  State<LoanListView> createState() => _LoanListViewState();
}

class _LoanListViewState extends State<LoanListView> {
  final _controller = LoanController();
  List<LoanModel> _loans = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      final result = await _controller.fetchAll();
      print('Empréstimos recebidos do backend:');
      print(result);
      _loans = result;
    } catch (e) {
      print('Erro ao carregar empréstimos: $e');
    }
    setState(() => _loading = false);
  }

  void _openForm({LoanModel? loan}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoanFormView(loan: loan)),
    );
    if (result == true) _load();
  }

  void _delete(LoanModel loan) async {
    if (loan.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Text("Deseja realmente excluir o empréstimo?"),
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
        await _controller.delete(loan.id!);
        _load();
      } catch (e) {
        // tratar erro
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
                    child: _loans.isEmpty
                        ? Center(child: Text('Nenhum empréstimo cadastrado.'))
                        : ListView.builder(
                            itemCount: _loans.length,
                            itemBuilder: (context, index) {
                              final loan = _loans[index];
                              return Card(
                                child: ListTile(
                                  title: Text('Usuário: ${loan.userName}'),
                                  subtitle: Text('Livro: ${loan.bookTitle}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () => _openForm(loan: loan),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _delete(loan),
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