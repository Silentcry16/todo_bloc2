import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.index});
  final int index;
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.index == 1;
                  });
                },
                icon: const Icon(Icons.pending)),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.index == 2;
                  });
                },
                icon: const Icon(Icons.done)),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.index == 3;
                  });
                },
                icon: const Icon(Icons.favorite)),
          ),
        ],
      ),
    );
  }
}
