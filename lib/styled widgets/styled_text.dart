
import 'package:flutter/material.dart';

class StyledText extends StatelessWidget
{

  StyledText({super.key, required this.text, required this.size, required this.color, required this.fontFamily});
  
  final String text;
  final double size;
  final Color color;
  final String fontFamily;

  Widget build(BuildContext context)
  {
    return Text(
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: fontFamily
      ),
      text
    );
  }
  
  
  
}