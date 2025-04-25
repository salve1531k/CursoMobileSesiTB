import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Dados Pessoais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  // Carregar os dados armazenados
  _carregarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _idade = prefs.getString('idade') ?? '';
      _corFavoritaSalva = prefs.getString('cor_favorita') ?? 'Azul';
    });
  }

  // Salvar os dados no SharedPreferences
  _salvarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    await prefs.setString('idade', _idadeController.text);
    await prefs.setString('cor_favorita', _corFavorita!);

    // Atualizar os dados na interface
    setState(() {
      _nome = _nomeController.text;
      _idade = _idadeController.text;
      _corFavoritaSalva = _corFavorita!;
    });
  }

  // Função para escolher a cor favorita
  _escolherCor(String cor) {
    setState(() {
      _corFavorita = cor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Dados Pessoais'),
      ),
      body: Container(
        color: _corFavoritaSalva == 'Azul'
            ? Colors.blue
            : _corFavoritaSalva == 'Vermelho'
                ? Colors.red
                : _corFavoritaSalva == 'Verde'
                    ? Colors.green
                    : Colors.yellow,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(labelText: 'Idade'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _corFavorita,
              items: <String>['Azul', 'Vermelho', 'Verde', 'Amarelo']
                  .map((String cor) {
                return DropdownMenuItem<String>(
                  value: cor,
                  child: Text(cor),
                );
              }).toList(),
              onChanged: (String? novaCor) {
                _escolherCor(novaCor!);
              },
            ),
            ElevatedButton(
              onPressed: _salvarDados,
              child: Text('Salvar Dados'),
            ),
            SizedBox(height: 20),
            Text(
              'Dados salvos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Nome: $_nome'),
            Text('Idade: $_idade'),
            Text('Cor Favorita: $_corFavoritaSalva'),
          ],
        ),
      ),
    );
  }
}
