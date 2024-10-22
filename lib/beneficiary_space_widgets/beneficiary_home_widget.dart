
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/service_display_widgets/consulting_display_widget.dart';

Future<bool> downloadServicesBen(List<DocumentSnapshot<Map<String, dynamic>>> listRef)async
{
  listRef.clear();

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
    print("ERROR DOWNLOADING SERVICES FROM FIRESTORE: $e"); 
    return false;
  }

  return true;
}

class BeneficiaryHomeScreen extends StatefulWidget
{

  BeneficiaryHomeScreen({required this.userData});

  Map<String, dynamic> userData;

  State<StatefulWidget> createState()
  {
    return _BeneficiaryHomeScreenState();
  }
  
}

class _BeneficiaryHomeScreenState extends State<BeneficiaryHomeScreen>
{

  List<DocumentSnapshot<Map<String, dynamic>>> list = [];

  void initState()
  {
    downloadServicesBen(list).then
    (
      (value)
      {
          setState(() {});
          print("TEST TEST INITSTATE FOR BEN WIDGETS");
      },
    );
    super.initState();
  }

  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold
    (
      backgroundColor: Colors.blueGrey,
      body: Column
      (
        children:
        [
          SizedBox(height: height * 0.05,),
          StyledText(text: "الخدمات المتوفرة", size: 24, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.center,),
          Container
          (
            height: height * 0.725,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: RefreshIndicator
            (
              onRefresh: () async
        {
          bool success = await downloadServicesBen(list);
          setState(() {});
          print("success?? $success");
        },
              child: ListView
              (
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: list.map((e) => ConsultingDisplayWidget(serviceData: e, userData: widget.userData,)
                .animate()
                .fade(curve: SawTooth(1), duration: 2000.ms)
                ).toList()
              ),
            ),
          )
        ],
      ),
    );
  }
  
}