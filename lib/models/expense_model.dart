import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get date_formatter {
    return formatter.format(date);
  }
}

class Bucket {
  final Category selected_category;
  final double hfactor;
  Bucket(this.selected_category, this.hfactor);
  Bucket.getBucket(List<Expense> expenses, this.selected_category)
      : hfactor = expenses.isEmpty
            ? 0.0
            : expenses
                    .where((expense) => expense.category == selected_category)
                    .fold(0.0, (pValue, ex) => pValue + ex.amount) /
                expenses.fold(0.0, (pValue, ex) => pValue + ex.amount);
}

enum Category { Travel, Food, Fashion, Leisure }

const icon_getter = {
  Category.Travel: Icons.flight_takeoff,
  Category.Fashion: Icons.style,
  Category.Food: Icons.lunch_dining,
  Category.Leisure: Icons.movie
};
const color_getter = {
  Category.Travel: Colors.red,
  Category.Fashion: Colors.blue,
  Category.Food: Colors.green,
  Category.Leisure: Colors.amber,
};
