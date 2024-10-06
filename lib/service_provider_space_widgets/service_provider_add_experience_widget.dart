
import 'dart:io';
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

  return "${years} years${(months > 0) ? " and ${months} months" : ""}";
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

  List<Experience> list = [Experience(description: "TEST TEXT", startDate: DateTime.now(), endDate: DateTime.now())];

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
          LabeledButton(function: (){}, icon: Icons.add_link, text: "أضف خبرة جديدة لحسابك",),
          SizedBox(height: height * 0.05,),
          SizedBox
          (
            height: height * 0.5,
            child: ListView
            (
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
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(colors: [Colors.grey.shade600, Colors.grey.shade300, Colors.white])
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