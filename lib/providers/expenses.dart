import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class Expenses with ChangeNotifier {
  List<Expense> _expensesList = [
    Expense(
      title: 'Shopping',
      description: 'T-Shirt,Jeans,snacks,etc.',
      date: DateTime(2021, 09, 05),
      amount: 500,
    ),
    Expense(
      title: 'Books',
      description: 'Algebra Book,Chemistry by G.N Mathur,etc.',
      date: DateTime(2021, 09, 04),
      amount: 100,
    ),
    Expense(
      title: 'Rent',
      description: 'House rent of August,2021',
      date: DateTime(2021, 09, 03),
      amount: 640,
    ),
    Expense(
      title: 'Food',
      description: 'had lunch at Zaikia International restaurant',
      date: DateTime(2021, 09, 02),
      amount: 130,
    ),
    Expense(
      title: 'Shopping',
      description: 'Grocery fow this month',
      date: DateTime(2021, 09, 01),
      amount: 270,
    ),
    Expense(
      title: 'Shoes',
      description: 'new Adidas shoes',
      date: DateTime(2021, 08, 31),
      amount: 830,
    ),
    Expense(
      title: 'Shopping',
      description: 'T-Shirt,Jeans,snacks,etc.',
      date: DateTime(2021, 08, 30),
      amount: 500,
    ),
  ];

  List<Expense> get expenses {
    return [..._expensesList];
  }

  void addToExpensesList(Expense exp) {
    _expensesList.add(exp);
    notifyListeners();
  }
}
