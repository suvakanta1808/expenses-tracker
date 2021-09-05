import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpenseListItem extends StatelessWidget {
  final String title;
  final String description;
  final double amount;

  ExpenseListItem({
    required this.title,
    required this.description,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return [
      Icon(Icons.food_bank).p12(),
      [title.text.size(15).make().p4(), description.text.size(11).make().p4()]
          .vStack(crossAlignment: CrossAxisAlignment.start)
          .box
          .make()
          .w60(context),
      '-\$$amount'.text.makeCentered().box.alignCenter.make().w10(context),
    ].hStack().p12().card.make().pSymmetric(
          h: 4,
          v: 12,
        );
  }
}
