
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';

class BeneficiaryHomeCalenderObject extends StatelessWidget
{
  
  BeneficiaryHomeCalenderObject({required this. cRecord, required this.Calender, required this.setState});
  List Calender;
  CalenderRecord cRecord;
  Function setState;

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
              TextButton(onPressed: (){Calender.remove(cRecord); setState();}, child: Text('احذف العنصر'))
            ],
          ))
        ),
      )
    );
  }
  
}