

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_widget.dart';
import 'package:qadiroon_front_end/data_stores/login_record.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_widget.dart';
import 'package:qadiroon_front_end/simple_alert_widgets.dart';

final RegExp passWordRules = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

const UserTypeString = 
{
  UserType.B: 'مستفيد',
  UserType.S: 'مقدم خدمة'
};

void testFunct()
{

}

class RegisterMenu extends StatefulWidget
{

  RegisterMenu({required this.userType,  this.changeBaseWidget = testFunct });

  final UserType userType;
  Function changeBaseWidget;

  State<StatefulWidget> createState()
  {
    return _RegisterMenu(userType: userType, changeBaseWidget: changeBaseWidget);
  }
  
}

class _RegisterMenu extends State<RegisterMenu>
{

  _RegisterMenu({required this.userType, required this.changeBaseWidget});

  UserType userType;

  void _saveName(String name)
  {
    Name = name;
  }
  void _savePassWord(String password)
  {
    PassWord = password;
  }
  void _checkInputRegister() async
  {
    bool NameCheck = (Name == 'Empty');
    bool PassWordCheck = PassWord == 'Empty';
    PassWordCheck |= !passWordRules.hasMatch(PassWord);
    if(NameCheck || PassWordCheck)
    {
      print("data inserted incorrectly");
      simple_alert_showWidget(context, 'تأكد انك أدخلت جميع البيانات بشكل صحيح');
      return;
    }
    simple_alert_showWidget(context, 'محاولة تسجيل حساب جديد, يرجى الانتظار', isDismissible: false);
    DateTime recordTime = DateTime.now();
    LoginRecord record = LoginRecord(Name: Name, issueTime: recordTime, passWord: PassWord, userType: userType);

    bool checkAuthRegister = await record.checkRegisterAttempt();

    Navigator.pop(context);

    if(checkAuthRegister)
    {
      simple_alert_showWidget(context, 'تم التسجيل بنجاح');
    }
    else
    {
      simple_alert_showWidget(context, 'فشل التسجيل');
    }
  }

  String Name = 'Empty';
  String PassWord = 'Empty';
  String PassWordHash = 'Empty';
  Function changeBaseWidget;

  Widget build(BuildContext context)
  {
    return ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child: Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w600
              ),
              UserTypeString[this.userType]!
            ),
            TextField(
              onChanged: _saveName,
              maxLength: 50,
              decoration: InputDecoration(
                constraints: BoxConstraints.tight(Size(300, 50)),
                label: const Text('الاسم')
              ),
            ),
            SizedBox(height: 48,),
            TextField(
              onChanged: _savePassWord,
              maxLength: 50,
              obscureText: true,
              decoration: InputDecoration(
                constraints: BoxConstraints.tight(Size(300, 50)),
                label: const Text('كلمة السر')
              ),
            ),
            Text('يجب ان تحتوي كلمة السر على حرف كابيتال ورموز مميزة وأرقام'),
            SizedBox(height: 96),
            Row(
                children: [
                  const Spacer(),
                  TextButton(onPressed: (){print("Name: " + Name + " - PassWord: " + PassWord + " - Hash: " + PassWordHash); _checkInputRegister();}, child: const Text('تسجيل')),
                  const Spacer()
                ],
              ),
              Spacer(),
            TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('عد الى الوراء'))
          ],
        )
      ),
    ),
    );
  }

}