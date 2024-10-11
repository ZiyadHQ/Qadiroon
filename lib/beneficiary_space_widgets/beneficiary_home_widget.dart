
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_home_calender_object_widget.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_home_new_record_widget.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_add_experience_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_credits_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_new_service_widget.dart';
import 'package:qadiroon_front_end/simple_alert_widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/service_display_widgets/consulting_display_widget.dart';

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

  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold
    (
      backgroundColor: Colors.blueGrey,
      body: ListView
      (
        scrollDirection: Axis.vertical,
        children:
        [
          SizedBox(height: height * 0.05,),
          TextButton(onPressed: () async {bool success = await downloadServices(context, list); setState(() {}); print("success?? $success");}, child: Text("download services")),
          StyledText(text: "الخدمات المتوفرة", size: 24, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.center,),
          Container
          (
            height: height * 0.725,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: ListView
            (
              shrinkWrap: true,
              children: list.map((e) => ConsultingDisplayWidget(serviceData: e)).toList()
            ),
          )
        ],
      ),
    );
  }
  
}