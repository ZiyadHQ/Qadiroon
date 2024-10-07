
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:image_picker/image_picker.dart';
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
  void initState() {
    for(int i=0; i<10;i++)
    {
      list.add(Experience(description: "$i desc", startDate: DateTime.now(), endDate: DateTime(DateTime.now().year + Random.secure().nextInt(10), DateTime.now().month + Random.secure().nextInt(2))));
    }
    // TODO: implement initState
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
            showDialog(context: context, builder: (context) => CreateWidgetDialog());
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
  @override
  State<StatefulWidget> createState()
  {
    return _CreateWidgetDialogState();
  }

}

class _CreateWidgetDialogState extends State<CreateWidgetDialog>
{

  Widget extraWidget = const Text("TEST TEXT");

  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: ListView
      (
        children:
        [
          StyledText(text: "وصف الخبرة", size: 36, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.right,),
          TextField(),
          TextButton(
            onPressed: ()
          async {
            var firstDate = await showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
            if(firstDate != null)
            {
              setState(() {
                extraWidget = TextButton(onPressed: (){showDatePicker(context: context, firstDate: firstDate, lastDate: DateTime.now());}, child: Text("end date"));
              });
            }
          },
          child: Text("start date")
          ),
          extraWidget
        ]
      ),
    );
  }

}