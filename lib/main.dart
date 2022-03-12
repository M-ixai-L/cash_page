import 'package:cash/screens/accounts/accounts_screen.dart';
import 'package:cash/screens/accounts/settings_screen.dart';
import 'package:cash/screens/cash_screen/cash_new_screen.dart';
import 'package:cash/screens/cash_screen/cash_screen.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      color: Colors.white,
      routes: {
        '/cashScreen': (context) => CashScreen(),
        '/addNewCashScreen': (context) => CashNewScreen(),
        '/accountsScreen': (context) => AccountsScreen(),
        '/settingsScreen': (context) => SettingsScreen(),
      },
      initialRoute: '/accountsScreen',
      title: 'Cash App',
      theme: ThemeData(
        backgroundColor: Colors.white,

      ),

    );
  }
}
