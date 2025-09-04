import 'package:biblioteca_app/models/loans_models.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LoanController {
  Future<List<LoanModel>> fetchAll() async {
    final list = await ApiService.getList("loans?_sort=date");
    return list.map<LoanModel>((item) => LoanModel.fromMap(item)).toList();
  }

  Future<LoanModel> create(LoanModel loan) async {
    final created = await ApiService.post("loans", loan.toMap());
    return LoanModel.fromMap(created);
  }

  Future<LoanModel> update(LoanModel loan) async {
    final updated = await ApiService.put("loans", loan.toMap(), loan.id!);
    return LoanModel.fromMap(updated);
  }

  Future<void> delete(String id) async {
    await ApiService.delete("loans", id);
  }
}
