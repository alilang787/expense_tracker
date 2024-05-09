import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ShowChart extends StatelessWidget {
  ShowChart({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final List<Bucket> buckets =
        Category.values.map((e) => Bucket.getBucket(expenses, e)).toList();
    final double height = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      height: isPortrait ? height * 0.25 : double.infinity,
      child: Card(
        color: Colors.deepPurple.shade100.withOpacity(0.1),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.deepPurple.shade100.withOpacity(0.2),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buckets
                .map((bucket) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Expanded(
                              child: FractionallySizedBox(
                                alignment: Alignment.bottomCenter,
                                heightFactor: bucket.hfactor,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: color_getter[
                                          bucket.selected_category],
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12))),
                                ),
                              ),
                            ),
                            Divider(
                              color: color_getter[bucket.selected_category],
                              thickness: 4,
                            ),
                            // SizedBox(height: 6),
                            Icon(
                              icon_getter[bucket.selected_category],
                              color: color_getter[bucket.selected_category],
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
