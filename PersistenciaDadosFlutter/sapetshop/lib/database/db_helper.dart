import 'dart:io';

import 'package:path/path.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sapetshop/models/consulta_model.dart';
import 'package:sapetshop/models/pet.model.dart';
import 'package:sqflite/sqflite.dart';

class PetShopDBHelper{
  static Database? _database; //obj para criar conexões

  Future<Database> get database async{
    if(_database != null){
      return _database!;//se o banco já existe , retorna ele mesmo
    }
    //se não existe - inicia a conexão
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async{
    final _dbPath = await getDatabasesPath();
    final path = join(_dbPath,"petshop.db"); //caminho do banco de Dados

    return await openDatabase(
      path,
      version:1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    //criar a tabela dos pets
    await db.execute(
      """CREATE TABLE pets(id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      raca TEXT NOT NULL,
      nome_dono TEXT NOT NULL,
      telefone_dono TEXT NOT NULL)"""
    );

    //CRIAR A TABELA DAS CONSULTAS
    await db.execute(
      """CREATE TABLE consultas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pet_id INTEGER NOT NULL,
      data_hora TEXT NOT NULL,
      tipo_servico TEXT NOT NULL,
      observacao TEXT, 
      FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE)"""
    );
  }

  //MÉTODOS CRUD PARA pets
  Future<int> insertPet(Pet pet) async{
    final db = await database;
    return await db.insert("pets", pet.toMap());//retirna o id do pet inserido
  }

  Future<List<Pet>> getAllPets() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("pets"); //recebe todos os pets cadastrados
    //Converetr em objetos
    return maps.map((e)=>Pet.fromMap(e)).toList();
    // adiciona e por elemento na lista já convertido em Obj
  }

  Future<Pet?> getPetById(int id) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query( //Faz a busca no BD
      "pets",where: "id = ?",whereArgs: [id]); // A partir do ID solicitado
     //Se encontrado
    if(maps.isNotEmpty){
      return Pet.fromMap(maps.first);// cria o obj com 1º elementos da list
    }else{
      null;
    }
  }

  Future<int> deletePet(int id) async{
    final db = await database;
    return await db.delete("pets", where: "id = ?", whereArgs: [id]);
    // delete da tabela e tenha o id igual ao passado pelo parametro
  }

  //Métododos CRUD para consultas
  Future<int> insertConsulta(Consulta consulta) async{
    final db = await database;
    //Insere conexão no banco de dados
    return await db.insert("consultas", consulta.toMap());
  }

  Future<List<Consulta>> getConsultaForPet(int petId) async{
    final db = await database;
    //Consulta especifico
    final List<Map<String, dynamic>> maps = await db.query(
      "consultas",
      where: "pet_id = ?",
      whereArgs: [petId],
      orderBy: "data_hora ASC", //ordena por data e hora
    );
    //Converte a map para obj
    return maps.map((e) => Consulta.fromMap(e)).toList();
  }

  Future<int> deleteConsultas(int id) async{
    final db = await database;
    //delete pelo ID
    return await db.delete("consulta", where: "id = ?", whereArgs: [id]);
  }
}