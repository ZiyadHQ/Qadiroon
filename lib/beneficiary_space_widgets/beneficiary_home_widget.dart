
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryHomeScreen extends StatelessWidget
{

  Widget build(BuildContext context)
  {
    return Column
    (
      children: 
      [
        StyledText(text: 'Test Text', size: 36, color: Colors.black87, fontFamily: 'Amiri'),
        SizedBox(height: 32,),
        StyledText(text: 'Test Text', size: 36, color: Colors.black87, fontFamily: 'Amiri')
      ],
    );
  }
  
}