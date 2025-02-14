import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amt;
  final DateTime date;
  void Function(BuildContext)? deleteAction;
   ExpenseTile(
      {super.key, required this.name, required this.amt, required this.date, required this.deleteAction});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: true,
      endActionPane: ActionPane(motion: StretchMotion(), children: [
         SlidableAction(onPressed: deleteAction,icon: Icons.delete_forever_outlined,backgroundColor: Colors.red,)
      ]),
      child: ListTile(
        title: Text(name),
        subtitle: Text('${date.day}/${date.month}/${date.year}'),
        trailing: Text(amt),
      ),
    );
  }
}
