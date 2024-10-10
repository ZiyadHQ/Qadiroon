
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_page_view.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_account.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_information.dart';

String dateRangeToString(DateTime start, DateTime end) {
  int years = end.year - start.year;
  int months = end.month - start.month;

  // Adjust if the end month is earlier than the start month
  if (months < 0) {
    years -= 1;
    months += 12;
  }

  return "${years} y${(months > 0) ? ", ${months} m" : ""}";
}

void updateList(List<Experience> listRef)
{
  FirebaseFirestore.instance.collection('Experience').where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .get()
  .then((QuerySnapshot snapshot){
    listRef.clear();
    snapshot.docs.forEach((doc){
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Experience temp = Experience(description: data['description'], startDate: (data['startDate'] as Timestamp).toDate(), endDate: (data['endDate'] as Timestamp).toDate());
      listRef.add(temp);
      });
      });
}

class ServiceProviderAddExperienceScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _ServiceProviderAddExperienceScreenState();
  }

}

class _ServiceProviderAddExperienceScreenState extends State<ServiceProviderAddExperienceScreen>
{

  List<Experience> list = [Experience(description: "TEST TEXT", startDate: DateTime.now(), endDate: DateTime(DateTime.now().year + Random.secure().nextInt(10), DateTime.now().month + Random.secure().nextInt(2)))];

  @override
  void initState()
  {

    updateList(list);

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center
    (
      child: Column
      (
        children: 
        [
          SizedBox(height: height * 0.05,),
          LabeledButton(function: ()
          {
            showDialog(context: context, builder: (context) => CreateWidgetDialog(listRef: list,));
          }
          , icon: Icons.add_link, text: "أضف خبرة جديدة لحسابك",),
          SizedBox(height: height * 0.05,),
          Container
          (
            width: width * 0.95,
            height: height * 0.5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: Colors.white),
            child: ListView
            (
              padding: EdgeInsets.all(8),
              children: list.map((e) => ExperienceWidget(experience: e)).toList(),
            ),
          )
        ],
      ),
    );
  }

}

class Experience
{

  Experience({required this.description, required this.startDate, required this.endDate});

  final String description;
  final DateTime startDate;
  final DateTime endDate;

}

class ExperienceWidget extends StatelessWidget{

  ExperienceWidget({required this.experience});

  final Experience experience;

  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DecoratedBox
    (
      decoration: BoxDecoration
      (
        color: Colors.white,
        borderRadius: BorderRadius.circular(64),
        gradient: LinearGradient(colors: [Colors.grey.shade600, Colors.grey.shade300, Colors.white, Colors.blueGrey.shade600])
      ),
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          StyledText(text: experience.description, size: 24, color: Colors.black, fontFamily: "Amiri"),
          StyledText(text: "من: ${formatDate(experience.startDate)}", size: 24, color: Colors.black, fontFamily: "Amiri"),
          StyledText(text: "الى: ${formatDate(experience.endDate)}", size: 24, color: Colors.black, fontFamily: "Amiri"),
          StyledText(text: "(${dateRangeToString(experience.startDate, experience.endDate)})", size: 24, color: Colors.black, fontFamily: "Amiri")
        ],
      ),
    );
  }

}

class CreateWidgetDialog extends StatefulWidget
{

  CreateWidgetDialog({required this.listRef});

  List<Experience> listRef;

  @override
  State<StatefulWidget> createState()
  {
    return _CreateWidgetDialogState();
  }

}

class _CreateWidgetDialogState extends State<CreateWidgetDialog>
{

  Future<bool> _handleNewExperience(BuildContext context, String desc, DateTime start, DateTime end) async
  {

    if(end.microsecondsSinceEpoch <= start.microsecondsSinceEpoch)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("وقت النهاية لا يمكن ان يكون قبل او مطابق لوقت البداية")));
      return false;
    }
    else if(desc == "")
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("لا يوجد وصف للخبرة")));
      return false;
    }

    showDialog(context: context, builder: (context) => CircularProgressIndicator.adaptive(),);

    Map<String, dynamic> doc = 
    {
      'userID' : FirebaseAuth.instance.currentUser!.uid,
      'description' : desc,
      'startDate' : start,
      'endDate' : end
    };

    try
    {
      await FirebaseFirestore.instance.collection('Experience').doc().set(doc);
    } catch (e) {
      print("ERROR UPLOADING NEW EXPERIENCE: $e");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل اضافة الخبرة")));
      return false;
    }
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تمت اضافة الخبرة بنجاح")));
    updateList(widget.listRef);
    return true;
  }

  Widget extraWidget = SizedBox();
  Widget secondExtraWidget = SizedBox();

  String desc = "";
  DateTime? start;
  DateTime? end; 

  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold
    (
      body: ListView
      (
        children:
        [
          SizedBox(
            height: height * 0.12,
            child: StyledPageView
            (
              children: 
              [
                StyledText(text: "اجعل وصف الخبرة قصيراً وموجزاً, حاول ألا تتعدا 50 حرف", size: 24, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.right,),
                StyledText(text: "مثال: مدير مبيعات في شركة مزارع القصيم", size: 24, color: Colors.black, fontFamily: "Amiri"),
                StyledText(text: "يجب ان يكون تاريخ البداية قبل تاريخ النهاية", size: 24, color: Colors.black, fontFamily: "Amiri")
              ],
            ),
          ),
          SizedBox(height: height * 0.1,),
          StyledText(text: "وصف الخبرة", size: 36, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.center,),
          TextField(onChanged: (value){desc = value;}, style: TextStyle(fontFamily: "Amiri")),
          SizedBox(height: height * 0.05),
          TextButton(
            onPressed: ()
          async {
            start = await showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
            if(start != null)
            {
              setState(() {
                extraWidget = TextButton(onPressed: () async {
                  end = await showDatePicker(context: context, firstDate: start!, lastDate: DateTime.now());
                  if(end != null)
                  {secondExtraWidget = TextButton(onPressed: () async {bool success = await _handleNewExperience(context, desc, start!, end!); if(success){Navigator.pop(context);}}, child: StyledText(text: "أضف الخبرة", size: 24, color: Colors.blue, fontFamily: "Amiri"))
                  .animate().slide(duration: 1000.ms).fadeIn(duration: 1000.ms).scale(duration: 1000.ms);}
                  setState(() {});
                },
                child: Container(child: StyledText(text: "تاريخ النهاية", size: 36, color: Colors.black, fontFamily: "Amiri"), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color:  Colors.blueGrey),)
                );
              });
            }
          },
          child: Container(child: StyledText(text: "تاريخ البداية", size: 36, color: Colors.black, fontFamily: "Amiri"), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.blueGrey))
          ),
          extraWidget,
          SizedBox(height: height * 0.025,),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: "عد الى الوراء", size: 24, color: Colors.red, fontFamily:"Amiri")),
              secondExtraWidget,
            ],
          )
        ]
      ),
    );
  }

}