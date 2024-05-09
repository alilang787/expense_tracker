import 'package:flutter/material.dart';
import 'package:expense_tracker/expense_tracker.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

final kColorSchemeDark =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 14, 34, 15));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) => );
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
            color: kColorScheme.onPrimaryContainer,
            foregroundColor: Colors.white),
      ),
      home: ExpenseTracker(),
    );
  }
}
