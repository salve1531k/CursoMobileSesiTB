class Pet {
  final int? id; //Permite valores nulos, na criação de objteos
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefoneDono;
//construtor
  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefoneDono,
  });

  //Converter um obj em um Map(Inserir as info no BD)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'raca': raca,
      'nome_dono': nomeDono,
      'telefone_dono': telefoneDono,
    };
  }

  //Criar um objeto a partir de um Map(Ler uma info do BD)
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      raca: map['raca'] as String,
      nomeDono: map['nome_dono'] as String,
      telefoneDono: map['telefone_dono'] as String);
  }

  @override
  String toString() {
    //Todo: implement toString
    return 'Pet{id: $id, nome: $nome, raça: $raca, Dono: $nomeDono, telefone: $telefoneDono}';
  }
}