
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_home_new_record_widget.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryHomeScreen extends StatefulWidget
{

  State<StatefulWidget> createState()
  {
    return _BeneficiaryHomeScreenState();
  }
  
}

class _BeneficiaryHomeScreenState extends State<BeneficiaryHomeScreen>
{

  List<CalenderRecord> Calender = List.empty();

  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.blueGrey.shade200,
      body: Center
      (
        child: ListView
      (
        scrollDirection: Axis.vertical,
        children: 
        [

        ],
      ),
      ),
      bottomNavigationBar: Tab
      (
        child: Scaffold
        (
          backgroundColor: Colors.blueGrey.shade500,
          body: ListView
        (
          scrollDirection: Axis.horizontal,
          children: 
          [
            SizedBox(width: 128,),
            TextButton(onPressed: (){showDialog(context: context, builder: (context) => BeneficiaryHomeNewRecordScreen());}, child: StyledText(text: 'أضف عنصر جديد للجدول', size: 24, color: Colors.blueGrey.shade700, fontFamily: 'Amiri'))
          ],
        ),
        )
      ),
    );
  }
  
}