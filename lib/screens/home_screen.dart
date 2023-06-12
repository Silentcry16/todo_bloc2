// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo_bloc2/screens/favorite_tasks_screen.dart';
import 'package:todo_bloc2/screens/task_screen.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/custom_drawer.dart';
import 'completed_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> _taskScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _completedScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _favoriteScreenKey = GlobalKey();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: const CustomDrawer()),
      appBar: AppBar(
        title: currentIndex == BottomNavIndex.tasksIndex
            ? const Text('Todo')
            : currentIndex == BottomNavIndex.completedIndex
                ? const Text('Completed')
                : currentIndex == BottomNavIndex.favoriteIndex
                    ? const Text('Favorite')
                    : null,
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
      body: SafeArea(
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
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const TaskScreen()),
                  ),
                  Navigator(
                    key: _completedScreenKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const CompletedTasksScreen()),
                  ),
                  Navigator(
                    key: _favoriteScreenKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const FavoriteTasksScreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BtmNav(context),
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
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

  BlocBuilder<SwitchBloc, SwitchState> BtmNav(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Container(
          color: state.switchValue ? Colors.grey : const Color(0xFF7b2cbf),
          height: MediaQuery.of(context).size.height * 0.07,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = BottomNavIndex.tasksIndex;
                          });
                        },
                        icon: currentIndex == BottomNavIndex.tasksIndex
                            ? const Icon(
                                Icons.list,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.list,
                                color: Colors.white70,
                                size: 30,
                              )),
                    currentIndex == BottomNavIndex.tasksIndex
                        ? Container(
                            height: 3,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = BottomNavIndex.completedIndex;
                          });
                        },
                        icon: currentIndex == BottomNavIndex.completedIndex
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.done,
                                color: Colors.white70,
                                size: 30,
                              )),
                    currentIndex == BottomNavIndex.completedIndex
                        ? Container(
                            height: 3,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = BottomNavIndex.favoriteIndex;
                          });
                        },
                        icon: currentIndex == BottomNavIndex.favoriteIndex
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.white70,
                                size: 30,
                              )),
                    currentIndex == BottomNavIndex.favoriteIndex
                        ? Container(
                            height: 3,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomNavIndex {
  BottomNavIndex._();
  static const int tasksIndex = 0;
  static const int completedIndex = 1;
  static const int favoriteIndex = 2;
}
