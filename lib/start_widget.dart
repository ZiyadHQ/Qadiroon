
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_widget.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/login_widget.dart';
import 'package:qadiroon_front_end/register_widget.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_widget.dart';

class StartScreen extends StatefulWidget
{

  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
{

  bool testFlag = true;

  void initState()
  {
    if(FirebaseAuth.instance.currentUser != null)
    {
      Future.delayed(Duration(seconds: 0)).then
      (
        (value)
        {
      FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then
      (
        (value)
        async {
          var Token = await FirebaseMessaging.instance.getToken();
          await FirebaseFirestore.instance.collection('UserPrivate').doc(FirebaseAuth.instance.currentUser!.uid).update({'FCMToken' : Token.toString()});
          if(value.data()!['userType'] == UserType.B.toString())
          {
            main_switchBaseWidget(BeneficiaryScreen(key: globalBenificiaryStateKey, userData: value.data()!));
            setState(() {});
          }else
          {
            main_switchBaseWidget(ServiceProviderScreen(user: value, key: globalServiceProviderStateKey,));
            testFlag = false;
            setState(() {});
          }
        },
      );  
        }, 
      );
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w300,
                fontFamily: 'Amiri'
              ),
              'قادرون'
            ),
            SizedBox(height: 96,),
            TextButton(
              style: ButtonStyle(),
              onPressed: (){showDialog(context: context, builder: (context) => LoginMenu());},
              child: Text(
              'سجل الدخول',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 32
            )
            ),
            ),
            SizedBox(height: 96),
            Text(
              'أو تسجيل حساب جديد كـ',
            style: TextStyle(
              fontSize: 32
            )
            ),
            TextButton(onPressed: (){showDialog(context: context, builder: (context) => RegisterMenu(userType: UserType.B));}, child: Text(
              style: TextStyle(fontSize: 32,
                color: Colors.blueGrey.shade500
              ),
              'مستفيد'
            )),
            SizedBox(height: 12),
            TextButton(onPressed: (){showDialog(context: context, builder: (context) => RegisterMenu(userType: UserType.S));}, child: Text(
              style: TextStyle(fontSize: 32,
                color: Colors.blueGrey.shade500
              ),
              'مقدم خدمة'
            )),
            Spacer(),
            TextButton(onPressed: () async
            {
              late UserCredential creds;
              try {
                FirebaseAuth.instance.signInWithEmailAndPassword(email: "Ahmad@testmail.com", password: "Password!123");
              } catch (e) {
                print("error signing in debugUser: $e");
                return;
              }
              DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).get();
              main_switchBaseWidget(ServiceProviderScreen(user: data, key: globalServiceProviderStateKey));
            }, child: Text("DEBUG LOGIN ServiceProvider")),
            TextButton(onPressed: () async
            {
              late UserCredential creds;
              late DocumentSnapshot<Map<String, dynamic>> userData;
              try {
                creds = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "Saleh@testmail.com", password: "Password!123");
                userData = await FirebaseFirestore.instance.collection('User').doc(creds.user!.uid).get();
                var Token = await FirebaseMessaging.instance.getToken();
                await FirebaseFirestore.instance.collection('UserPrivate').doc(FirebaseAuth.instance.currentUser!.uid).update({'FCMToken' : Token.toString()});
              } catch (e) {
                print("error signing in debugUser: $e");
                return;
              }
              main_switchBaseWidget(BeneficiaryScreen(userData: userData.data()!, key: globalBenificiaryStateKey,));
            }, child: Text("DEBUG LOGIN Ben")),
            (testFlag)? Text("flag true") : Text("flag false")
          ],
        ),
      ),
    );
  }
}