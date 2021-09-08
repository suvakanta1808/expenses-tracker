import 'package:expenses_tracker/helpers/db_helper.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class Expenses with ChangeNotifier {
  var maxLimit = 1000.00;

  updateLimit(double amount) {
    maxLimit = amount;
    notifyListeners();
  }

  Future<List<Expense>> get expenses {
    final list = DBHelper().getDataFromtable();
    return list;
  }

  Future<void> addToExpensesList(Expense exp) async {
    await DBHelper().insertIntoExpensesTable(exp);
    notifyListeners();
  }
}
