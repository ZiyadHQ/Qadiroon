

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/new_service_widgets/new_service_consulting_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_hint.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:qadiroon_front_end/tools/jsify.dart';

import 'package:http/http.dart' as http;

Future<void> sendTestRequest(String userID, String title, String textBody) async {
  try {
    // Define the URI
    Uri uri = Uri.parse('http://161.35.68.157/notify');

    // Define the body exactly as expected by the server
    String body = jsonEncode({
      "targetUserID": userID,
      "messageTitle": title,
      "messageBody" : textBody
    });

    // Send the POST request
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,  // JSON-encoded body string
    );

    // Print the response status and body for debugging
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
  } catch (e) {
    print("Error occurred: $e");
  }
}

class ConsultingDisplayWidget extends StatelessWidget
{

  ConsultingDisplayWidget({required this.serviceData, required this.userData});
  DocumentSnapshot<Map<String, dynamic>> serviceData;
  Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return TextButton
    (
      onPressed: (){showDialog(context: context, builder: (context) => ConsultingDetailedWidget(serviceData: serviceData, userData: userData,));},
      child: Container
      (
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: Colors.lightBlue),
        height: height * 0.15,
        child: Column
        (
          children:
          [
            StyledText(text: serviceData['name'], size: 24, color: Colors.black, fontFamily: "Amiri"),
            StyledText(text: serviceData['serviceType'], size: 24, color: Colors.black, fontFamily: "Amiri"),
            StyledText(text: serviceData['subType'], size: 24, color: Colors.black, fontFamily: "Amiri"),
          ],
        ),
      ),
    );
  }

}

class ConsultingDetailedWidget extends StatefulWidget
{

  ConsultingDetailedWidget({required this.serviceData, this.userData});
  
  final DocumentSnapshot<Map<String, dynamic>> serviceData;
  final Map<String, dynamic>? userData;

  @override
  State<ConsultingDetailedWidget> createState() => _ConsultingDetailedWidgetState();
}



class _ConsultingDetailedWidgetState extends State<ConsultingDetailedWidget> {

  Future<bool> orderService() async
  {
    showDialog(context: context, builder: (context) => CircularProgressIndicator.adaptive(),);

    if(await checkDuplicateRequest())
    {
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("لقد طلبت هذه الخدمة مسبقاً, انتظر حتى يأتيك رد من مقدم الخدمة")));
      return false;
    }

    print(widget.serviceData.data()!);
    String serviceProviderID = widget.serviceData.data()!['userID'];

    Map<String, dynamic> data = 
    {
      'serviceProviderID' : serviceProviderID,
      'beneficiaryID' : FirebaseAuth.instance.currentUser!.uid,
      'serviceID' : widget.serviceData.id,
      'date' : DateTime.now(),
      'accepted' : false.toString()
    };

    try
    {
      await FirebaseFirestore.instance.collection('ServiceRequest').doc().set(data);
    } catch (e)
    {
      Navigator.of(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("حدثت مشكلة عند رفع طلبك")));
      return false;  
    }

    //Navigator.pop(context);
    Navigator.pop(context);
    print("${widget.userData?? "user is null"}");
    print("${widget.serviceData.data()!['name']}");
    String thisUserName = (await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).get()).data()!['Name'];
    String messageBody = 
    """
${thisUserName} :المستفيد
${widget.serviceData.data()!['name']} :الخدمة
${DateTime.now().toString()} :الوقت
    """;
    await sendTestRequest(data['serviceProviderID'].toString(), "طلب مستفيد خدمتك", messageBody);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم رفع الطلب بنجاح, قيد انتظار الرد من مقدم الخدمة")));
    return true;
  }

  Future<bool> checkDuplicateRequest() async
  {
    late var check;
    try
    {
      print("starting check for duplicate ServiceRequests");
      check = await FirebaseFirestore.instance.collection('ServiceRequest')
      .where('serviceID', isEqualTo: widget.serviceData.id)
      .where('beneficiaryID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .limit(1)
      .get(const GetOptions(source: Source.server));
      print("ended check for duplicate ServiceRequests");
    } catch (e)
    {
      print("Error checking duplicate: $e");
      return true;
    }

    return (check.size > 0);
  }

  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Dialog
    (
      child: Column
      (
        children:
        [
          StyledText(text: widget.serviceData.data()!['name'], size: 32, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.center,),
          Container
          (
           height: height * 0.5,
            child: Container
            (
              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(16)),
              child: ListView
              (
                scrollDirection: Axis.vertical,
                children: [StyledText(text: widget.serviceData.data()!['description'], size: 14, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.right,)],
              ),
            ),
          ),
          StyledText(text: widget.serviceData.data()!['serviceType'], size: 14, color: Colors.black, fontFamily: "Amiri"),
          StyledText(text: widget.serviceData.data()!['subType'], size: 14, color: Colors.black, fontFamily: "Amiri"),
          Icon(Icons.repeat, color: (widget.serviceData.data()!['repeating'] == 'true')? Colors.blue : Colors.red),
          SizedBox(height: height * 0.05,),
          (FirebaseAuth.instance.currentUser!.uid != widget.serviceData['userID'])? Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Spacer(),
              TextButton(onPressed: (){}, child: Text("بلغ الخدمة")),
              Spacer(),
              TextButton(onPressed: () async {print(await orderService());}, child: Text("اطلب الخدمة")),
              Spacer()
            ],
          )
          :
          SizedBox()
        ],
      ),
    );
  }
}