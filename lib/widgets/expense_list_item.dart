import 'dart:math';

import 'package:expenses_tracker/providers/expenses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpenseListItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final double amount;

  ExpenseListItem({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
  });

  IconData getIcon(String st) {
    var title = st.toLowerCase();
    if (title.contains('restaurant'))
      return Icons.fastfood;
    else if (title.contains('hotel'))
      return Icons.hotel;
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
      return Icons.card_giftcard;
    else
      return Icons.new_releases;
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
      [
        title.text.size(17).make().p4(),
        'Date: ${date.toString().substring(0, 10)}'
            .text
            .size(11)
            .make()
            .pOnly(top: 1, left: 4),
        description.text.size(11).make().p4()
      ]
          .vStack(crossAlignment: CrossAxisAlignment.start)
          .box
          .make()
          .w(MediaQuery.of(context).size.width * 0.5),
      '💲$amount'
          .text
          .size(15)
          .makeCentered()
          .box
          .alignCenter
          .make()
          .w16(context),
    ]
        .hStack()
        .p12()
        .card
        .elevation(5)
        .customRounded(BorderRadius.circular(15))
        .make()
        .py1()
        .px8()
        .onLongPress(() {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          context: context,
          builder: (ctx) {
            return [
              'Do you want to delete this entry permanently?'
                  .text
                  .bold
                  .size(18)
                  .make()
                  .pOnly(
                      right: MediaQuery.of(context).size.width * 0.08, top: 20),
              [
                'Yes'
                    .text
                    .makeCentered()
                    .py12()
                    .px24()
                    .box
                    .roundedSM
                    .blue400
                    .make()
                    .p16()
                    .onTap(() async {
                  await Provider.of<Expenses>(context, listen: false)
                      .deleteData(id);
                  Navigator.of(ctx).pop();
                }),
                'No'
                    .text
                    .makeCentered()
                    .py12()
                    .px24()
                    .box
                    .roundedSM
                    .blue400
                    .make()
                    .p16()
                    .onTap(() {
                  Navigator.of(ctx).pop();
                }),
              ].hStack()
            ].vStack(crossAlignment: CrossAxisAlignment.end);
          });
    });
  }
}
