import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controllers/point_controller.dart';
import '../controllers/auth_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _status = '';
  bool _loading = false;

  String get _nifFromUser {
    final user = AuthController.currentUser ?? FirebaseAuth.instance.currentUser;
    if (user == null) return 'unknown';
    // Our synthetic email was nif@sa_trabalho.local
    final email = user.email ?? '';
    return email.split('@').first;
  }

  Future<void> _registerPoint() async {
    setState(() {
      _loading = true;
      _status = '';
    });
    try {
      final point = await PointController.registerPoint(nif: _nifFromUser);
  setState(() => _status = 'Ponto registrado: ${point.timestamp.toLocal()}\nDistância: ${point.distanceMeters.toStringAsFixed(1)}m\nPermitido: ${point.allowed}');
    } catch (e) {
      setState(() => _status = 'Erro: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _signOut() async {
    await AuthController.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), actions: [IconButton(onPressed: _signOut, icon: const Icon(Icons.logout))]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Usuário: $_nifFromUser'),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _loading ? null : _registerPoint, child: const Text('Registrar Ponto')),
          const SizedBox(height: 12),
          if (_loading) const Center(child: CircularProgressIndicator()),
          if (_status.isNotEmpty) Text(_status),
        ]),
      ),
    );
  }
}
