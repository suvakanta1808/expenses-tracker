import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class Expenses with ChangeNotifier {
  List<Expense> _expensesList = [];

  List<Expense> get expenses {
    return [..._expensesList];
  }

  void addToExpensesList(Expense exp) {
    _expensesList.add(exp);
    notifyListeners();
  }
}
