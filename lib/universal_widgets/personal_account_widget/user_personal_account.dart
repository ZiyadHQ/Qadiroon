
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/camera_widgets/camera_widget.dart';

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
  
  late final CameraDescription firstCamera;

  @override
  void initState() async{
    super.initState();
    late List<CameraDescription> cameras;
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }

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
        TextButton(onPressed: (){XFile image = XFile(""); showModalBottomSheet(context: context, builder: (context) => cameraControlScreen(cameraToControl: firstCamera, imageRefrence: image));}, child: Text("TAKE IMAGE")),
        SizedBox(height: 64,),
        StyledText(text: "${widget.userData!["userType"]}", size: 24, color: Colors.black, fontFamily: "Amiri"),
        SizedBox(height: 64,),
        StyledText(text: "${(widget.userData!["issueTime"] as Timestamp).toDate()}", size: 24, color: Colors.black, fontFamily: "Amiri"),
      ],
    );
  }
  
}