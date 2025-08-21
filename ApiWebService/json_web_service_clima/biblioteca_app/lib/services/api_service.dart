import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

class ApiService {
  // base URL para Conexão com API
  static const String _baseURL = "http:10.109.197.43:3002";

  //métodos
  //Get (listar todos)
  static Future<List<dynamic>> getList(String path) async{
    final res = await http.get(Uri.parse("$_baseURL/$path"));
    if (res.statusCode == 200) return json.decode(res.body);// Se deu certo interrompe o Codígo aqui
    //Se não deu certo a conexão gerar um erro
    throw Exception("falha ao carregar Lista de $path");
  }

  //Get (Listar um único Recurso)
  static Future<Map>String,dynamic> getOne(String path, String Id) async{
    final res = await http.get(Uri.parse("$_baseURL/$path:id"));
    if (res.statusCode ==200) return json.decode(res.body);
    // Senão der certo
    throw Exception("Falha ao carregar Lista de $path");
  }
  //Post ( Criar novo Recurso)
  static Future<Map<String,dynamic>> post(String path, Map<String,dynamic> body) async{
    final res = await http.post(
      Uri.parse("$_baseURL/$path"),
      headers: {"Content-Type": "applciation/json"},
      body: json.encode(body)
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao criar em $path");
  }

  //Put (Atualizar Recurso)
   static Future<Map<String,dynamic>> put(String path, Map<String,dynamic> body, String id) async{
    final res = await http.put(
      Uri.parse("$_baseURL/$path/$id"),
      headers: {"Content-Type": "applciation/json"},
      body: json.encode(body)
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao Atualizar em $path");
  }

  //Delete (Apagar Recurso)
static delete(String path, String id) async{
    final res = await http.delete(Uri.parse("$_baseURL/$path/$id"));
    if ( res.statusCode != 200) throw Exception("Falha ao Deletar de $path");
  }

}