import 'package:cash/utils/navigation/navigation.dart';
import 'package:cash/utils/navigation/project_router.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      navigatorKey: Navigation.navigatorKey,
      initialRoute: Routes.accounts.path,
      onGenerateRoute: ProjectRouter.generateRoute,
      title: 'Cash App',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }
}
