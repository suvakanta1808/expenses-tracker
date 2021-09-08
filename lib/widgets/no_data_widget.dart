import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.storage_rounded,
        color: Colors.white,
        size: MediaQuery.of(context).size.width * 0.2,
      ),
      'No record found!!'.text.white.make()
    ]
        .vStack()
        .box
        .makeCentered()
        .circle(radius: MediaQuery.of(context).size.width * 0.5)
        .p64();
  }
}
