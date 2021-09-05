import 'package:expenses_tracker/widgets/chart.dart';
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
            'Hello Robin!!'
                .text
                .size(20)
                .bold
                .make()
                .pOnly(top: 40, left: 25, bottom: 10),
            Chart()
                .p24()
                .box
                .roundedLg
                .border(width: 2, color: Colors.yellow)
                .make()
                .p12()
                .wFull(context)
                .h32(context),
          ]
              .vStack(crossAlignment: CrossAxisAlignment.start)
              .box
              .customRounded(BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ))
              .linearGradient([Vx.blue700, Vx.blue400],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter)
              .make()
              .p0()
              .h48(context)
              .wFull(context),
        ].vStack().box.make().hFull(context).wFull(context),
        floatingActionButton: FloatingActionButton(
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
