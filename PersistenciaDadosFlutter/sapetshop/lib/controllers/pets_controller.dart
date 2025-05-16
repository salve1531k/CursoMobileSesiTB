import 'package:sapetshop/database/db_helper.dart';
import 'package:sapetshop/models/pet.model.dart';

class PetsController {
  //atributo -> é conexão com DB
  final PetShopDBHelper _dbHelper = PetShopDBHelper();

  Future<int> addPet(Pet pet) async {
    //chama o método de inserir do DB
   return await _dbHelper.insertPet(pet);
  }

  Future<List<Pet>> fetchAllPets() async {
    //chama o método de listar do DB
    return await _dbHelper.getAllPets();
  }

  Future<Pet?> findPetById(int id) async {
    //chama o método de listar do DB
    return await _dbHelper.getPetById(id);
  }

  Future<int> deletePet(int id) async {
    //chama o método de atualizar do DB
    return await _dbHelper.deletePet(id);
  }
}