import 'package:expense_tracker_sid_app/data/expense_data.dart';
import 'package:expense_tracker_sid_app/feature/graph/bar_graph.dart';
import 'package:expense_tracker_sid_app/helper/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  double calcMax(ExpenseData val, String sunday, String monday, String tuesday,
      String wednesday, String thursday, String friday, String saturday) {
    double? max = 100;
    List<double> values = [
      val.calculateDailyTracker()[sunday] ?? 0,
      val.calculateDailyTracker()[monday] ?? 0,
      val.calculateDailyTracker()[tuesday] ?? 0,
      val.calculateDailyTracker()[wednesday] ?? 0,
      val.calculateDailyTracker()[thursday] ?? 0,
      val.calculateDailyTracker()[friday] ?? 0,
      val.calculateDailyTracker()[saturday] ?? 0,
    ];
    values.sort();
    max = values.first * 1.1;
    return max == 0 ? 100 : max;
  }

  String calcWeekTotal(ExpenseData val, String sunday, String monday, String tuesday,
      String wednesday, String thursday, String friday, String saturday) {
    List<double> values = [
      val.calculateDailyTracker()[sunday] ?? 0,
      val.calculateDailyTracker()[monday] ?? 0,
      val.calculateDailyTracker()[tuesday] ?? 0,
      val.calculateDailyTracker()[wednesday] ?? 0,
      val.calculateDailyTracker()[thursday] ?? 0,
      val.calculateDailyTracker()[friday] ?? 0,
      val.calculateDailyTracker()[saturday] ?? 0,
    ];

    double total = 0.0;
    for(int i = 0 ; i < values.length; i++){
      total += values[i];
    }
    return total.toStringAsFixed(2);

  }
  @override
  Widget build(BuildContext context) {
    String sunday =
        convertTimeDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String monday =
        convertTimeDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String tuesday =
        convertTimeDateTimeToString(startOfWeek.add(Duration(days: 2)));
    String wednesday =
        convertTimeDateTimeToString(startOfWeek.add(Duration(days: 3)));
    String thursday =
        convertTimeDateTimeToString(startOfWeek.add(Duration(days: 4)));
    String friday =
        convertTimeDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String saturday =
        convertTimeDateTimeToString(startOfWeek.add(Duration(days: 6)));
    return Consumer(builder: (context, ref, _) {
      final provider = ref.watch(expenseDataViewModel);
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Text('week total: ${calcWeekTotal(provider, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 200,
            child: BarGraph(
                maxY: calcMax(provider, sunday, monday, tuesday, wednesday,
                    thursday, friday, saturday),
                sunAmount: provider.calculateDailyTracker()[sunday] ?? 0,
                monAmount: provider.calculateDailyTracker()[monday] ?? 0,
                tueAmount: provider.calculateDailyTracker()[tuesday] ?? 0,
                wedAmount: provider.calculateDailyTracker()[wednesday] ?? 0,
                thurAmount: provider.calculateDailyTracker()[thursday] ?? 0,
                friAmount: provider.calculateDailyTracker()[friday] ?? 0,
                satAmount: provider.calculateDailyTracker()[saturday] ?? 0),
          ),
        ],
      );
    });
  }
}
