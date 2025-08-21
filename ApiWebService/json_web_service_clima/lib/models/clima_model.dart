class ClimaModel {
  //atributos
  final String cidade;
  final double temperatura;
  final String descricao;

  //construtor
  ClimaModel({
    required this.cidade,
    required this.temperatura,
    required this.descricao,
  });

  // toJson e (FromJson)
  //forma diferente de fazer um construtor
  factory ClimaModel.fromJson(Map<String,dynamic> json) {
    return ClimaModel(
      cidade: json['name'],//pega o nome da cidade
      temperatura: json['main']['temp'].toDouble(),//pega a temperatura
      descricao: json['weather'][0]['description'], //pega a descrição
    );
  }
}