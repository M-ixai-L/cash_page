import 'package:flutter/material.dart';
import 'package:cash/cash_page.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash App',

      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: CashPage(),
    );
  }
}