import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendly_ui/core/clients/dashboard_client.dart';
import 'package:spendly_ui/models/budget.dart';
import 'package:spendly_ui/models/chart/base_chart_point.dart';
import 'package:spendly_ui/models/chart/chart_point.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide ChartPoint;

class BarChartTile extends StatefulWidget {
  final List<Budget> budgets;
  const BarChartTile({super.key, required this.budgets});

  @override
  State<BarChartTile> createState() => _BarChartTileState();
}

class _BarChartTileState extends State<BarChartTile> {
  List<_ChartData> chartData = [];

  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    // _trackballBehavior = TrackballBehavior(
    //     tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    //     lineDashArray: const <double>[5, 5],
    //     activationMode: ActivationMode.singleTap,
    //     shouldAlwaysShow: true,
    //     enable: true,
    //     tooltipSettings: InteractiveTooltip(
    //       borderWidth: 3,
    //       borderColor: Colors.blue.shade100,
    //       color: Colors.white,
    //       textStyle: const TextStyle(color: Colors.black),
    //     ));
    chartData =
        widget.budgets.map((e) => _ChartData(e.name, e.plannedAmount)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15, right: 5, left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: const Text(
                    'Budget Bar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOTAL',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        Text(
                          format('₴', 2500),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis:
                  NumericAxis(minimum: 0, maximum: 1500, interval: 100),
              series: <ChartSeries<_ChartData, String>>[
                BarSeries<_ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: 'Gold',
                    color: Color.fromRGBO(104, 170, 224, 1))
              ])
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
