
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

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

Future<void> downloadServiceProviderDataFromFireStore(String ID) async
{

}

class ConsultingRequestDisplayWidget extends StatelessWidget
{

  ConsultingRequestDisplayWidget({required this.benData, required this.serviceData, required this.serviceProviderData});

  final Map<String, dynamic> benData;
  final Map<String, dynamic> serviceProviderData;
  final Map<String, dynamic> serviceData;

  Widget build(BuildContext context)
  {
    return Text("TEST TEXT");
  }

}