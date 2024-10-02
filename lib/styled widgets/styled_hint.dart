import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

///used as a styled helper widget for hints to simplify the creation process
class StyledHint extends StatelessWidget
{

  StyledHint({required this.text, required this.color, required this.size, this.alignment = TextAlign.center});

  final Color color;
  final double size;
  final String text;
  final TextAlign alignment;

  @override
  Widget build(BuildContext context) 
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ClipRRect
    (
      borderRadius: BorderRadius.circular(100),
      child: SizedBox
      (
        height: height/2,
        width: width/2,
        child: Column
        (
          children: 
          [
            StyledText
            (
              color: color,
              size: size,
              text: text,
              alignment: alignment,
              fontFamily: "Amiri",
            ),
            Spacer(),
            TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: "عد الى الوراء", size: 36, color: Colors.red, fontFamily: "Amiri")),
            Spacer()
          ],
        ),
      ),
    );

  }
  
}