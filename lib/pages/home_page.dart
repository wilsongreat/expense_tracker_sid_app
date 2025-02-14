import 'package:expense_tracker_sid_app/components/expense_summary.dart';
import 'package:expense_tracker_sid_app/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/expense_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(expenseDataViewModel).prepareData();
  }
  final expenseNameCtrl =TextEditingController();
  final expenseAmtCtrl =TextEditingController();
  void addNewExpenseWidget(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: expenseNameCtrl,
              decoration: InputDecoration(
                hintText: 'Expense Name'
              ),

            ),
            TextField(
              controller: expenseAmtCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Expense Amount'
                )
            ),
          ],
        ),
        actions: [
          MaterialButton(onPressed: () => saveExpense(), child: Text('save'),),
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel'),),
        ],
      );
    });
  }
  void deleteExpense(ExpenseItem expense){
    ref.watch(expenseDataViewModel).deleteExpense(expense);
  }

  void saveExpense(){
    if(expenseAmtCtrl.text.isNotEmpty && expenseNameCtrl.text.isNotEmpty){
      ExpenseItem  newExpense = ExpenseItem(amt: expenseAmtCtrl.text, date: DateTime.now(), name: expenseNameCtrl.text);
      ref.watch(expenseDataViewModel).addExpense(newExpense);
      Navigator.pop(context);
      clear();
    }

  }

  void clear(){
    expenseNameCtrl.clear();
    expenseAmtCtrl.clear();
  }
  @override
  Widget build(BuildContext context) {
    final provider = ref.read(expenseDataViewModel);
    return  Scaffold(
      body: ListView(
        children: [
          ExpenseSummary(startOfWeek: provider.startofWeekDate()),
          SizedBox(height: 20,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemCount: provider.allExpenseList.length,
              itemBuilder:(context, index){
                final expense = provider.allExpenseList[index];
                return ExpenseTile(name: expense.name,date:expense.date,amt: '\$${expense.amt}',deleteAction:(context) => deleteExpense(expense),);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        addNewExpenseWidget();
      },
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),),
    );
  }
}
