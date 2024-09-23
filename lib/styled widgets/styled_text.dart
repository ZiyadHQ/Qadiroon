
import 'package:flutter/material.dart';

class StyledText extends StatelessWidget
{

  StyledText({super.key, required this.text, required this.size, required this.color, required this.fontFamily, this.alignment = TextAlign.left});
  
  final String text;
  final double size;
  final Color color;
  final String fontFamily;
  final TextAlign alignment;

  Widget build(BuildContext context)
  {
    return Text(
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: fontFamily,
      ),
      text,
      textAlign: alignment,
    );
  }
  
  
  
}