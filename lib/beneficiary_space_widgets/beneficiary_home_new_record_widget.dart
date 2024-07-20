
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryHomeNewRecordScreen extends StatefulWidget
{

  BeneficiaryHomeNewRecordScreen(this.list, this.addCalenderObject);

  List<CalenderRecord> list;
  Function addCalenderObject;

  State<BeneficiaryHomeNewRecordScreen> createState()
  {
    return _BeneficiaryHomeNewRecordScreenState(list, addCalenderObject);
  }
  
}

class _BeneficiaryHomeNewRecordScreenState extends State<BeneficiaryHomeNewRecordScreen>
{

  _BeneficiaryHomeNewRecordScreenState(this.list, this.addCalenderObject);

  List<CalenderRecord> list;
  DateTime date = DateTime.now();

  //
  String Name = 'NULL';
  String Content = 'NULL';
  EventType type = EventType.Education;
  Function addCalenderObject;
  //

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
            StyledText(text: 'الاسم', size: 24, color: Colors.black87, fontFamily: 'Amiri'),
            ClipRRect
            (
              borderRadius: BorderRadius.circular(16),
              child: Container
            (
              color: Colors.black12,
              width: 256,
              child: TextField
              (
                onChanged: (value) {Name = value;},
              ),
            ),
            ),
            SizedBox(height: 64,),
            StyledText(text: 'المحتوى', size: 24, color: Colors.black87, fontFamily: 'Amiri'),
            ClipRRect
            (
              borderRadius: BorderRadius.circular(16),
              child: Container
            (
              color: Colors.black12,
              width: 256,
              child: TextField
              (

                onChanged: (value) {Content = value;},
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            ),
            SizedBox(height: 64,),
            StyledText(text: 'النوع', size: 24, color: Colors.black87, fontFamily: 'Amiri'),
            ClipRRect
            (
              borderRadius: BorderRadius.circular(16),
              child: Container
            (
              color: Colors.black12,
              width: 256,
              child: DropdownButton
            (
              focusColor: Colors.transparent,
              dropdownColor: Colors.white38,
              hint: EventToIcon[type],
              items: EventType.values.map((e) => DropdownMenuItem(child: EventToIcon[e]!, value: e,)).toList(),
              onChanged: (value){type = value!; setState(() {});},
            ),
            ),
            ),
            SizedBox(height: 64,),
            Center(child: Text('التاريخ')),
            IconButton(onPressed:(){showDatePicker(context: context,currentDate: date, confirmText: 'أكِّد', cancelText: 'الغ', barrierColor: Colors.black54, firstDate: DateTime(DateTime.now().year - 1), lastDate: DateTime(DateTime.now().year + 20)).then((value){if(value != null){date = value;}print(date);});}, icon: Icon(Icons.date_range, size: 128,)),
            SizedBox(height: 32,),
            TextButton(onPressed: (){addCalenderObject(CalenderRecord(Name, Content, date, type)); Navigator.pop(context);}, child: StyledText(text: 'اضف العنصر', size: 36, color: Colors.white70, fontFamily: 'Amiri')),
            SizedBox(height: 16,),
            TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: 'الغ', size: 36, color: Colors.red.shade500, fontFamily: 'Amiri')),
            SizedBox(height: 128,)
          ],
        ),
      ),
    );
  }
  
}