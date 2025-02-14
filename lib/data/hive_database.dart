import 'package:expense_tracker_sid_app/data/expense_data.dart';
import 'package:hive/hive.dart';

class HiveDataBase{
  final _myBox = Hive.box('expense_database1');

  void saveData(List<ExpenseItem> allExpenses){

    List<List<dynamic>> allExpensesFormatted = [];

    for(var expense in allExpenses){
      List<dynamic> expenseFormat = [
        expense.name,
        expense.amt,
        expense.date,
      ];
      allExpensesFormatted.add(expenseFormat);
    }
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  List<ExpenseItem> readExpensesData(){
     List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
     List<ExpenseItem> allExpenses = [];

     for(int i =0; i < savedExpenses.length; i++){
       String name  = savedExpenses[i][0];
       String amt  = savedExpenses[i][1];
       DateTime date  = savedExpenses[i][2];

       ExpenseItem expense = ExpenseItem(amt: amt, date: date, name: name);
       allExpenses.add(expense);
     }
     return allExpenses;
  }
}