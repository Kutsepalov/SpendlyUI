import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendly_ui/core/clients/dashboard_client.dart';
import 'package:spendly_ui/models/chart/chart_point.dart';
import 'package:spendly_ui/models/dashboard_dto.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide ChartPoint;

class PeriodToPeriodComprasionChartTile extends StatefulWidget {
  const PeriodToPeriodComprasionChartTile({super.key});

  @override
  State<PeriodToPeriodComprasionChartTile> createState() =>
      _PeriodToPeriodComprasionChartTileState();
}

class _PeriodToPeriodComprasionChartTileState
    extends State<PeriodToPeriodComprasionChartTile> {
  PeriodToPeriodComprasionChartData chartData =
      DashboardClient().getDashboardData().periodToPeriodComprasionChartData;

  static const List<Widget> types = <Widget>[
    Text('Cash flow'),
    Text('Expenses'),
    Text('Income')
  ];
  final List<bool> _selectedType = <bool>[true, false, false];
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        lineDashArray: const <double>[5, 5],
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        activationMode: ActivationMode.singleTap,
        shouldAlwaysShow: true,
        enable: true,
        tooltipSettings: const InteractiveTooltip(
          color: Colors.white,
          textStyle: TextStyle(
            color: Colors.black,
          ),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tile(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                'Period to Period Comprasion',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'THIS MONTH',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                Text(
                  format('₴', 3152.21),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _selectedType.length; i++) {
                          _selectedType[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.blue,
                    selectedColor: Colors.white,
                    fillColor: Colors.blue,
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _selectedType,
                    children: types,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SfCartesianChart(
          legend: Legend(
            position: LegendPosition.bottom,
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          margin: EdgeInsets.zero,
          trackballBehavior: _trackballBehavior,
          primaryYAxis: NumericAxis(
            desiredIntervals: 4,
            majorGridLines: const MajorGridLines(
              width: 1,
              color: Colors.grey,
              dashArray: <double>[5, 5],
            ),
            numberFormat: NumberFormat.compactCurrency(symbol: '₴'),
          ),
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            crossesAt: 0,
            majorGridLines: const MajorGridLines(width: 0),
            minorGridLines: const MinorGridLines(width: 0),
          ),
          series: <ChartSeries>[
            SplineAreaSeries<ChartPoint, String>(
              name: 'Current period',
              borderWidth: 2,
              borderColor: Colors.blue,
              color: const Color.fromRGBO(33, 150, 243, 0.1),
              dataSource: chartData.currentPeriodPoints,
              xValueMapper: (ChartPoint data, _) => data.x,
              yValueMapper: (ChartPoint data, _) => data.y,
            ),
            SplineSeries<ChartPoint, String>(
              color: Colors.pink,
              name: 'Previos period',
              dataSource: chartData.previosPeriodPoints,
              xValueMapper: (ChartPoint data, _) => data.x,
              yValueMapper: (ChartPoint data, _) => data.y,
            ),
            SplineSeries<ChartPoint, String>(
              color: Colors.orange,
              name: 'Same period last year',
              dataSource: chartData.sameLastYearPeriodPoints,
              xValueMapper: (ChartPoint data, _) => data.x,
              yValueMapper: (ChartPoint data, _) => data.y,
            ),
          ]),
    ]));
  }
}
