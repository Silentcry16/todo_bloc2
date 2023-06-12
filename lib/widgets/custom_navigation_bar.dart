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
    return Container(
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
                icon: Icon(Icons.pending)),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.index == 2;
                  });
                },
                icon: Icon(Icons.done)),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.index == 3;
                  });
                },
                icon: Icon(Icons.favorite)),
          ),
        ],
      ),
    );
  }
}
