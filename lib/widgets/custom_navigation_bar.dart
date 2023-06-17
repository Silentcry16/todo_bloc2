import 'package:flutter/material.dart';
import 'package:todo_bloc2/widgets/app_text.dart';

import '../blocs/bloc_exports.dart';
import '../screens/home_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar(
      {super.key, required this.currentIndex, required this.onIndexChanged});

  int currentIndex;
  final ValueChanged<int> onIndexChanged;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: state.switchValue ? Colors.grey : const Color(0xFF7b2cbf),
              borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height * 0.075,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                    label: AppText(
                      text: 'Pending',
                      color: state.switchValue ? Colors.black : Colors.white,
                      size: widget.currentIndex == BottomNavIndex.tasksIndex
                          ? 18
                          : 15,
                      weight: widget.currentIndex == BottomNavIndex.tasksIndex
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    onPressed: () {
                      setState(() {
                        // widget.currentIndex = BottomNavIndex.tasksIndex;
                        widget.onIndexChanged(BottomNavIndex.tasksIndex);
                      });
                    },
                    icon: widget.currentIndex == BottomNavIndex.tasksIndex
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
              ),
              Expanded(
                child: TextButton.icon(
                    label: AppText(
                      text: 'Completed',
                      color: state.switchValue ? Colors.black : Colors.white,
                      size: widget.currentIndex == BottomNavIndex.completedIndex
                          ? 18
                          : 15,
                      weight:
                          widget.currentIndex == BottomNavIndex.completedIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                    onPressed: () {
                      setState(() {
                        // widget.currentIndex = BottomNavIndex.completedIndex;
                        widget.onIndexChanged(BottomNavIndex.completedIndex);
                      });
                    },
                    icon: widget.currentIndex == BottomNavIndex.completedIndex
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
              ),
              //favorite icon
              // Expanded(
              //   child: Column(
              //     children: [
              //       IconButton(
              //           onPressed: () {
              //             setState(() {
              //               currentIndex = BottomNavIndex.favoriteIndex;
              //             });
              //           },
              //           icon: currentIndex == BottomNavIndex.favoriteIndex
              //               ? const Icon(
              //                   Icons.favorite,
              //                   color: Colors.white,
              //                   size: 35,
              //                 )
              //               : const Icon(
              //                   Icons.favorite,
              //                   color: Colors.white70,
              //                   size: 30,
              //                 )),
              //       currentIndex == BottomNavIndex.favoriteIndex
              //           ? Container(
              //               height: 3,
              //               decoration:
              //                   const BoxDecoration(color: Colors.white),
              //             )
              //           : const SizedBox.shrink(),
              //     ],
              //   ),
              // ),
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
  // static const int favoriteIndex = 2;
}
