import 'package:flutter/material.dart';
import 'package:todo_bloc2/blocs/bloc_exports.dart';
import 'package:todo_bloc2/widgets/app_text.dart';

class TaskCounter extends StatelessWidget {
  const TaskCounter({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Center(
          child: Chip(
            label: AppText(
              text: text,
              weight: FontWeight.bold,
              color: state.switchValue == false ? Colors.black : Colors.white,
            ),
          ),
        );
      },
    );
  }
}
