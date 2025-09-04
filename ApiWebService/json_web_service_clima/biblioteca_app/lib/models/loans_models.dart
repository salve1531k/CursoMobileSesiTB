class LoanModel {
  final String? id;
  final String userId;
  final String bookId;
  final String userName;
  final String bookTitle;
  final DateTime date;
  final bool returned;

  LoanModel({
    this.id,
    required this.userId,
    required this.bookId,
    required this.userName,
    required this.bookTitle,
    required this.date,
    required this.returned,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "bookId": bookId,
    "userName": userName,
    "bookTitle": bookTitle,
    "date": date.toIso8601String(),
    "returned": returned,
  };

  factory LoanModel.fromMap(Map<String, dynamic> map) => LoanModel(
    id: map["id"]?.toString() ?? map["_id"]?.toString(),
    userId: map["userId"].toString(),
    bookId: map["bookId"].toString(),
    userName: map["userName"].toString(),
    bookTitle: map["bookTitle"].toString(),
    date: DateTime.parse(map["date"]),
    returned: map["returned"] == true,
  );
}
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