import 'package:cash/utils/navigation/project_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Navigation {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static dynamic toScreen(
    Routes route, {
    Object? arguments,
  }) async {
    return await navigatorKey.currentState!.pushNamed(
      route.path,
      arguments: arguments,
    );
  }
}
