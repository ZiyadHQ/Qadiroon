
import 'package:cloud_firestore/cloud_firestore.dart';
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