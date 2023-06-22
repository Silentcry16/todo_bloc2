import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:todo_bloc2/widgets/app_text.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/custom_drawer.dart';
import 'completed_tasks_screen.dart';
import 'pending_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static const id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> _taskScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _completedScreenKey = GlobalKey();
  // final GlobalKey<NavigatorState> _favoriteScreenKey = GlobalKey();

  late final navigationMapper = {
    BottomNavIndex.tasksIndex: _taskScreenKey,
    BottomNavIndex.completedIndex: _completedScreenKey,
  };

  final List<int> routeHistoryList = [
    0,
  ];

  Future<bool> _onWillPop() async {
    if (navigationMapper[currentIndex]!.currentState!.canPop()) {
      navigationMapper[currentIndex]!.currentState!.pop();
    } else if (routeHistoryList.length > 1) {
      setState(() {
        log('Removed ${routeHistoryList.last}from$routeHistoryList');
        routeHistoryList.remove(routeHistoryList.last);
        log('moved ${routeHistoryList.last}from$routeHistoryList');

        currentIndex = routeHistoryList.last;
      });
    } else if (routeHistoryList.length == 1) {
      showDialog(
          context: context,
          builder: (context) {
            return BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return AlertDialog(
                  title: const Text('Exit'),
                  content: const Text('Are you sure you want to exit the app?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Stay in the app
                      },
                      child: AppText(
                        text: 'Cancel',
                        color: state.switchValue ? Colors.white : Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () => exit(0),
                      child: AppText(
                        text: 'Exit',
                        color: state.switchValue ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                );
              },
            );
          });
    }

    return false;
  }

  int currentIndex = BottomNavIndex.tasksIndex;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const CustomDrawer()),
        appBar: AppBar(
          title: currentIndex == BottomNavIndex.tasksIndex
              ? AppText(
                  text: 'Pending Screen',
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.025,
                  weight: FontWeight.bold,
                )
              : AppText(
                  text: 'Completed Tasks',
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.025,
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
        //this is where I have used IndexedStack to show each screen
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
                          builder: (context) => const PendingScreen()),
                    ),
                    Navigator(
                      key: _completedScreenKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const CompletedTasksScreen()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: state.switchValue
                    ? Colors.grey.shade900
                    : const Color(0xFFca7df9),
              ),
              height: size.height * 0.08,
              width: size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (() => setState(
                            () => [
                              currentIndex = BottomNavIndex.tasksIndex,

                              //if the taskIndex is not in the routHistoryList, we add it, otherwise it goes to the next line
                              if (!routeHistoryList
                                  .contains(BottomNavIndex.tasksIndex))
                                {
                                  routeHistoryList
                                      .add(BottomNavIndex.tasksIndex),
                                  log('added${routeHistoryList.last}to the $routeHistoryList')
                                }
                            ],
                          )),
                      icon: currentIndex == BottomNavIndex.tasksIndex
                          ? Icon(
                              Icons.list,
                              color: Colors.white,
                              size: size.height * 0.045,
                            )
                          : Icon(
                              Icons.list,
                              color: Colors.white70,
                              size: size.height * 0.040,
                            )),
                  Container(
                    height: size.height * 0.08,
                    width: size.height * 0.08,
                    decoration: BoxDecoration(
                        color: state.switchValue
                            ? Colors.grey.shade800
                            : Colors.purple.shade700.withOpacity(0.4),
                        borderRadius:
                            BorderRadius.circular(size.height * 0.08)),
                    child: IconButton(
                      onPressed: () {
                        currentIndex = BottomNavIndex.tasksIndex;
                        _addTask(context);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: size.height * 0.045,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: (() => setState(
                            () => [
                              currentIndex = BottomNavIndex.completedIndex,
                              //if the completedIndex is not in the routHistoryList, we add it, otherwise it goes to the next line

                              if (!routeHistoryList
                                  .contains(BottomNavIndex.completedIndex))
                                {
                                  routeHistoryList
                                      .add(BottomNavIndex.completedIndex),
                                  log('added${routeHistoryList.last}to the $routeHistoryList')
                                }
                            ],
                          )),
                      icon: currentIndex == BottomNavIndex.completedIndex
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                              size: size.height * 0.045,
                            )
                          : Icon(
                              Icons.done,
                              color: Colors.white70,
                              size: size.height * 0.040,
                            )),
                ],
              ),
            );
          },
        ),
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

class BottomNavIndex {
  BottomNavIndex._();
  static const int tasksIndex = 0;
  static const int completedIndex = 1;
}
