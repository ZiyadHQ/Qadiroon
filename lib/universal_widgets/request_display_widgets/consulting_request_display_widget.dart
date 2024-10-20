
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

Future<List<List<DocumentSnapshot<Map<String, dynamic>>>>> downloadBenDataFromFireStore(String ID) async
{
  List<List<DocumentSnapshot<Map<String, dynamic>>>> listOfLists = [];
  List<DocumentSnapshot<Map<String, dynamic>>> BenList = [];
  List<DocumentSnapshot<Map<String, dynamic>>> SPList = [];
  List<DocumentSnapshot<Map<String, dynamic>>> ServiceList = [];
  var docs = await FirebaseFirestore.instance.collection('ServiceRequest').where('beneficiaryID', isEqualTo: ID).get();
  for(DocumentSnapshot<Map<String, dynamic>> doc in docs.docs)
  {
    Map<String, dynamic> data = doc.data()!;
    String ServiceProviderID = data['serviceProviderID'];
    String ServiceID = data['serviceID'];

    BenList.add(await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).get());
    ServiceList.add(await FirebaseFirestore.instance.collection('Service').doc(ServiceID).get());
    SPList.add(await FirebaseFirestore.instance.collection('User').doc(ServiceProviderID).get());

    listOfLists.add(BenList);
    listOfLists.add(ServiceList);
    listOfLists.add(SPList);
  }

  return listOfLists;
}

Future<List<List<DocumentSnapshot<Map<String, dynamic>>>>> downloadServiceProviderDataFromFireStore(String ID) async
{
  List<List<DocumentSnapshot<Map<String, dynamic>>>> listOfLists = [];
  List<DocumentSnapshot<Map<String, dynamic>>> BenList = [];
  List<DocumentSnapshot<Map<String, dynamic>>> SPList = [];
  List<DocumentSnapshot<Map<String, dynamic>>> ServiceList = [];
  var docs = await FirebaseFirestore.instance.collection('ServiceRequest').where('serviceProviderID', isEqualTo: ID).get();
  for(DocumentSnapshot<Map<String, dynamic>> doc in docs.docs)
  {
    Map<String, dynamic> data = doc.data()!;
    String benID = data['beneficiaryID'];
    String ServiceID = data['serviceID'];

    SPList.add(await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).get());
    ServiceList.add(await FirebaseFirestore.instance.collection('Service').doc(ServiceID).get());
    BenList.add(await FirebaseFirestore.instance.collection('User').doc(benID).get());

    listOfLists.add(BenList);
    listOfLists.add(ServiceList);
    listOfLists.add(SPList);
  }

  return listOfLists;
}

class ConsultingRequestDisplayWidget extends StatelessWidget
{

  ConsultingRequestDisplayWidget({required this.benData, required this.serviceData, required this.serviceProviderData});

  final DocumentSnapshot<Map<String, dynamic>> benData;
  final DocumentSnapshot<Map<String, dynamic>> serviceProviderData;
  final DocumentSnapshot<Map<String, dynamic>> serviceData;

  Future<String> _getImageURL() async
  {
    return await FirebaseStorage.instance
    .ref("${benData.id}/public/pfp.jpg")
    .getDownloadURL();
  }

  String pfpURL = "";

  Widget build(BuildContext context)
  {
    return ExpansionTile
    (
      title: Dialog
      (
        backgroundColor: Colors.blueGrey,
        elevation: 10,
        shadowColor: Colors.black,
        child: Column
        (
          children: 
          [
            StyledText(text: serviceData.data()!['name'], size: 18, color: Colors.black, fontFamily: "Amiri"),
            StyledText(text: benData.data()!['Name'], size: 18, color: Colors.black, fontFamily: "Amiri"),
            FutureBuilder(future: _getImageURL(), builder: (context, snapshot) => CircleAvatar(backgroundImage: NetworkImage(snapshot.data?? "https://upload.wikimedia.org/wikipedia/commons/2/2c/Default_pfp.svg"),),)
          ],
        )
      ),
      children: 
      [
        detailedConsultingRequestDisplayWidget(benData: benData, serviceData: serviceData, serviceProviderData: serviceProviderData)
      ],
    );
  }

}

class detailedConsultingRequestDisplayWidget extends StatelessWidget
{

  detailedConsultingRequestDisplayWidget({required this.benData, required this.serviceData, required this.serviceProviderData});

  final DocumentSnapshot<Map<String, dynamic>> benData;
  final DocumentSnapshot<Map<String, dynamic>> serviceProviderData;
  final DocumentSnapshot<Map<String, dynamic>> serviceData;

  Widget build(BuildContext context)
  {
    
    return Container
    (
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
      child: Column
      (
        children: 
        [
          Text("TEST TEXT"),
          Text("TEST TEXT")
        ],
      ),
    );
  }
  
}