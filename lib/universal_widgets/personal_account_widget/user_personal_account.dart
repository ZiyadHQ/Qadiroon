
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_add_experience_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_information.dart';

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

Future<List<String>> getImagesFromDir() async
{
  var ref = FirebaseStorage.instance.ref("${FirebaseAuth.instance.currentUser!.uid}/public/");

  List<String> files = [];

  late var list;

  try {
    list = await ref.listAll();
  } catch (e) {
    print("Error listing all files from ${{FirebaseAuth.instance.currentUser!.uid}}: ${e}");
    return [];
  }

  for(var item in list.items)
  {
    files.add(await item.getDownloadURL());
  }

  return files;
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

  var timerRef = Timer.periodic(Duration(seconds: 2), (timer) async
  {
    URLs = await getImagesFromDir();
    images = URLs.map((e) => Image.network(e)).toList();
    if(this.mounted)
    setState(() {
      downloaded = (URLs.length > 0);
    });
    print("TIMER LAPSED");
  }
  );

  return timerRef;

}

  @override
  void initState() {

    getImagesFromDir().then((value) {
      URLs = value;
    },);

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
  List<String> URLs = [];
  bool downloaded = false;

  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold
    (
      backgroundColor: Colors.black12,
      body: ListView
      (
        scrollDirection: Axis.vertical,
        children: 
        [
          SizedBox(height: height * 0.025,),
          Center
          (
            child: (downloaded)? CircleAvatar
          (
            maxRadius: 72,
            backgroundColor: Colors.white12,
            foregroundImage: NetworkImage(URLs[0]),
          )
          .animate()
          .fadeIn(duration: 2000.ms)
          .scale(duration: 2000.ms) : CircularProgressIndicator.adaptive(),
          ),
          SizedBox(height: height * 0.05,),
          ExpansionTile
          (
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Title(color: Colors.white, child: LabeledText(icon: Icons.account_box, text: "البيانات الشخصية"),),
            backgroundColor: Colors.blueGrey,
            collapsedIconColor: Colors.purple,
            children:
            [
              UserPersonalInformationScreen(userData: widget.userData, pfpURL: (URLs.length > 0)? URLs[0] : '')
            ],
          ),
          //these widgets only appear if the user type is service provider(UserType.S)
          widget.userData['userType'] == UserType.S.toString()?
          ExpansionTile
          (
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Title(color: Colors.white, child: LabeledText(icon: Icons.history_edu, text: "الخبرات"),),
            children:
            [
              ServiceProviderAddExperienceScreen()
            ],
            backgroundColor: Colors.blueGrey,
            collapsedIconColor: Colors.purple,
          ) : SizedBox()
        ],
      ),
    );
  }
  
}

class LabeledButton extends StatelessWidget
{

  LabeledButton({required this.function, required this.icon, required this.text, this.spacing = 0});

  final void Function() function;
  final IconData icon;
  final String text;
  final double spacing;

  @override
  Widget build(BuildContext context)
  {
    return DecoratedBox
    (
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: TextButton
      (
        onPressed: function,
        child: Flex
        (
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: 
          [
            Icon(icon, size: 36,),
            StyledText(text: text, size: 24, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.right,),
          ],
        ),
      ),
    );
  }
  
}

class LabeledText extends StatelessWidget
{

  LabeledText({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DecoratedBox
    (
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Flex
      (
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: 
        [
          Icon(icon, size: 36,),
          StyledText(text: text, size: 24, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.right,),
        ],
      ),
    );
  }
  
}