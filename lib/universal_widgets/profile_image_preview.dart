
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_information.dart';

void handleUpload(BuildContext context, String path) async
{
  showDialog(context: context, barrierDismissible: false, builder: (context) => CircularProgressIndicator(),);
  var flag = await uploadProfilePicture(File(path));
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(flag? "نجح" : "فشل")));
  Navigator.pop(context);
}

class ProfileImagePreview extends StatelessWidget
{

  ProfileImagePreview({required this.path});

  final String path;

  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        height: height * 0.5,
        width: width * 0.85,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(64)),
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
            ClipOval
            (
              child: Container
              (child: Image.file(File(path), fit: BoxFit.cover), width: 192, height: 192),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: 
            [
              TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(color: Colors.red, text: "عد الى الوراء", size: 28, alignment: TextAlign.right, fontFamily: "Amiri",)),
              SizedBox(width: width * 0.05,),
              TextButton(onPressed: () async {handleUpload(context, path);}, child: StyledText(color: Colors.lightBlue, text: "ارفع الصورة", size: 28, alignment: TextAlign.right, fontFamily: "Amiri",))
              ],)
            ]
          ),
        ),
      ),
    );
  }

}