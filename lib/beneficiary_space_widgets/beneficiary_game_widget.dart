
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryGameScreen extends StatefulWidget
{
 
  State<BeneficiaryGameScreen> createState()
  {
    return _BeneficiaryGameScreenState();
  }
  
}

class _BeneficiaryGameScreenState extends State<BeneficiaryGameScreen>
{

  Widget build(BuildContext context)
  {
    return Column
    (
      children: 
      [
        StyledText(text: 'العب اكس أو', size: 36, color: Colors.black87, fontFamily: 'Amiri'),
        DecoratedBox
        (
          decoration: BoxDecoration(color: Colors.blueGrey, ),
          child: SizedBox(height: 32,),
        ),
        Row
        (
          children: 
          [
            Text('Text'),
            Spacer(),
            Text('Text'),
            Spacer(),
            Text('Text')
          ],
        ),
        Spacer(),
        Row
        (
          children: 
          [
            Text('Text'),
            Spacer(),
            Text('Text'),
            Spacer(),
            Text('Text')
          ],
        ),
        Spacer(),
        Row
        (
          children: 
          [
            Text('Text'),
            Spacer(),
            Text('Text'),
            Spacer(),
            Text('Text')
          ],
        )
      ],
    );
  }
  
}