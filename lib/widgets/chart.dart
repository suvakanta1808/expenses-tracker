import 'package:expenses_tracker/providers/expenses.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  List<List<double>> getDataOfPastSevenDays(BuildContext context) {
    final expList = Provider.of<Expenses>(context).expenses;
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

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        maxY: 1000,
        barTouchData: BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        barGroups: getDataOfPastSevenDays(context)
            .map(
              (ex) => BarChartGroupData(
                x: ex[0].toInt(),
                barRods: [
                  BarChartRodData(
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      colors: [Colors.white],
                      y: 1000,
                    ),
                    width: 15,
                    borderRadius: BorderRadius.circular(15),
                    y: ex[1],
                    colors: [
                      Colors.blue.shade300,
                      Colors.purple.shade100,
                      Colors.pink.shade100,
                      Colors.orange.shade300,
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
    );
  }
}
