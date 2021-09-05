import 'package:expenses_tracker/providers/expenses.dart';
import 'package:expenses_tracker/widgets/expense_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<Expenses>(context).expenses;
    return list.length == 0
        ? 'No records found.Start adding some..'.text.makeCentered()
        : ListView.builder(
            itemBuilder: (ctx, i) => ExpenseListItem(
              title: list[i].title,
              description: list[i].description,
              amount: list[i].amount,
            ),
            itemCount: list.length,
          ).box.make().h(MediaQuery.of(context).size.height * 0.52);
  }
}
