import 'package:cash/screens/accounts/accounts_screen.dart';
import 'package:cash/screens/add_new_transaction/add_new_transaction_screen.dart';
import 'package:cash/screens/cash_screen/cash_screen.dart';
import 'package:cash/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

const _cash = '/cash';
const _accounts = '/accounts';
const _settings = '/settings';
const _addNewTransaction = '/addNewTransaction';

class ProjectRouter {
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _cash:
        return _buildRoute(settings, CashScreen());
      case _accounts:
        return _buildRoute(settings, AccountsScreen());
      case _settings:
        return _buildRoute(settings, SettingsScreen());
      case _addNewTransaction:
        return _buildRoute(settings, AddNewTransactionScreen());
    }
    return null;
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(settings: settings, builder: (_) => screen);
  }
}

enum Routes {
  cash,
  accounts,
  settings,
  addNewTransaction,
}

extension RoutNames on Routes {
  String get path {
    switch (this) {
      case Routes.cash:
        return _cash;
      case Routes.accounts:
        return _accounts;
      case Routes.settings:
        return _settings;
      case Routes.addNewTransaction:
        return _addNewTransaction;
    }
  }
}
