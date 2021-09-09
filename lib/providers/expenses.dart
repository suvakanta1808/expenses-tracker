import 'package:expenses_tracker/helpers/db_helper.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class Expenses with ChangeNotifier {
  Future<List<Expense>> get expenses {
    final list = DBHelper().getDataFromtable();
    return list;
  }

  Future<void> addToExpensesList(Expense exp) async {
    await DBHelper().insertIntoExpensesTable(exp);
    notifyListeners();
  }

  Future<void> deleteData(String id) async {
    await DBHelper().deleteEntryFromtable(id);
    notifyListeners();
  }
}
