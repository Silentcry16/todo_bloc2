import 'package:flutter/material.dart';

import '../screens/completed_tasks_screen.dart';
import '../screens/pending_screen.dart';

class HomeScreenContents extends StatelessWidget {
  const HomeScreenContents({
    super.key,
    required this.currentIndex,
    required GlobalKey<NavigatorState> taskScreenKey,
    required GlobalKey<NavigatorState> completedScreenKey,
  })  : _taskScreenKey = taskScreenKey,
        _completedScreenKey = completedScreenKey;

  final int currentIndex;
  final GlobalKey<NavigatorState> _taskScreenKey;
  final GlobalKey<NavigatorState> _completedScreenKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: IndexedStack(
              index: currentIndex,
              children: [
                Navigator(
                  key: _taskScreenKey,
                  onGenerateRoute: (settings) =>
                      MaterialPageRoute(builder: (context) => PendingScreen()),
                ),
                Navigator(
                  key: _completedScreenKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => const CompletedTasksScreen()),
                ),
                // Navigator(
                //   key: _favoriteScreenKey,
                //   onGenerateRoute: (settings) => MaterialPageRoute(
                //       builder: (context) => const FavoriteTasksScreen()),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
