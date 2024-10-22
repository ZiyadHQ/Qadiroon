
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_add_experience_widget.dart';
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

  List<Widget> mapListOfListsToWidgets()
  {

    if(listOfLists.isEmpty)
    {
      return [];
    }

    List<Widget> list = [];

    for(requestDisplayWidgetRecord request in listOfLists)
    {
      list.add
      (
        ConsultingRequestDisplayWidget(data: request, deleteElementFromList: deleteElementFromList,)
        .animate()
        .fade(curve: SawTooth(1), duration: 2000.ms)
      );
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
                (listOfLists.isEmpty)? [Card(color: Colors.white38, child: Text("لم يطلب اي مستخدم اي من خدماتك, حاول لاحقاً", style: TextStyle(fontSize: 36), textAlign: TextAlign.center,),)] : mapListOfListsToWidgets()
                : [GradientAnimatedWrapper(child: Card(color: Colors.white38, child: Text("تحميل الطلبات", style: TextStyle(fontSize: 36), textAlign: TextAlign.center,),), duration: Duration(seconds: 3), gradient: [Colors.white, Colors.grey])],
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