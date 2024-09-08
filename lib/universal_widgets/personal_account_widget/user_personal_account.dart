
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qadiroon_front_end/simple_alert_widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

Future<String?> uploadImage(XFile imageFile) async
{
  var uid = FirebaseAuth.instance.currentUser!.uid;
  try
  {
    final fireStorage = FirebaseStorage.instance;

    final storageRef = fireStorage.ref()
    .child("${uid}/${DateTime.now().millisecondsSinceEpoch}.jpg");

    await storageRef.putFile(File(imageFile.path));

    String downloadURL = await storageRef.getDownloadURL();
    return downloadURL;
  } catch (e)
  {
    print(e);
    return null;
  }

}

void listFoldersAndFiles(String? Dir) async
{
  var ref = FirebaseStorage.instance.ref(Dir?? "");

  var list = await ref.listAll();

  for(var prefix in list.prefixes)
  {
    print("[Folder] ${prefix.name}");
  }

  for(var item in list.items)
  {
    print("[File] ${item.fullPath}");
  }

}

Future<List<Widget>> getImagesFromDir() async
{
  var ref = FirebaseStorage.instance.ref("${FirebaseAuth.instance.currentUser!.uid}/");

  List<String> files = [];

  var list = await ref.listAll();
  for(var item in list.items)
  {
    files.add(await item.getDownloadURL());
  }

  List<Widget> widgets = [];

  for(var file in files)
  {
    widgets.add( Image.network(file));
  }
  return widgets;
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

  Timer startDaemon()
{

  var timerRef = Timer.periodic(Durations.extralong4, (timer) async
  {
    images = await getImagesFromDir();
    if(this.mounted)
    setState(() {
      
    });
    print("TIMER LAPSED");
  }
  );

  return timerRef;

}

  @override
  void initState() {
    super.initState();

    timer = startDaemon();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Timer? timer;
  var imageFile;
  List<Widget> images = [];

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
        TextButton(onPressed: () async {simple_alert_showWidget(context, "رفع الصورة لقاعدة البيانات", isDismissible: false); await uploadImage(imageFile); Navigator.pop(context);}, child: Text("UPLOAD IMAGE")),
        SizedBox(height: 64,),
        TextButton(onPressed: (){showModalBottomSheet(context: context, builder: (context) => ListView(children: images));}, child: Text("SHOW IMAGE")),
        StyledText(text: "${widget.userData!["userType"]}", size: 24, color: Colors.black, fontFamily: "Amiri"),
        SizedBox(height: 64,),
        StyledText(text: "${(widget.userData!["issueTime"] as Timestamp).toDate()}", size: 24, color: Colors.black, fontFamily: "Amiri"),
      ],
    );
  }
  
}