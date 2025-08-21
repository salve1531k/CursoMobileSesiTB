class UserModel {
  //atributos
  final String? id; // pode ser nulo inicialmente
  final String author;
  final String avaliable;
  //construtor
  UserModel({
    this.id,
    required this.author,
    required this.avaliable
  });

  //métodos
  //toJson
  Map<String,dynamic> toJson() => {
    "id":id,
    "autor":author,
    "avaliação":avaliable
    };

  //fromJson
  factory UserModel.fromJson(Map<String,dynamic> json) => UserModel(
    id: json["id"].toString(),
    author: json["autor"].toString(), 
    avaliable: json["avaliações"].toString());
}