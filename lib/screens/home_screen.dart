// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:todo_bloc2/widgets/app_text.dart';

import '../widgets/add_task_screen.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/home_screen_contents.dart';
import '../widgets/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> _taskScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _completedScreenKey = GlobalKey();
  // final GlobalKey<NavigatorState> _favoriteScreenKey = GlobalKey();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: const CustomDrawer()),
      appBar: AppBar(
        title: currentIndex == BottomNavIndex.tasksIndex
            ? AppText(
                text: 'Pending Screen',
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.03,
                weight: FontWeight.bold,
              )
            : AppText(
                text: 'Completed Tasks',
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.03,
                weight: FontWeight.bold,
              ),
        actions: [
          currentIndex == BottomNavIndex.tasksIndex
              ? IconButton(
                  icon: const Icon(Icons.add),
                  //opens the BottomSheet to add a new task
                  onPressed: () => _addTask(context),
                )
              : const SizedBox.shrink()
        ],
      ),
      body: HomeScreenContents(
          currentIndex: currentIndex,
          taskScreenKey: _taskScreenKey,
          completedScreenKey: _completedScreenKey),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentIndex,
        onIndexChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const AddTaskScreen()),
        );
      },
    );
  }
}
