import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnatChartTile extends StatefulWidget {
  const DoughnatChartTile({super.key});

  @override
  State<DoughnatChartTile> createState() => _DoughnatChartTileState();
}

class _DoughnatChartTileState extends State<DoughnatChartTile> {
  final data = [
    _ChartData('Food & Drinks', 25, pointColor: Colors.red),
    _ChartData('Life & Entertaiment', 38, pointColor: Colors.green),
    _ChartData('Housing', 34, pointColor: Colors.orange),
    _ChartData('Investments', 52, pointColor: Colors.pink)
  ];

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expenses structure',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SfCircularChart(
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              annotations: [
                CircularChartAnnotation(
                    widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        'ALL',
                      ),
                      Text(
                        format('₴', 2781),
                      )
                    ])),
              ],
              series: [
                DoughnutSeries<_ChartData, String>(
                    animationDuration: 500,
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    pointColorMapper: (_ChartData data, _) => data.pointColor,
                    name: '')
              ]),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, {this.pointColor});

  final String x;
  final double y;
  Color? pointColor;
}
