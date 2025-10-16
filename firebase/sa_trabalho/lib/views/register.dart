import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nifController = TextEditingController();
  final _passController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final nif = _nifController.text.trim();
    final pass = _passController.text;
    if (nif.isEmpty || nif.contains('@')) {
      setState(() {
        _error = 'NIF inválido. Não inclua @ ou deixe em branco.';
        _loading = false;
      });
      return;
    }
    if (pass.length < 6) {
      setState(() {
        _error = 'Senha deve ter pelo menos 6 caracteres.';
        _loading = false;
      });
      return;
    }
    try {
      await AuthController.registerWithNifAndPassword(nif, pass);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _nifController, decoration: const InputDecoration(labelText: 'NIF')),
          TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
          const SizedBox(height: 12),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          ElevatedButton(onPressed: _loading ? null : _register, child: _loading ? const CircularProgressIndicator() : const Text('Cadastrar')),
        ]),
      ),
    );
  }
}
