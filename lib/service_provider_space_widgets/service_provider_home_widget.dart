
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/request_display_widgets/consulting_request_display_widget.dart';

class serviceProviderHomeScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _serviceProviderHomeScreenState();
  }

}

class _serviceProviderHomeScreenState extends State<serviceProviderHomeScreen>
{

  List<ConsultingRequestDisplayWidget> mapListOfListsToWidgets()
  {

    if(listOfLists.isEmpty)
    {
      return [];
    }

    var benList = listOfLists[0];
    var ServiceList = listOfLists[1];
    var SPList = listOfLists[2];

    List<ConsultingRequestDisplayWidget> ListOfWidgets = [];

    for(int i=0; i<benList.length; i++)
    {
      ListOfWidgets.add(ConsultingRequestDisplayWidget(benData: benList[i], serviceData: ServiceList[i], serviceProviderData: SPList[i]));
    }

    return ListOfWidgets;
  }

  List<List<DocumentSnapshot<Map<String, dynamic>>>> listOfLists = [];

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column
    (

      children:
      [
        StyledText(text: "طلبات المستفيدين", size: 36, color: Colors.black, fontFamily: "Amiri"),
        Container
        (
          height: height * 0.7,
          alignment: Alignment.center,
          decoration: BoxDecoration
          (
            color: Colors.white,
            borderRadius: BorderRadius.circular(24)
          ),
          child: ListView
          (
            scrollDirection: Axis.vertical,
            children: mapListOfListsToWidgets(),
          ),
        ),
        TextButton
        (
          onPressed: () async
          {
            showDialog(context: context, builder: (context) => CircularProgressIndicator(), barrierDismissible: false);
            listOfLists = await downloadServiceProviderDataFromFireStore(FirebaseAuth.instance.currentUser!.uid);
            setState((){}); Navigator.pop(context);
          },
          child: Text("UPDATE listOfLists"),
        )
      ],
    );
  }
  
}