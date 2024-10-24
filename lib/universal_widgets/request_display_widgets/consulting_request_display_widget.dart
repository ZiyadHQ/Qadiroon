
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/chat_room_widgets/chat_room_widget.dart';
import 'package:qadiroon_front_end/universal_widgets/service_display_widgets/consulting_display_widget.dart';

enum contentType
{
  text,
  image,
}

class requestDisplayWidgetRecord
{

  requestDisplayWidgetRecord({required this.requestData, required this.benData, required this.serviceData, required this.serviceProviderData});

  final DocumentSnapshot<Map<String, dynamic>> requestData;
  final DocumentSnapshot<Map<String, dynamic>> benData;
  final DocumentSnapshot<Map<String, dynamic>> serviceProviderData;
  final DocumentSnapshot<Map<String, dynamic>> serviceData;
}

Future<List<requestDisplayWidgetRecord>> downloadBenDataFromFireStore(String ID) async
{
  List<requestDisplayWidgetRecord> list = [];

  var docs = await FirebaseFirestore.instance.collection('ServiceRequest').where('beneficiaryID', isEqualTo: ID).get();
  for(DocumentSnapshot<Map<String, dynamic>> doc in docs.docs)
  {
    Map<String, dynamic> data = doc.data()!;
    String ServiceProviderID = data['serviceProviderID'];
    String ServiceID = data['serviceID'];

    var tempBen = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).get();
    var tempService = await FirebaseFirestore.instance.collection('Service').doc(ServiceID).get();
    var tempSP = await FirebaseFirestore.instance.collection('User').doc(ServiceProviderID).get();

    list.add
    (
      requestDisplayWidgetRecord
      (
        requestData: doc,
        benData: tempBen,
        serviceData: tempService,
        serviceProviderData: tempSP
      )
    );

  }

  return list;
}

Future<List<requestDisplayWidgetRecord>> downloadServiceProviderDataFromFireStore(String ID) async
{

  List<requestDisplayWidgetRecord> list = [];

  var docs = await FirebaseFirestore.instance.collection('ServiceRequest').where('serviceProviderID', isEqualTo: ID).get();
  for(DocumentSnapshot<Map<String, dynamic>> doc in docs.docs)
  {

    Map<String, dynamic> data = doc.data()!;
    String benID = data['beneficiaryID'];
    String ServiceID = data['serviceID'];
    var tempSP = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).get();
    var tempService = await FirebaseFirestore.instance.collection('Service').doc(ServiceID).get();
    var tempBen = await FirebaseFirestore.instance.collection('User').doc(benID).get();

    list.add
    (
      requestDisplayWidgetRecord
      (
        requestData: doc,
        benData: tempBen,
        serviceData: tempService,
        serviceProviderData: tempSP
      )
    );

  }

  return list;
}

class ConsultingRequestDisplayWidget extends StatelessWidget
{

  ConsultingRequestDisplayWidget({required this.data, required this.deleteElementFromList});

  void Function(requestDisplayWidgetRecord) deleteElementFromList;
  final requestDisplayWidgetRecord data;

  Future<String> _getImageURL() async
  {
    return await FirebaseStorage.instance
    .ref("${data.benData.id}/public/pfp.jpg")
    .getDownloadURL();
  }

  String pfpURL = "";

  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ExpansionTile
    (
      showTrailingIcon: false,
      title: Container
      (
        decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(6),
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            StyledText(text: data.serviceData.data()!['name'], size: 28, color: Colors.black, fontFamily: "Tajawal", alignment: TextAlign.center,),
            Container
            (
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(10),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  StyledText(text: data.benData.data()!['Name'], size: 24, color: Colors.black, fontFamily: "Tajawal"),
                  SizedBox(width: width * 0.05,),
                  FutureBuilder(future: _getImageURL(), builder: (context, snapshot) => CircleAvatar(backgroundImage: NetworkImage(snapshot.data?? "https://upload.wikimedia.org/wikipedia/commons/2/2c/Default_pfp.svg"),),)
                ],
              ),
            )
          ],
        )
      ),
      children: 
      [
        detailedConsultingRequestDisplayWidget(parentData: data, data: data, deleteElementFromList: deleteElementFromList,)
      ],
    );
  }

}

