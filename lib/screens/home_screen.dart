import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: [
          [
            'Hello Friend 😉!'
                .text
                .size(20)
                .bold
                .make()
                .pOnly(top: 40, left: 25, bottom: 3),
            'Here\'s your expenses of past seven days..'
                .text
                .size(15)
                .make()
                .pOnly(left: 25, bottom: 10),
            Chart()
                .p24()
                .box
                .color(Colors.grey.shade300)
                .roundedSM
                .make()
                .p12()
                .wFull(context)
                .h32(context),
          ]
              .vStack(crossAlignment: CrossAxisAlignment.start)
              .box
              .make()
              .p0()
              .h(MediaQuery.of(context).size.height * 0.45)
              .wFull(context),
          ExpensesList().scrollVertical(),
        ].vStack().box.make().hFull(context).wFull(context),
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          onPressed: () {
            showModalBottomSheet(
              barrierColor: Colors.blue.withOpacity(0.8),
              context: context,
              builder: (ctx) => CollecingForm(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
