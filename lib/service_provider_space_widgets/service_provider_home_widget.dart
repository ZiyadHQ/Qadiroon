
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/animated_styled_widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/request_display_widgets/consulting_request_display_widget.dart';
import 'package:qadiroon_front_end/universal_widgets/service_display_widgets/consulting_display_widget.dart';

class serviceProviderHomeScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() 
  {
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

    List<ConsultingRequestDisplayWidget> list = [];

    for(requestDisplayWidgetRecord request in listOfLists)
    {
      list.add(ConsultingRequestDisplayWidget(data: request, deleteElementFromList: deleteElementFromList,));
    }

    return list;
  }

  List<requestDisplayWidgetRecord> listOfLists = [];
  bool initialized = false;

  void deleteElementFromList(requestDisplayWidgetRecord element)
  {
    listOfLists.remove(element);
    setState(() {});
  }

  void initState()
  {
    downloadServiceProviderDataFromFireStore(FirebaseAuth.instance.currentUser!.uid).then
    (
      (value)
      {
        listOfLists.addAll(value);
        initialized = true;
        setState(() {});
      }
    ); 
    super.initState();
  }

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
          child: RefreshIndicator
          (
            onRefresh: () async
            {
                listOfLists.clear();
                listOfLists.addAll(await downloadServiceProviderDataFromFireStore(FirebaseAuth.instance.currentUser!.uid));
                setState(() {});
            },
            child: ListView
            (
              scrollDirection: Axis.vertical,
              children: (initialized)?
                (listOfLists.isEmpty)? [Card(color: Colors.blueGrey, child: Text("no requests"),)] : mapListOfListsToWidgets()
                : [GradientAnimatedWrapper(child: Card(color: Colors.white38, child: Text("Loading", style: TextStyle(fontSize: 36), textAlign: TextAlign.center,),), duration: Duration(seconds: 3), gradient: [Colors.white, Colors.grey])],
            ),
          ),
        ),
        // TextButton
        // (
        //   onPressed: () async
        //   {
        //     showDialog(context: context, builder: (context) => CircularProgressIndicator(), barrierDismissible: false);
        //     listOfLists = await downloadServiceProviderDataFromFireStore(FirebaseAuth.instance.currentUser!.uid);
        //     setState((){}); Navigator.pop(context);
        //   },
        //   child: Text("UPDATE listOfLists"),
        // )
      ],
    );
  }
  
}