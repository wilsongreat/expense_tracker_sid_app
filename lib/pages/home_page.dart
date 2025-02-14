import 'package:expense_tracker_sid_app/components/expense_summary.dart';
import 'package:expense_tracker_sid_app/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

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

  final expenseNameCtrl = TextEditingController();
  final expenseAmtCtrl = TextEditingController();
  void addNewExpenseWidget() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add New Expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: expenseNameCtrl,
                  decoration: InputDecoration(hintText: 'Expense Name'),
                ),
                TextField(
                    controller: expenseAmtCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Expense Amount')),
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () => saveExpense(),
                child: Text(
                  'save',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  void deleteExpense(ExpenseItem expense) {
    ref.watch(expenseDataViewModel).deleteExpense(expense);
  }

  void saveExpense() {
    if (expenseAmtCtrl.text.isNotEmpty && expenseNameCtrl.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
          amt: expenseAmtCtrl.text,
          date: DateTime.now(),
          name: expenseNameCtrl.text);
      ref.watch(expenseDataViewModel).addExpense(newExpense);
      Navigator.pop(context);
      clear();
    }
  }

  void clear() {
    expenseNameCtrl.clear();
    expenseAmtCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(expenseDataViewModel);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            ExpenseSummary(startOfWeek: provider.startofWeekDate()),
            SizedBox(
              height: 20,
            ),
            Text(
              'Weeks Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            provider.allExpenseList.isEmpty
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    Center(
                        child: Text('Add an expenses'),
                      ),
                    SizedBox(height: 10,),

                    GestureDetector(
                      onTap: () => addNewExpenseWidget(),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.allExpenseList.length,
                    itemBuilder: (context, index) {
                      final expense = provider.allExpenseList[index];
                      return ExpenseTile(
                        name: expense.name,
                        date: expense.date,
                        amt: '\$${expense.amt}',
                        deleteAction: (context) => deleteExpense(expense),
                      );
                    }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewExpenseWidget();
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
