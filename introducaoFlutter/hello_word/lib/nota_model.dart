class Nota{
  //atributos
  final int id;// permite seja nula
  final String titulo;
  final String conteudo;

  //construtor
  Nota({this.id, required this.titulo, required this.conteudo});


  //Metodos Map // Factory ==> entre banco de dados e objeto

//converte um objeto da classe nota (para inserir no banco de dados)

Map<String, dynamic> toMap() {
    return {
      "id": id, // id pode ser nulo, mas o banco de dados não aceita nulo
      "titulo": titulo,
      "conteudo": conteudo
    };
  }

  //Converte um Map (Vindo do Bano de Dados) para um objeto da classe Nota
  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
      conteudo: map['conteudo'] as String,
    );
  }

  //Metodos para imprimir os dsdos
  @override
  String toString() {
    return "Nota: {id: $id, titulo: $titulo, conteudo: $conteudo}";
  }
}