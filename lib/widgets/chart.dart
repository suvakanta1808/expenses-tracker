import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/providers/expenses.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  List<List<double>> getDataOfPastSevenDays(
      BuildContext context, List<Expense> expList) {
    final List<List<double>> barchartdata = [];

    final dataList = expList.where(
      (exp) => exp.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      ),
    );

    for (int i = 0; i < 7; i++) {
      var total = 0.0;
      var date = DateTime.now().subtract(Duration(days: i));

      dataList.forEach((exp) {
        if (exp.date.day == date.day &&
            exp.date.month == date.month &&
            exp.date.year == date.year) {
          total += exp.amount;
        }
      });
      barchartdata.add([double.parse(date.weekday.toString()), total]);
    }

    return barchartdata;
  }

  double calculateMaxLimit(List<Expense> expList) {
    var maxLimit = 1000.0;
    for (int i = 0; i < expList.length; i++) {
      maxLimit = expList[i].amount > maxLimit
          ? 1000.0 * ((expList[i].amount / 1000) + 1)
          : maxLimit;
    }

    return maxLimit;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Expenses>(context).expenses,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final dataList = dataSnapshot.data as List<Expense>;
          return BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              maxY: calculateMaxLimit(dataList),
              borderData: FlBorderData(show: false),
              barGroups: getDataOfPastSevenDays(context, dataList)
                  .map(
                    (ex) => BarChartGroupData(
                      barsSpace: 25,
                      x: ex[0].toInt(),
                      barRods: [
                        BarChartRodData(
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            colors: [Colors.white],
                            y: calculateMaxLimit(dataList),
                          ),
                          width: 15,
                          borderRadius: BorderRadius.circular(15),
                          y: ex[1],
                          colors: [
                            Colors.blue.shade300,
                            Colors.purple.shade200,
                            Colors.pink.shade200,
                            Colors.orange.shade300,
                            Colors.red.shade400
                          ],
                        ),
                      ],
                    ),
                  )
                  .toList(),
              titlesData: FlTitlesData(
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    margin: 15,
                    showTitles: true,
                    getTitles: (it) => days[it.toInt() - 1],
                  )),
            ),
            swapAnimationCurve: Curves.easeInOutSine,
            swapAnimationDuration: Duration(seconds: 2),
          );
        });
  }
}
