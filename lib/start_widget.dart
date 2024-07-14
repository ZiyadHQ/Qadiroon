
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/login_widget.dart';
import 'package:qadiroon_front_end/register_widget.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:qadiroon_front_end/service_provider_widget.dart';

class StartScreen extends StatelessWidget
{

  StartScreen({super.key});

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
              'أو سجل كـ',
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
          ],
        ),
      ),
    );
  }

}