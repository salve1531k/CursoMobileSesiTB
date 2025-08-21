

import 'package:biblioteca_app/models/user_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UserControler {
 

  //métodos
  // Get dos usuarios
  Future<List<UserModel>> fetchAll() async{
    final list = await ApiService.getList("users?_sort=name");
    return list.map<UserModel>((item)=>UserModel.fromJson(item)).toList();
  }

  //Post -> Criar novo Usuário
  Future<UserModel> create(UserModel u) async{
    final created = await ApiService.post("users", u.toJson());
    // adiciona um Usuario e retorna o usuario com -> ID
    return UserModel.fromJson(created);
  }

  //Buscar um usuario
  Future<UserModel> fetchOne(String id) async{
    final user = await ApiService.getOne("users",id);
    // Retorna o Usuario Encontrado no Banco de Dados
    return UserModel.fromJson(user);
  }

  //Put -> Atualizar Usuario
  Future<UserModel> update(UserModel u) async{
    final update = await ApiService.put("users", u.toJson(), u.id!);
    //Retornaa o usuario Atualizado
    return UserModel.fromJson(update);
  }

  Future<void> delete(String id) async{
    await ApiService.delete("users", id);
    // Não há retorno, Usuário deletado com sucesso
  }


}