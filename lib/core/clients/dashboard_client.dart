import 'package:flutter/material.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/models/chart/chart_point.dart';
import 'package:spendly_ui/models/dashboard_dto.dart';

class DashboardClient {
  DashboardDto getDashboardData() {
    return DashboardDto(
      accounts: <Account>[],
      expenseStructurePoints: <ChartPoint>[
        ChartPoint(null, null, color: Colors.amber)
      ],
      balanceTrendChartPoints: <ChartPoint>[
        ChartPoint(DateTime.parse('2023-01-01'), 1300),
        ChartPoint(DateTime.parse('2023-01-10'), 1600),
        ChartPoint(DateTime.parse('2023-01-20'), 800),
        ChartPoint(DateTime.parse('2023-01-30'), 0),
        ChartPoint(DateTime.parse('2023-02-01'), -1500),
        ChartPoint(DateTime.parse('2023-02-10'), -3800),
        ChartPoint(DateTime.parse('2023-02-20'), -1400),
        ChartPoint(DateTime.parse('2023-02-28'), -500),
        ChartPoint(DateTime.parse('2023-03-01'), -1000),
        ChartPoint(DateTime.parse('2023-03-10'), -1700),
        ChartPoint(DateTime.parse('2023-03-20'), -2700),
        ChartPoint(DateTime.parse('2023-03-30'), -1500),
        ChartPoint(DateTime.parse('2023-04-01'), -900),
        ChartPoint(DateTime.parse('2023-04-10'), -900),
        ChartPoint(DateTime.parse('2023-04-20'), -600),
        ChartPoint(DateTime.parse('2023-04-30'), -200),
        ChartPoint(DateTime.parse('2023-05-01'), 100),
        ChartPoint(DateTime.parse('2023-05-10'), 400),
        ChartPoint(DateTime.parse('2023-05-20'), 1000),
        ChartPoint(DateTime.parse('2023-05-30'), 1000),
        ChartPoint(DateTime.parse('2023-06-01'), 900),
        ChartPoint(DateTime.parse('2023-06-10'), 800),
        ChartPoint(DateTime.parse('2023-06-20'), 1100),
        ChartPoint(DateTime.parse('2023-06-30'), 1300),
        ChartPoint(DateTime.parse('2023-07-01'), 1600),
        ChartPoint(DateTime.parse('2023-07-10'), 1700),
        ChartPoint(DateTime.parse('2023-07-20'), 1700),
        ChartPoint(DateTime.parse('2023-07-30'), 1600),
        ChartPoint(DateTime.parse('2023-08-01'), 1200),
        ChartPoint(DateTime.parse('2023-08-10'), 800),
        ChartPoint(DateTime.parse('2023-08-20'), 1400),
        ChartPoint(DateTime.parse('2023-08-30'), 1800),
        ChartPoint(DateTime.parse('2023-09-01'), 1500),
        ChartPoint(DateTime.parse('2023-09-10'), 1100),
        ChartPoint(DateTime.parse('2023-09-20'), 800),
        ChartPoint(DateTime.parse('2023-09-30'), 800),
        ChartPoint(DateTime.parse('2023-10-01'), 1400),
        ChartPoint(DateTime.parse('2023-10-10'), 1600),
        ChartPoint(DateTime.parse('2023-10-20'), 1700),
        ChartPoint(DateTime.parse('2023-10-30'), 1400),
        ChartPoint(DateTime.parse('2023-11-01'), 2000),
        ChartPoint(DateTime.parse('2023-11-10'), 2100),
        ChartPoint(DateTime.parse('2023-11-20'), 2400),
        ChartPoint(DateTime.parse('2023-11-30'), 2600),
        ChartPoint(DateTime.parse('2023-12-01'), 3000),
        ChartPoint(DateTime.parse('2023-12-10'), 3500),
        ChartPoint(DateTime.parse('2023-12-20'), 3300),
        ChartPoint(DateTime.parse('2023-12-30'), 3800),
        ChartPoint(DateTime.parse('2024-01-01'), null),
        ChartPoint(DateTime.parse('2024-01-10'), null),
        ChartPoint(DateTime.parse('2024-01-20'), null),
        ChartPoint(DateTime.parse('2024-01-30'), null),
        ChartPoint(DateTime.parse('2024-02-01'), null),
        ChartPoint(DateTime.parse('2024-02-10'), null),
        ChartPoint(DateTime.parse('2024-02-20'), null),
        ChartPoint(DateTime.parse('2024-02-28'), null),
      ],
      periodToPeriodComprasionChartData: PeriodToPeriodComprasionChartData(
        currentPeriodPoints: <ChartPoint>[
          ChartPoint('Dec 1', 3000),
          ChartPoint('Dec 10', 3500),
          ChartPoint('Dec 20', null),
          ChartPoint('Dec 30', null),
        ],
        previosPeriodPoints: <ChartPoint>[
          ChartPoint('Dec 1', 1000),
          ChartPoint('Dec 10', 1500),
          ChartPoint('Dec 20', 2300),
          ChartPoint('Dec 30', 2800),
        ],
        sameLastYearPeriodPoints: <ChartPoint>[
          ChartPoint('Dec 1', 1200),
          ChartPoint('Dec 10', 900),
          ChartPoint('Dec 20', 1300),
          ChartPoint('Dec 30', 500),
        ],
      ),
    );
  }
}
