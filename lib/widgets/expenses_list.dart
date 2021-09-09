import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/providers/expenses.dart';
import 'package:expenses_tracker/widgets/expense_list_item.dart';
import 'package:expenses_tracker/widgets/no_data_widget.dart';
import '../helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var _loader =
    //     Provider.of<DBHelper>(context, listen: false).getDataFromtable();
    return FutureBuilder(
        future: Provider.of<Expenses>(context).expenses,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator().box.makeCentered();
          }
          final expenseList = dataSnapshot.data as List<Expense>;
          return expenseList.length == 0
              ? NoDataWidget()
              : ListView.builder(
                  itemBuilder: (ctx, i) => ExpenseListItem(
                    id: expenseList[i].id,
                    title: expenseList[i].title,
                    description: expenseList[i].description,
                    amount: expenseList[i].amount,
                    date: expenseList[i].date,
                  ),
                  itemCount: expenseList.length,
                ).box.make().h(MediaQuery.of(context).size.height * 0.52);
        });
  }
}
