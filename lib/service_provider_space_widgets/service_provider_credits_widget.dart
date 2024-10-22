
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/service_display_widgets/consulting_display_widget.dart';

Future<bool> downloadServices(BuildContext context, List<DocumentSnapshot<Map<String, dynamic>>> listRef)async
{
  listRef.clear();
  showDialog(context: context, builder: (context) => CircularProgressIndicator.adaptive(),);

  try
  {
    var querySnapshot = await FirebaseFirestore.instance
    .collection('Service')
    //.where('visible', isEqualTo: true)
    .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get();
    listRef.addAll
    (
      querySnapshot.docs
    );
  } catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل التحميل")));
    print("ERROR DOWNLOADING SERVICES FROM FIRESTORE: $e"); 
    return false;
  }

  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("نجح التحميل")));
  return true;
}

Future<bool> downloadServicesBen(BuildContext context, List<DocumentSnapshot<Map<String, dynamic>>> listRef)async
{
  listRef.clear();
  showDialog(context: context, builder: (context) => CircularProgressIndicator.adaptive(),);

  try
  {
    var querySnapshot = await FirebaseFirestore.instance
    .collection('Service')
    .where('visible', isEqualTo: true)
    .get();
    listRef.addAll
    (
      querySnapshot.docs
    );
  } catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل التحميل")));
    print("ERROR DOWNLOADING SERVICES FROM FIRESTORE: $e"); 
    return false;
  }

  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("نجح التحميل")));
  return true;
}

class serviceProviderBrowseScreen extends StatefulWidget
{

  serviceProviderBrowseScreen({required this.userData});

  DocumentSnapshot<Map<String, dynamic>> userData;

  State<StatefulWidget> createState()
  {
    return serviceProviderCreditsScreen();
  }
  
}

class serviceProviderCreditsScreen extends State<serviceProviderBrowseScreen>
{

  List<DocumentSnapshot<Map<String, dynamic>>> list = [];

  @override
  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: ListView
        (
          scrollDirection: Axis.vertical,
          children: 
          [
            StyledText(text: "تصفح الخدمات", color: Colors.black, size: 36, fontFamily: "Amiri",  alignment: TextAlign.center,),
            TextButton(onPressed: () async {await downloadServices(context, list); setState(() {});}, child: Text("download services")),
            SizedBox(height: height * 0.05,),
            Container
            (
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              height: height * 0.6,
              child: ListView
              (
                children: list.map((e) => ConsultingDisplayWidget(serviceData: e, userData: widget.userData.data()!,)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}