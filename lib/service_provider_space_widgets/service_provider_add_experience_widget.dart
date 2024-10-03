
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:file_picker/file_picker.dart';

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
  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: Center
      (
        child: Flex
        (
          direction: Axis.vertical,
          children: 
          [
            SizedBox(height: height * 0.05,),
            StyledText(text: "أضف خبرة جديدة لحسابك", size: 36, color: Colors.black87, fontFamily: "Amiri"),
            SizedBox(height: height * 0.05,),
            TextButton(onPressed: () async {await FilePicker.platform.pickFiles();}, child: StyledText(text: "اختر الملف", size: 36, color: Colors.black, fontFamily: "Amiri")),
            Spacer(),
            TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: "عد الى الوراء", size: 36, color: Colors.red, fontFamily: "Amiri")),
          ],
        ),
      ),
    );
  }

}