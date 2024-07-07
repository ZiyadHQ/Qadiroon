
import 'package:flutter/material.dart';

enum LoginType {
  B,
  S
}

const LoginTypeString = 
{
  LoginType.B: 'مستفيد',
  LoginType.S: 'مقدم خدمة'
};

class LoginMenu extends StatefulWidget
{

  LoginMenu({required this.type});

  final LoginType type;

  State<StatefulWidget> createState()
  {
    return _LoginMenu(type: type);
  }
  
}

class _LoginMenu extends State<LoginMenu>
{

  _LoginMenu({required this.type});

  LoginType type;

  void _saveName(String name)
  {
    Name = name;
  }
  void _savePassWord(String password)
  {
    PassWord = password;
  }

  String Name = 'Empty';
  String PassWord = 'Empty';

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
              LoginTypeString[this.type]!
            ),
            TextField(
              onChanged: _saveName,
              maxLength: 50,
              decoration: InputDecoration(
                constraints: BoxConstraints.tight(Size(300, 50)),
                label: Text('الاسم')
              ),
            ),
            TextField(
              onChanged: _savePassWord,
              maxLength: 50,
              decoration: InputDecoration(
                constraints: BoxConstraints.tight(Size(300, 50)),
                label: Text('كلمة السر')
              ),
            ),
            Expanded(
              child: Center(
                child: Row(
                children: [
                  TextButton(onPressed: (){print("Name: " + Name + " - " + "PassWord: " + PassWord);}, child: Text('تسجيل دخول')),
                  TextButton(onPressed: (){}, child: Text('تسجيل'))
                ],
              ),
              ),
            ),
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text('عد الى الوراء')),
            Spacer()
          ],
        )
      ),
    ),
    );
  }

}