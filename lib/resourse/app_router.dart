import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static push(Widget page) => navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => page),
      );

  static pushAndRemove(Widget page) => navigatorKey.currentState
      ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  static out(Widget page) => navigatorKey.currentState
      ?.pushNamedAndRemoveUntil('/customer', (Route<dynamic> route) => false);
}
