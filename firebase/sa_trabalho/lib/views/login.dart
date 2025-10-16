import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _nifController = TextEditingController();
  final _passController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _loginWithNif() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await AuthController.signInWithNifAndPassword(_nifController.text.trim(), _passController.text);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loginWithBiometrics() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final ok = await AuthController.authenticateWithBiometrics();
      if (!ok) throw Exception('Biometria não disponível ou não autenticada.');
      // If there's already a firebase user (previously logged in), let them proceed.
      if (AuthController.currentUser == null) {
        throw Exception('Nenhum usuário autenticado no Firebase. Faça login com NIF/senha primeiro.');
      }
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _nifController, decoration: const InputDecoration(labelText: 'NIF')),
          TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
          const SizedBox(height: 12),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          ElevatedButton(onPressed: _loading ? null : _loginWithNif, child: _loading ? const CircularProgressIndicator() : const Text('Entrar')),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _loading ? null : _loginWithBiometrics, child: const Text('Entrar com Biometria')),
        ]),
      ),
    );
  }
}
