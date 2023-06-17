import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  AppText({
    super.key,
    required this.text,
    this.size = 15,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
  });

  final String text;
  final double? size;
  final Color? color;
  FontWeight? weight;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
            color: color,
            fontWeight: weight,
            fontSize: size,
            overflow: overflow,
            decoration: decoration),
      ),
    );
  }
}
