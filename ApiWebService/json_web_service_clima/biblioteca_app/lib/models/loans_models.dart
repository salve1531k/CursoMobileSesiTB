class LoansModel {
  //atributos
  final String? id; // pode ser nulo inicialmente
  final String idusu;
  final String idbo;
  final String retirada;
  final String devolucion;
  final String se;
  //construtor
  LoansModel({
    this.id,
    required this.idusu,
    required this.idbo,
    required this.retirada,
    required this.devolucion,
    required this.se
  });

  //métodos
  //toJson
  Map<String,dynamic> toJson() => {
    "id":id,
    "idUsuario":idusu,
    "IddoLivro":idbo,
    "retirada":retirada,
    "devolução":devolucion,
    "devolveu":se
    };

  //fromJson
  factory LoansModel.fromJson(Map<String,dynamic> json) => LoansModel(
    id: json["id"].toString(),
    idusu: json["Idusuario"].toString(), 
    idbo: json["Idlivro"].toString(),
    retirada: json["retirada"].toString(),
    devolucion: json["data de devlução"].toString(), 
    se: json["devolveu"].toString());
}