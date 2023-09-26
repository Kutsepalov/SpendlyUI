import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/models/chart/chart_point.dart';

class DashboardDto {
  final List<Account> accounts;
  final List<ChartPoint> balanceTrendChartPoints;
  final List<ChartPoint> expenseStructurePoints;
  final PeriodToPeriodComprasionChartData periodToPeriodComprasionChartData;

  DashboardDto({
    required this.balanceTrendChartPoints,
    required this.expenseStructurePoints,
    required this.accounts,
    required this.periodToPeriodComprasionChartData,
  });
}

class PeriodToPeriodComprasionChartData {
  final List<ChartPoint> currentPeriodPoints;
  final List<ChartPoint> previosPeriodPoints;
  final List<ChartPoint> sameLastYearPeriodPoints;

  PeriodToPeriodComprasionChartData({
    required this.currentPeriodPoints,
    required this.previosPeriodPoints,
    required this.sameLastYearPeriodPoints,
  });
}
