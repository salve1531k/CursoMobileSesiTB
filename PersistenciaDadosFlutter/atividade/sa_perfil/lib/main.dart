import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil Pessoal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  String? _corFavorita = 'Azul';
  String _nome = '';
  String _idade = '';
  String _corFavoritaSalva = 'Azul';

  final Map<String, Color> corMap = {
    'Azul': Colors.blue,
    'Vermelho': Colors.red,
    'Verde': Colors.green,
    'Amarelo': Colors.yellow,
    'Roxo': Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  _carregarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _idade = prefs.getString('idade') ?? '';
      _corFavoritaSalva = prefs.getString('cor_favorita') ?? 'Azul';
    });
  }

  _salvarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    await prefs.setString('idade', _idadeController.text);
    await prefs.setString('cor_favorita', _corFavorita!);

    setState(() {
      _nome = _nomeController.text;
      _idade = _idadeController.text;
      _corFavoritaSalva = _corFavorita!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corMap[_corFavoritaSalva]!.withOpacity(0.2),
      appBar: AppBar(
        title: Text('Seu Perfil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(
                labelText: 'Idade',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _corFavorita,
              decoration: InputDecoration(
                labelText: 'Cor Favorita',
                prefixIcon: Icon(Icons.color_lens),
              ),
              items: corMap.keys.map((String cor) {
                return DropdownMenuItem<String>(
                  value: cor,
                  child: Text(cor),
                );
              }).toList(),
              onChanged: (String? novaCor) {
                setState(() {
                  _corFavorita = novaCor!;
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _salvarDados,
              icon: Icon(Icons.save),
              label: Text('Salvar Dados'),
            ),
            SizedBox(height: 32),
            if (_nome.isNotEmpty || _idade.isNotEmpty)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dados Salvos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('👤 Nome: $_nome'),
                      Text('📅 Idade: $_idade'),
                      Text('🎨 Cor Favorita: $_corFavoritaSalva'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
