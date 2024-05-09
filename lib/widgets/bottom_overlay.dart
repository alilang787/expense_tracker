import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class BottomOverlay extends StatefulWidget {
  final Function addExpnese;
  BottomOverlay({required this.addExpnese});

  @override
  State<BottomOverlay> createState() => _BottomOverlayState();
}

class _BottomOverlayState extends State<BottomOverlay> {
  final title_controller = TextEditingController();
  final amount_controller = TextEditingController();
  DateTime date = DateTime.now();
  Category category = Category.Travel;

  @override
  void dispose() {
    title_controller.dispose();
    amount_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keypadHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 0, 16, keypadHeight + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //    Title Text Field .........
            TextField(
              controller: title_controller,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                //    .... Amount Text Field
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    controller: amount_controller,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      label: Text('Amount'),
                      prefix: Text('\$ '),
                    ),
                  ),
                ),
                Spacer(),
                Text(formatter.format(date)),

                //  Date Picker ...............
                IconButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final picked_date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(date.year - 1, date.month, date.day),
                      lastDate: date,
                    );
                    if (picked_date == null) return;
                    setState(() {
                      date = picked_date;
                    });
                  },
                  icon: Icon(Icons.date_range),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                DropdownMenu(
                  onSelected: (value) {
                    if (value == null) return;
                    category = Category.values[value];
                  },
                  initialSelection: Category.Travel.index,
                  dropdownMenuEntries: Category.values.map((e) {
                    return DropdownMenuEntry(value: e.index, label: e.name);
                  }).toList(),
                  inputDecorationTheme:
                      InputDecorationTheme(enabledBorder: InputBorder.none),
                ),
                Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),

                //    Submit ................≤
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    final String title = title_controller.text.trim();
                    final double? amount =
                        double.tryParse(amount_controller.text);
                    if (title.isEmpty || amount == null) {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            title: Text('Input Error'),
                            content: Text(
                              'tilte and amount field cann\'t be invalid left empty! ',
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Okey'))
                            ],
                          );
                        },
                      );
                      return;
                    }
                    final Expense expense = Expense(
                      title: title,
                      amount: amount,
                      date: date,
                      category: category,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('expense added successfully'),
                      ),
                    );
                    Navigator.pop(context);
                    widget.addExpnese(expense);
                  },
                  child: Text('Submit'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
