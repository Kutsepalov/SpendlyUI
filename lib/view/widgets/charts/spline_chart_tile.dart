import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendly_ui/core/clients/dashboard_client.dart';
import 'package:spendly_ui/models/chart/chart_point.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide ChartPoint;

class SplineChartTile extends StatefulWidget {
  const SplineChartTile({super.key});

  @override
  State<SplineChartTile> createState() => _SplineChartTileState();
}

class _SplineChartTileState extends State<SplineChartTile> {
  var chartData = DashboardClient().getDashboardData().balanceTrendChartPoints;

  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        lineDashArray: const <double>[5, 5],
        activationMode: ActivationMode.singleTap,
        shouldAlwaysShow: true,
        enable: true,
        tooltipSettings: InteractiveTooltip(
          borderWidth: 3,
          borderColor: Colors.blue.shade100,
          color: Colors.white,
          textStyle: const TextStyle(color: Colors.black),
        ));
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
                    'Balance Trend',
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
                          'TODAY',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        Text(
                          format('₴', 16494.87),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'vs past period',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        Text(
                          '+60%',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SfCartesianChart(
              margin: EdgeInsets.zero,
              trackballBehavior: _trackballBehavior,
              primaryYAxis: NumericAxis(
                  desiredIntervals: 2,
                  majorGridLines: const MajorGridLines(
                      width: 1, color: Colors.grey, dashArray: <double>[5, 5]),
                  numberFormat: NumberFormat.compactCurrency(symbol: '₴'),
                  plotBands: <PlotBand>[
                    PlotBand(
                      isVisible: true,
                      start: 0,
                      end: 0,
                      borderWidth: 1,
                      borderColor: Colors.grey.shade600,
                    )
                  ]),
              primaryXAxis: DateTimeAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  minorGridLines: const MinorGridLines(width: 0),
                  dateFormat: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)),
              series: <ChartSeries>[
                SplineAreaSeries<ChartPoint, DateTime>(
                    trendlines: <Trendline>[
                      Trendline(
                          name: 'Trend',
                          type: TrendlineType.polynomial,
                          color: Colors.blue,
                          width: 1)
                    ],
                    borderWidth: 2,
                    borderColor: Colors.blue,
                    color: const Color.fromRGBO(33, 150, 243, 0.1),
                    dataSource: chartData,
                    xValueMapper: (ChartPoint data, _) => data.x,
                    yValueMapper: (ChartPoint data, _) => data.y),
              ])
        ],
      ),
    );
  }
}
