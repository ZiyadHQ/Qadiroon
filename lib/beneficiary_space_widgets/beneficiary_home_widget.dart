
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_home_calender_object_widget.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_home_new_record_widget.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';
import 'package:qadiroon_front_end/simple_alert_widgets.dart';
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

  void updateState()
  {
    setState(() {});
  }

  void addCalenderObject(CalenderRecord cRecord) async
  {
    //Calender.add(cRecord);
    FirebaseFirestore _database = FirebaseFirestore.instance;

    Map<String, dynamic> objectMap =
    {
      'uid' : FirebaseAuth.instance.currentUser!.uid,
      'Name' : cRecord.Name,
      'Content' : cRecord.Contents,
      'date' : cRecord.Date,
      'type' : cRecord.type.toString()
    };

    await _database.collection('CalenderRecord').doc().set(objectMap).
    onError((error, stackTrace) => print('Error sending record to database: $error'));
    setState(() {});
  }

  List<CalenderRecord> Calender = <CalenderRecord>[];

  void deleteCalenderObject(List Calender, CalenderRecord cRecord)
  {
    Calender.remove(cRecord);
    setState(() {
      
    });
  }

  CalenderRecord toRecord()
  {
    throw UnimplementedError();
  }

  void updateList() async
  {
    simple_rotating_loading_screen(context, backgroundColor: Colors.transparent, isDismissible: false);
    FirebaseFirestore _database = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _database.collection('CalenderRecord').get();
    for(var doc in snapshot.docs)
    {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      String name = data['Name'];
      String content = data['Content'];
      Timestamp date = data['date'];
      String type = data['type'];
      CalenderRecord cRecord = CalenderRecord(name, content, date.toDate(), EventType.Education);
      Calender.add(cRecord);
    }
    Navigator.pop(context);
    setState(() {});
  }

  List<Widget> getListOfWidgets()
  {
    List<Widget> listOfWidgets = [];

    Calender.forEach
    ((element) 
    {
      listOfWidgets.add(SizedBox(height: 32,));
      listOfWidgets.add(BeneficiaryHomeCalenderObject(cRecord: element, Calender: Calender, setState: updateState,));
    });
    return listOfWidgets;
  }

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
        children: getListOfWidgets(),
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
            SizedBox(width: 0,),
            TextButton(onPressed: (){showDialog(context: context, builder: (context) { return BeneficiaryHomeNewRecordScreen(Calender, addCalenderObject); });}, child: StyledText(text: 'أضف عنصر جديد للجدول', size: 24, color: Colors.blueGrey.shade700, fontFamily: 'Amiri')),
            SizedBox(width: 64,),
            TextButton(onPressed: (){updateList();}, child: Text('test button'))
          ],
        ),
        )
      )
    );
  }
  
}