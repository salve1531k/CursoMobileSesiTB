import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaController {
  final String _apiKey = "d4c6945475c91ce148692bfdb49e7a5b"; //chave da API

  //método get
  Future<ClimaModel?> getClima(String cidade) async {
   final url = Uri.parse(
    "https://openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&units=metric&lang=pt_br"
   );

   final response = await http.get(url);
   if(response.statusCode ==200){
    final dados = json.decode(response.body);
    return ClimaModel.fromJson(dados);
   }else{
    return null;
   }
  }
}