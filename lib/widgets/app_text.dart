import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  AppText(
      {super.key,
      required this.text,
      this.size = 13,
      this.color = Colors.black,
      this.weight = FontWeight.normal});

  final String text;
  final double? size;
  final Color? color;
  FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(color: color, fontWeight: weight),
      ),
    );
  }
}
