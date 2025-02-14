import 'package:expense_tracker_sid_app/data/hive_database.dart';
import 'package:expense_tracker_sid_app/helper/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final expenseDataViewModel = ChangeNotifierProvider((_) => ExpenseData());

class ExpenseData extends ChangeNotifier{
  List<ExpenseItem> allExpenseList = [];

  List<ExpenseItem> getAllExpenses(){
    return allExpenseList;
  }

  final db = HiveDataBase();
  void prepareData(){
    if(db.readExpensesData().isNotEmpty){
      allExpenseList =  db.readExpensesData();
    }
  }
  void addExpense(ExpenseItem newExpense){
    allExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(allExpenseList);
  }

  void deleteExpense(ExpenseItem expense){
    allExpenseList.remove(expense);
    notifyListeners();
    db.saveData(allExpenseList);

  }

  String getDayName(DateTime dateTIme){
    switch(dateTIme.weekday){
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startofWeekDate(){
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    for(int i = 0; i <7; i++){
      if(getDayName(today.subtract(Duration(days:i)))== 'Sun'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyTracker(){
    Map<String, double> dailyExpenseSummary = {

    };
    for(var expense in allExpenseList){
      String date = convertTimeDateTimeToString(expense.date);
      double amount = double.parse(expense.amt);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount  = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }

}



class ExpenseItem{
  final String name;
  final String amt;
  final DateTime date;

  const ExpenseItem({required this.amt,required this.date, required this.name,});
}