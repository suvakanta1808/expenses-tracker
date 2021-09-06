import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/providers/expenses.dart';
import 'package:expenses_tracker/widgets/expense_list_item.dart';
import '../helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<DBHelper>(context, listen: false).getDataFromtable();
    final expenseList =
        Provider.of<DBHelper>(context, listen: false).expenseList;
    return expenseList.length == 0
        ? 'No records found.Start adding some..'.text.makeCentered()
        : ListView.builder(
            itemBuilder: (ctx, i) => ExpenseListItem(
              title: expenseList[i].title,
              description: expenseList[i].description,
              amount: expenseList[i].amount,
            ),
            itemCount: expenseList.length,
          ).box.make().h(MediaQuery.of(context).size.height * 0.55);
  }
}
