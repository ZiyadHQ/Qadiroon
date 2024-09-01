
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/camera_widgets/camera_widget.dart';

Future<String?> uploadImage(XFile imageFile) async
{

  try
  {
    final fireStorage = FirebaseStorage.instance;

    final storageRef = fireStorage.ref()
    .child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");

    await storageRef.putFile(File(imageFile.path));

    String downloadURL = await storageRef.getDownloadURL();
    return downloadURL;
  } catch (e)
  {
    print(e);
    return null;
  }

}

class userPersonalAccountScreen extends StatefulWidget
{

  userPersonalAccountScreen({super.key, required this.userData});

  Map<String, dynamic> userData = {};

  State<StatefulWidget> createState()
  {
    return _userPersonalAccountScreenState();
  }

}

class _userPersonalAccountScreenState extends State<userPersonalAccountScreen>
{

  var imageFile;

  Widget build(BuildContext context)
  {

    return ListView
    (
      scrollDirection: Axis.vertical,
      children: 
      [
        SizedBox
        (
          width: 512, height: 64,
          child: ClipRRect
          (
            borderRadius: BorderRadius.circular(32),
            child: Scaffold
            (
              body: Row
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  Spacer(),
                  Text("${widget.userData["Name"]}"),
                  Spacer(),
                  Text("${(widget.userData["issueTime"] as Timestamp).toDate()}"),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 64,),
        TextButton(onPressed: () async {imageFile = await ImagePicker().pickImage(source: ImageSource.gallery)?? imageFile; print("path: ${imageFile?.path?? "image null"}");}, child: Text("TAKE IMAGE")),
        SizedBox(height: 64,),
        TextButton(onPressed: () async {print("image URL: ${await uploadImage(imageFile)}");}, child: Text("UPLOAD IMAGE")),
        SizedBox(height: 64,),
        TextButton(onPressed: (){showModalBottomSheet(context: context, builder: (context) => Image.file(File(imageFile!.path)));}, child: Text("SHOW IMAGE")),
        StyledText(text: "${widget.userData!["userType"]}", size: 24, color: Colors.black, fontFamily: "Amiri"),
        SizedBox(height: 64,),
        StyledText(text: "${(widget.userData!["issueTime"] as Timestamp).toDate()}", size: 24, color: Colors.black, fontFamily: "Amiri"),
      ],
    );
  }
  
}