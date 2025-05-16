import 'package:intl/intl.dart';

class Consulta{
  final int? id;//Vai ser gerado pelo BD
  final int petId;// Chave Estrangeira para o PET
  final DateTime dataHora;
  final String tipoServico;
  final String? observacao; // pode ser nulo

  //Construtor
  Consulta({
    this.id,
    required this.petId,
    required this.dataHora,
    required this.tipoServico,
    this.observacao
  });

  //Converter Map Obj => BD
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pet_id': petId,
      'data_hora': dataHora.toIso8601String(),
      'tipo_servico': tipoServico,
      'observacao': observacao
    };
  }

  //Converter Obj: BD => Obj
  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      id: map['id'] as int,
      petId: map['pet_id'] as int,
      dataHora: DateTime.parse(map['data_hora'] as String),//Converte String para Date time
      tipoServico: map['tipo_servico'] as String,
      observacao: map['observacao'] as String?
    );
  }

  //Formatação de data e hora em formato regional
  String get dataHoraFormata {
    final formatter = DateFormat("dd//MM/yyyy HH:mm");
    return formatter.format(dataHora);
    }

  @override
  String toString() {
    //TODO: implement toString
    return 'Consulta{id: $id, petId: $petId, dataHora: $dataHora, tipoServico: $tipoServico, observacao: $observacao}';
  }
}