
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qadiroon_front_end/styled%20widgets/animated_styled_widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_account.dart';
import 'package:qadiroon_front_end/universal_widgets/profile_image_preview.dart';
import 'package:qadiroon_front_end/universal_widgets/text_picker_widget.dart';
import 'package:intl/intl.dart';

Future<bool> uploadProfilePicture(File file) async
{

  try
  {
    var ref = FirebaseStorage.instance.ref().child('${FirebaseAuth.instance.currentUser!.uid}/public/pfp.jpg');
    var fileUpload = await ref.putFile(file);
  } catch (e) {
    print('Exception uploading profile picture: $e');
    return false;
  }

  return true;
  
}

Future<String> getProfilePicture() async
{

  var ref = FirebaseStorage.instance.ref('${FirebaseAuth.instance.currentUser!.uid}/public');

  var files = await ref.listAll();

  for(var refrence in files.items)
  {
    print('${await refrence.getDownloadURL()}');
  }

  return '';

}

String formatDate(DateTime date)
{
  return DateFormat('yyyy-MM-dd').format(date);
}

class UserPersonalInformationScreen extends StatelessWidget
{

  UserPersonalInformationScreen({required this.userData, required this.pfpURL});

  final Map<String, dynamic> userData;
  final String pfpURL;

  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container
    (
      child: Center
      (
        child: Column
        (
          children:
          [
            SizedBox(height: height * 0.025,),
            StyledText(text: ": اسم المستخدم", size: 36, color: Colors.black87, fontFamily: "Amiri"),
            LabeledButton
            (
              function: () async
              {
                String text = await showTextPicker(context: context, description: ":اكتب اسمك الجديد"); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$text")));
              },
              icon: Icons.edit,
              text: userData['Name']
            ),
            SizedBox(height: height * 0.05,),
            StyledText(text: ": تاريخ انشاء الحساب", size: 36, color: Colors.black87, fontFamily: "Amiri"),
            LabeledButton
            (
              function: () async
              {
                String text = await showTextPicker(context: context, description: ":اكتب اسمك الجديد"); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$text")));
              },
              icon: Icons.edit,
              text: formatDate(userData['issueTime'].toDate())
            ),
            SizedBox(height: height * 0.05,),
            StyledText(text: ": تغيير صورة العرض", size: 36, color: Colors.black87, fontFamily: "Amiri"),
            TextButton
            (
              child: CircleAvatar
              (
                foregroundImage: NetworkImage(pfpURL),
                radius: 72,
              ).animate().scale(duration: 1000.ms, curve: ElasticInCurve(), begin: Offset(0.5, 0.5)),
              onPressed: () async {var files = await ImagePicker.platform.getMultiImageWithOptions(); if(files.length > 0) showDialog(context: context, builder: (context) => ProfileImagePreview(path: files[0].path));},
            )
          ],
        ),
      ),
    );
  }

}