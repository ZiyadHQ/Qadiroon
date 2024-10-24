import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qadiroon_front_end/login_widget.dart';
import 'package:qadiroon_front_end/register_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/animated_styled_widgets.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      Future.delayed(Duration(seconds: 0)).then(
        (value) {
          FirebaseFirestore.instance
              .collection('User')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then(
            (value) async {
              var Token = await FirebaseMessaging.instance.getToken();
              await FirebaseFirestore.instance
                  .collection('UserPrivate')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'FCMToken': Token.toString()});
              if (value.data()!['userType'] == UserType.B.toString()) {
                main_switchBaseWidget(BeneficiaryScreen(
                    key: globalBenificiaryStateKey, userData: value.data()!));
                setState(() {});
              } else {
                main_switchBaseWidget(ServiceProviderScreen(
                  user: value,
                  key: globalServiceProviderStateKey,
                ));
                setState(() {});
              }
            },
          );
        },
      );
    }
    super.initState();
  }

  String imageURL = "https://kebar.sa/wp-content/uploads/sites/2220/2022/01/ktrrrr-8.png";

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF2B448C),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: height * 0.035,),
            Text(
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Amiri',
                  color: Colors.white,
                ),
                'قادرون'),
            SizedBox(
              height: 96,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(width * 0.8,
                      height * 0.055), // Set minimum size for all buttons
                  maximumSize: Size(width * 0.8,
                      height * 0.055), // Set maximum size for all buttons
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {
                showDialog(context: context, builder: (context) => LoginMenu());
              },
              child: Text('سجل الدخول',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0), fontSize: 32)),
            ),
            SizedBox(height: 96),
            Text('أو تسجيل حساب جديد كـ',
                style: TextStyle(fontSize: 32, color: Colors.white)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.8,
                        height * 0.055), // Set minimum size for all buttons
                    maximumSize: Size(width * 0.8,
                        height * 0.055), // Set maximum size for all buttons
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => RegisterMenu(userType: UserType.B));
                },
                child: Text(
                    style: TextStyle(
                        fontSize: 32,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    'مستفيد')),
            SizedBox(height: 12),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.8,
                        height * 0.055), // Set minimum size for all buttons
                    maximumSize: Size(width * 0.8,
                        height * 0.055), // Set maximum size for all buttons
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => RegisterMenu(userType: UserType.S));
                },
                child: Text(
                    style: TextStyle(
                        fontSize: 32,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    'مقدم خدمة')),
            Spacer(),
            GradientAnimatedWrapper
            (
              duration: Duration(seconds: 5),
              gradient: [Colors.blue, Colors.blue.shade900],
              child: Container
              (
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration
                (
                  backgroundBlendMode: BlendMode.dstOut,
                  color: Colors.white.withAlpha(192),
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(image: AssetImage('assets/images/logo.png')),
                ),
                child: SizedBox(height: height * 0.15, width: width * 0.9,)
              ),
            ),
            SizedBox(height: height * 0.025,)
          ],
        ),
      ),
    );
  }
}
