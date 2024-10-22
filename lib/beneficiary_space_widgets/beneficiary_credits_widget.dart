
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryCreditsScreen extends StatefulWidget
{

  @override
  State<BeneficiaryCreditsScreen> createState() => _BeneficiaryCreditsScreenState();
}

class _BeneficiaryCreditsScreenState extends State<BeneficiaryCreditsScreen>
{

  void initState()
  {
    FirebaseFirestore.instance.collection('ServiceRequest')
    .where('beneficiaryID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get()
    .then
    (
      (value)
      {
        for(DocumentSnapshot<Map<String, dynamic>> doc in value.docs)
        {
           
        }
      },
    );
    super.initState();
  }

  List<DocumentSnapshot<Map<String, dynamic>>> list = [];

  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold
    (
      backgroundColor: Colors.blueGrey.shade200,
      body: Column
      (
        children: 
        [

        ],
      )
    );
  }
}