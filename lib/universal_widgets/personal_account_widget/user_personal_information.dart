
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_account.dart';

class UserPersonalInformationScreen extends StatelessWidget
{

  UserPersonalInformationScreen({required this.userData});

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Center
      (
        child: Flex
        (
          direction: Axis.vertical,
          children:
          [
            StyledText(text: "اسم المستخدم", size: 36, color: Colors.black87, fontFamily: "Amiri"),
            LabeledButton(function: (){}, icon: Icons.library_add, text: userData['Name']),
            Spacer(),
            TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: "عد للوراء", size: 36, color: Colors.red, fontFamily: "Amiri", alignment: TextAlign.right,)),
          ],
        ),
      ),
    );
  }

}