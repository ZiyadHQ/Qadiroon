
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_information.dart';

void handleUpload(BuildContext context, String path) async
{
  var flag = await uploadProfilePicture(File(path));
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
    return Center(
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text("عد الى الوراء")), TextButton(onPressed: () async {handleUpload(context, path);}, child: Text("ارفع الصورة"))],)
        ]
      ),
    );
  }

}