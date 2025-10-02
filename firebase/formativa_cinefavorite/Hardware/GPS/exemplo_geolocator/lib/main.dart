// exemplo de uso do GPS

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main(){
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //atributos
  String mensagem = "";
  
  //método para pegar a localização dos dispositivo
  // verificar se a localização esta liberada para uso no app
  Future<String> getLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    //verificar se o serviço de localização esta liberado no dispositivo 
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return "Serviço de Localização desabilitado";
    }
    //solictar a liberação do serviço 
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return "Permissão de Localização Negada";
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    return "Latitude: ${position.latitude} - Longitude: ${position.longitude}";
  }

  @override
  void initState() {
    super.initState();
    //chamar o método ao iniciar a aplicação;
    setState(() {
      mensagem = getLocation().toString();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(
              onPressed: () async{
                String result = await getLocation();
                setState(() {
                  mensagem = result;
                });
              }, 
              child: Text("Obter Localização"))
          ],
        ),
      ),
    );
  }
}