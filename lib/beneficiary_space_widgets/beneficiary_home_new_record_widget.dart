
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryHomeNewRecordScreen extends StatefulWidget
{

  State<BeneficiaryHomeNewRecordScreen> createState()
  {
    return _BeneficiaryHomeNewRecordScreenState();
  }
  
}

class _BeneficiaryHomeNewRecordScreenState extends State<BeneficiaryHomeNewRecordScreen>
{

  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.blueGrey,
      body: Center
      (
        child: ListView
        (
          children: 
          [
            SizedBox(height: 64,),
            Text('الاسم'),
            ClipRRect
            (
              borderRadius: BorderRadius.circular(16),
              child: Container
            (
              color: Colors.black12,
              width: 256,
              child: TextField
              (

              ),
            ),
            ),
            SizedBox(height: 16,),
            Text('المحتوى'),
            ClipRRect
            (
              borderRadius: BorderRadius.circular(16),
              child: Container
            (
              color: Colors.black12,
              width: 256,
              child: TextField
              (
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            ),
            Text('النوع'),
            ClipRRect
            (
              borderRadius: BorderRadius.circular(16),
              child: Container
            (
              color: Colors.black12,
              width: 256,
              child: DropdownButton
            (
              dropdownColor: Colors.transparent,
              items: 
              [
                DropdownMenuItem(child: Text('TEST TEXT'), value: 'TEST TEXT',),
                DropdownMenuItem(child: Text('TEST TEXT'), value: 'TEST TEXT',),
                DropdownMenuItem(child: Text('TEST TEXT'), value: 'TEST TEXT',)
              ],
              onChanged: (value){},
            ),
            ),
            ),
            TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: 'الغ', size: 36, color: Colors.white60, fontFamily: 'Amiri')),
            SizedBox(height: 128,)
          ],
        ),
      ),
    );
  }
  
}