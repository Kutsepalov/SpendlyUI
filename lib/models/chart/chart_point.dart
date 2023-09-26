import 'package:flutter/animation.dart';
import 'package:spendly_ui/models/chart/base_chart_point.dart';

class ChartPoint extends BaseChartPoint {
  ChartPoint(x, double? y, {this.color}) : super(x, y);
  Color? color;
}
