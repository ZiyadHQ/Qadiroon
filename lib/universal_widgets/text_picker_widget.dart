
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

Future<String> showTextPicker({BuildContext? context, String description = "write text"}) async
{

  String text = "";

  return await showDialog(context: context!, builder: (context) => TextPicker(textRef: text, description: description,));

}

class TextPicker extends StatelessWidget
{

  TextPicker({required this.textRef, this.description = "write text:"});

  final String description;

  String textRef;

  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog
    (
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      child: Column
      (
        children:
        [
          SizedBox(height: height * 0.05,),
          StyledText(text: description, size: 36, color: Colors.black, fontFamily: "Amiri"),
          TextField(onChanged: (value) {textRef = value;},),
          Row
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              BackButton(color: Colors.red, onPressed: (){Navigator.pop(context, "");},),
              SizedBox(width: width * 0.10,),
              TextButton(onPressed: (){Navigator.pop(context, textRef);}, child: Text("اقبل")),
            ],
          ),
        ],
      )
    );
  }
  
}