class detailedConsultingRequestDisplayWidget extends StatelessWidget
{

  Future<void> acceptRequestAndStartNewSession(BuildContext context) async
  {

    var doc = await FirebaseFirestore.instance.collection('Service').doc(data.serviceData.id).get();
    if(doc.data()!['visible'] == false)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("لا يمكنك ان تقبل طلب آخر قبل ان تكمل الخدمة الجارية")));
      return;
    }

    await FirebaseFirestore.instance.collection('Service').doc(data.serviceData.id).update({'visible' : false});
    var requestDoc = await FirebaseFirestore.instance.collection('ServiceRequest').doc(data.requestData.id).update({'accepted' : true});
    await sendTestRequest
    (
      data.benData.id,
      "تم قبول طلبك",
"""
تم قبول طلبك للخدمة: ${data.serviceData.data()!['name']}
"""
    );
    await FirebaseFirestore.instance.collection('ServiceRequest').doc(data.requestData.id).collection('Chat').doc().set
    (
      {
        'senderID' : FirebaseAuth.instance.currentUser!.uid,
        'contentType' : contentType.text.toString(),
        'content' : 'مرحباً في نافذة الدردشة, لا ترسل بيانات حساسة في هذه الدردشة, مثل رقم الهوية, أو الصور الشخصية',
        'timeStamp' : DateTime.now().millisecondsSinceEpoch
      } 
    );

  }

  Future<void> refuseService(BuildContext context) async
  {
                  showDialog(context: context, builder: (context) => CircularProgressIndicator());
                  try
                  {
                    await FirebaseFirestore.instance.collection('ServiceRequest').doc(data.requestData.id).delete();
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ERROR: $e")));
                    return;
                  }
                  sendTestRequest(data.benData.id, "تم رفض طلبك لخدمة ما",
"""
الخدمة: ${data.serviceData.data()!['name']}
مقدم الخدمة: ${data.serviceProviderData.data()!['Name']}
"""
                  );
                  deleteElementFromList(parentData);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("removed successfully")));
                  }

  detailedConsultingRequestDisplayWidget({required this.parentData, required this.data, required this.deleteElementFromList});

  void Function(requestDisplayWidgetRecord)  deleteElementFromList;
  final requestDisplayWidgetRecord data;
  requestDisplayWidgetRecord parentData;

  Widget build(BuildContext context)
  {
    
    return Container
    (
      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)),
      child: Column
      (
        children: 
        [
          StyledText(text: "بيانات طالب الخدمة", size: 24, color: Colors.black, fontFamily: "Tajawal"),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Spacer(),

              (data.requestData.data()!['accepted'] != true)?
              TextButton
              (
                onPressed: () async 
                {await refuseService(context);},
                child: Container(decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(8)), child: StyledText(text: "ارفض الطلب", size: 24, color: Colors.red, fontFamily: "Tajawal")),
              )
              :
              SizedBox(),

              (data.requestData.data()!['accepted'] != true)?
              Spacer()
              :
              TextButton
              (
                onPressed: ()
                {
                  showDialog(context: context, builder: (context) => ChatRoomScreen(data: data,),);
                },
                child: Container(decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(8)), child: StyledText(text: "افتح نافذة الدردشة", size: 24, color: Colors.blue, fontFamily: "Tajawal")),
              ),
              (data.requestData.data()!['accepted'] != true)?
              TextButton
              (
                onPressed: () async {await acceptRequestAndStartNewSession(context);},
                child: Container(decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(8)), child: StyledText(text: "اقبل الطلب", size: 24, color: Colors.blue, fontFamily: "Tajawal")),
              )
              :
              SizedBox(),
              Spacer()
            ],
          )
        ],
      ),
    );
  }
  
}