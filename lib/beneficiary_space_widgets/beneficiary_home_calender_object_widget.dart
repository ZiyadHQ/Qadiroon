
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryHomeCalenderObject extends StatelessWidget
{
  
  BeneficiaryHomeCalenderObject({required this. cRecord, required this.Calender, required this.setState, required this.removeObject});
  List Calender;
  CalenderRecord cRecord;
  Function setState;
  Function removeObject;

  Widget build(BuildContext context) 
  {
    return ClipRRect
    (
      borderRadius: BorderRadius.circular(32),
      child: SizedBox
      (
        height: 128,
        width: 512,
        child: Scaffold
        (
          body: Center(child: Column
          (
            children: 
            [
              Text('${cRecord.Name}'),
              Text(cRecord.Contents),
              Text(cRecord.Date.toString()),
              StyledText(text: cRecord.oid?? 'ID NOT FOUND', size: 12, color: Colors.black87, fontFamily: 'Amiri'),
              TextButton(onPressed: (){removeObject(Calender, cRecord); setState();}, child: Text('احذف العنصر'))
            ],
          ))
        ),
      )
    );
  }
  
}