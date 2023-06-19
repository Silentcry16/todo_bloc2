import 'package:flutter/material.dart';
import 'package:todo_bloc2/screens/home_screen/home_screen.dart';
import 'package:todo_bloc2/screens/recycle_bin_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBinScreen.id:
        return MaterialPageRoute(
          builder: (_) => const RecycleBinScreen(),
        );
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
