import 'package:biblioteca_app/models/loans_models.dart';
import 'package:biblioteca_app/controllers/loan_controller.dart';
import 'package:flutter/material.dart';

class LoanFormView extends StatefulWidget {
  final LoanModel? loan;
  const LoanFormView({super.key, this.loan});

  @override
  State<LoanFormView> createState() => _LoanFormViewState();
}

class _LoanFormViewState extends State<LoanFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LoanController();
  final _userController = TextEditingController();
  final _bookController = TextEditingController();
  DateTime _date = DateTime.now();
  bool _returned = false;

  @override
  void initState() {
    super.initState();
    if (widget.loan != null) {
      _userController.text = widget.loan!.userName;
      _bookController.text = widget.loan!.bookTitle;
      _date = widget.loan!.date;
      _returned = widget.loan!.returned;
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final loan = LoanModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: '', // Preencher com id real do usuário
        bookId: '', // Preencher com id real do livro
        userName: _userController.text,
        bookTitle: _bookController.text,
        date: _date,
        returned: _returned,
      );
      await _controller.create(loan);
      Navigator.pop(context, true);
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final loan = LoanModel(
        id: widget.loan?.id,
        userId: widget.loan?.userId ?? '',
        bookId: widget.loan?.bookId ?? '',
        userName: _userController.text,
        bookTitle: _bookController.text,
        date: _date,
        returned: _returned,
      );
      await _controller.update(loan);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.loan == null ? 'Novo Empréstimo' : 'Editar Empréstimo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _userController,
                decoration: InputDecoration(labelText: 'Usuário'),
                validator: (value) => value!.isEmpty ? 'Informe o usuário' : null,
              ),
              TextFormField(
                controller: _bookController,
                decoration: InputDecoration(labelText: 'Livro'),
                validator: (value) => value!.isEmpty ? 'Informe o livro' : null,
              ),
              ListTile(
                title: Text('Data do Empréstimo: ${_date.day}/${_date.month}/${_date.year}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => _date = picked);
                },
              ),
              SwitchListTile(
                title: Text('Devolvido'),
                value: _returned,
                onChanged: (val) => setState(() => _returned = val),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.loan == null ? _save : _update,
                child: Text(widget.loan == null ? 'Salvar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}