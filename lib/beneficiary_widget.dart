

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:qadiroon_front_end/start_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryScreen extends StatefulWidget
{

  BeneficiaryScreen({super.key, required this.user});

  final UserCredential user;

  State<StatefulWidget> createState()
  {
    return _BeneficiaryScreenState();
  }

}

class _BeneficiaryScreenState extends State<BeneficiaryScreen>
{
  Map<String, dynamic>? userData;
  @override
  void initState()
  {
    super.initState();
    FirebaseFirestore database = FirebaseFirestore.instance;
     database.collection('User').doc(widget.user.user!.uid).get().then((value){
      setState(() {
        userData = value.data() as Map<String, dynamic>;
      });
     });
  }

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: Tab(child: ListView(
        scrollDirection:  Axis.horizontal,
        children: [
          SizedBox(width: 32,),
          StyledText(text: userData?['Name'], size: 36, color: Colors.blueGrey, fontFamily: 'Amiri'),
          SizedBox(width: 128,),
          StyledText(text: userData?['userType'], size: 36, color: Colors.blueGrey, fontFamily: 'Amiri')
        ],
      )),
      body: Center(
        child: Text('مستفيد'),
      ),
      bottomNavigationBar: Tab(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(onPressed: (){FirebaseAuth.instance.signOut(); main_switchBaseWidget(StartScreen());}, icon: Icon(Icons.logout)),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
          ],
        ),
      ),
    );
  }

}
