import 'dart:math';

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

  IconData getIcon(String st) {
    var title = st.toLowerCase();
    if (title.contains('food'))
      return Icons.fastfood;
    else if (title.contains('book') || title.contains('books'))
      return Icons.book;
    else if (title.contains('shopping'))
      return Icons.shopping_cart;
    else if (title.contains('shoes') || title.contains('shoe'))
      return Icons.shopping_bag;
    else if (title.contains('house rent') || title.contains('rental'))
      return Icons.home;
    else if (title.contains('car rental'))
      return Icons.car_rental;
    else if (title.contains('car repair'))
      return Icons.car_repair;
    else if (title.contains('gift'))
      return Icons.gif_outlined;
    else
      return Icons.star;
  }

  var rnd = new Random();

  Color getColor(int i) {
    if (i == 1)
      return Colors.blue.shade100;
    else if (i == 2)
      return Colors.purple.shade100;
    else if (i == 3)
      return Colors.pink.shade100;
    else if (i == 4)
      return Colors.orange.shade100;
    else if (i == 5)
      return Colors.purple.shade200;
    else
      return Colors.green.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        getIcon(title),
        size: 25,
      )
          .circle(
              radius: MediaQuery.of(context).size.width * 0.13,
              backgroundColor: getColor(rnd.nextInt(5)))
          .p12(),
      [title.text.size(15).make().p4(), description.text.size(11).make().p4()]
          .vStack(crossAlignment: CrossAxisAlignment.start)
          .box
          .make()
          .w56(context),
      '\$$amount'.text.makeCentered().box.alignCenter.make().w15(context),
    ]
        .hStack()
        .p12()
        .card
        .elevation(5)
        .customRounded(BorderRadius.circular(15))
        .make();
  }
}
