
import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:qadiroon_front_end/data_stores/login_record.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/simple_alert_widget.dart';

final RegExp passWordRules = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

const UserTypeString = 
{
  UserType.B: 'مستفيد',
  UserType.S: 'مقدم خدمة'
};

class LoginMenu extends StatefulWidget
{

  LoginMenu({required this.userType});

  final UserType userType;

  State<StatefulWidget> createState()
  {
    return _LoginMenu(userType: userType);
  }
  
}

class _LoginMenu extends State<LoginMenu>
{

  _LoginMenu({required this.userType});

  UserType userType;

  void _saveName(String name)
  {
    Name = name;
  }
  void _savePassWord(String password)
  {
    PassWord = password;
    PassWordHash = BCrypt.hashpw(PassWord, BCrypt.gensalt());
  }
  void _checkInputRegister()
  {
    bool NameCheck = Name == 'Empty';
    bool PassWordCheck = PassWord == 'Empty';
    PassWordCheck |= !passWordRules.hasMatch(PassWord);
    if(NameCheck || PassWordCheck)
    {
      print("data inserted incorrectly");
      simple_alert_showWidget(context, 'تأكد انك أدخلت جميع البيانات بشكل صحيح');
    }

  }
  void _checkInputLogIn()
  {
    bool NameCheck = Name == 'Empty';
    bool PassWordCheck = PassWord == 'Empty';
    if(NameCheck || PassWordCheck)
    {
      print("data inserted incorrectly");
      simple_alert_showWidget(context, 'تأكد انك أدخلت جميع البيانات بشكل صحيح');
    }
    DateTime recordTime = DateTime.now();
    PassWordHash = BCrypt.hashpw(PassWord, BCrypt.gensalt());
    LoginRecord record = LoginRecord(Name: Name, issueTime: recordTime, PassWordHash: PassWordHash, userType: userType);
    print(record);
  }

  String Name = 'Empty';
  String PassWord = 'Empty';
  String PassWordHash = 'Empty';


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
            Text('يجب ان تحتوي كلمة السر على حرف كابيتال ورموز مميزو وأرقام'),
            SizedBox(height: 96),
            Row(
                children: [
                  const Spacer(),
                  TextButton(onPressed: (){print("Name: " + Name + " - PassWord: " + PassWord + " - Hash: " + PassWordHash); _checkInputLogIn();}, child: Text('تسجيل دخول')),
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