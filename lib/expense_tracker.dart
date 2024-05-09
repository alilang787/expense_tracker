import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/bottom_overlay.dart';
import 'package:expense_tracker/widgets/chart.dart';

class ExpenseTracker extends StatefulWidget {
  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<Expense> expenses = [
    Expense(
      title: 'Shoes',
      amount: 33.4,
      date: DateTime.now(),
      category: Category.Fashion,
    ),
    Expense(
      title: 'Movie',
      amount: 16.55,
      date: DateTime.now(),
      category: Category.Leisure,
    ),
    Expense(
      title: 'Atlanta',
      amount: 19,
      date: DateTime.now(),
      category: Category.Travel,
    ),
    Expense(
      title: 'Burger',
      amount: 22,
      date: DateTime.now(),
      category: Category.Food,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return BottomOverlay(
                      addExpnese: _addExpnese,
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: isPortrait
            ? Column(
                children: [
                  ShowChart(expenses: expenses),
                  SizedBox(height: 12),
                  ShowExpenses(),
                ],
              )
            : Row(children: [
                Expanded(child: ShowChart(expenses: expenses)),
                SizedBox(height: 12),
                ShowExpenses(),
              ]));
  }

  //         >>>>>>>>>>  W I D G E T S >>>>>>>>>>>
  Widget ShowExpenses() {
    return Expanded(
      child: expenses.isEmpty
          ? Center(child: Text('No expense found, try to add some!'))
          : ListView.builder(
              // shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 16),
              itemCount: expenses.length,
              itemBuilder: (context, i) {
                final Expense ex = expenses[i];

                //     Dismiss ...............
                return Dismissible(
                  key: ValueKey(ex.id),
                  background: Text('Remove'),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _delExpense(ex);
                  },
                  child: Card(
                    color: color_getter[ex.category]!.shade100.withOpacity(0.2),
                    elevation: 8,
                    surfaceTintColor: Colors.transparent,
                    shadowColor:
                        color_getter[ex.category]!.shade100.withOpacity(0.2),
                    margin: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ex.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '  ${ex.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                icon_getter[ex.category],
                                color: color_getter[ex.category],
                              ),
                              SizedBox(width: 6),
                              Text('${ex.date_formatter}')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  //         >>>>>>>>>>  M E TH O D S    >>>>>>>>>>
  void _addExpnese(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _delExpense(Expense ex) {
    final index = expenses.indexOf(ex);
    setState(() {
      expenses.removeAt(index);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Item deleted successfully'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenses.insert(index, ex);
            });
          }),
    ));
  }
}
