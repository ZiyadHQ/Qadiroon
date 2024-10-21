import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/simple_alert_widgets.dart';
import 'package:qadiroon_front_end/data_stores/login_record.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_widget.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_home_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_widget.dart';

void testFunct() {}

class LoginMenu extends StatefulWidget {
  LoginMenu({super.key});

  State<StatefulWidget> createState() {
    return _LoginMenu();
  }
}

class _LoginMenu extends State<LoginMenu> {
  _LoginMenu();

  void _saveName(String name) {
    Name = name;
  }

  void _savePassWord(String password) {
    PassWord = password;
  }

  void _checkInputLogIn() async {
    bool NameCheck = Name == 'Empty';
    bool PassWordCheck = PassWord == 'Empty';
    if (NameCheck || PassWordCheck) {
      simple_alert_showWidget(
          context, 'تأكد انك أدخلت جميع البيانات بشكل صحيح');
      return;
    }
    DateTime recordTime = DateTime.now();
    LoginRecord record = LoginRecord(
        Name: Name,
        issueTime: recordTime,
        passWord: PassWord,
        userType: UserType.B);

    //simple_alert_showWidget(context, 'محاولة تسجيل الدخول, يرجى الانتظار', isDismissible: false);
    simple_rotating_loading_screen(context,
        message: 'محاولة تسجيل الدخول, يرجى الانتظار',
        backgroundColor: Colors.amber);

    UserCredential? userCredential = await record.checkLogInAttempt();

    Navigator.pop(context);

    bool loginCheck = userCredential != null;
    if (loginCheck) {
      FirebaseFirestore _database = FirebaseFirestore.instance;
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await _database
          .collection('User')
          .doc(userCredential.user!.uid)
          .get();
      Map<String, dynamic> userData =
          docSnapshot.data() as Map<String, dynamic>;
      String user_name = userData['Name'];

      var Token = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection('UserPrivate')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'FCMToken': Token.toString()});

      Navigator.pop(context);
      simple_alert_showWidget(
          context, '$user_name تم تسجيل الدخول بنجاح, أهلا');
      main_switchBaseWidget((userData['userType'] == 'UserType.S')
          ? ServiceProviderScreen(
              user: docSnapshot,
              key: globalServiceProviderStateKey,
            )
          : BeneficiaryScreen(
              userData: userData,
              key: globalBenificiaryStateKey,
            ));
    } else {
      simple_alert_showWidget(context, 'تسجيل الدخول فشل');
    }
  }

  String Name = 'Empty';
  String PassWord = 'Empty';
  String PassWordHash = 'Empty';

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child: Scaffold(
        backgroundColor: Color(0xFF2B448C),
        body: Center(
            child: Column(
          children: [
            Spacer(),
            Text(
                style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                'تسجيل الدخول'),
            TextField(
              onChanged: _saveName,
              maxLength: 50,
              style: TextStyle(
                color: Colors.white, // Change the text being typed to white
                fontSize:
                    16, // Optionally change the font size of the typed text
              ),
              decoration: InputDecoration(
                filled: true, // Enable the background color
                fillColor: const Color.fromARGB(
                    255, 255, 255, 255), // Set the background color to yellow
                //contentPadding:
                //EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Colors.black), // Set the outline color to black
                ),
                constraints: BoxConstraints.tight(Size(300, 60)),
                hintText: 'الاسم',
                hintStyle: TextStyle(
                    color:
                        const Color.fromARGB(255, 0, 0, 0)), // Label text color
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Colors.black, // Set the focused outline color to black
                    width: 2.0,
                  ),
                  borderRadius:
                      BorderRadius.circular(18), // Rounded corners when focused
                ),
                counterStyle: TextStyle(
                  color:
                      Colors.white, // Change max length counter color to white
                ),
              ),
            ),
            SizedBox(
              height: 48,
            ),
            TextField(
              onChanged: _saveName,
              maxLength: 50,
              style: TextStyle(
                color: Colors.white, // Change the text being typed to white
                fontSize:
                    16, // Optionally change the font size of the typed text
              ),
              decoration: InputDecoration(
                filled: true, // Enable the background color
                fillColor: const Color.fromARGB(
                    255, 255, 255, 255), // Set the background color to yellow
                //contentPadding:
                //EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                      color: Colors.black), // Set the outline color to black
                ),
                constraints: BoxConstraints.tight(Size(300, 60)),
                hintText: 'كلمة المرور',
                hintStyle: TextStyle(
                    color:
                        const Color.fromARGB(255, 0, 0, 0)), // Label text color
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Colors.black, // Set the focused outline color to black
                    width: 2.0,
                  ),
                  borderRadius:
                      BorderRadius.circular(18), // Rounded corners when focused
                ),
                counterStyle: TextStyle(
                  color:
                      Colors.white, // Change max length counter color to white
                ),
              ),
            ),
            Text(
              'يجب ان تحتوي كلمة السر على حرف كابيتال ورموز مميزة وأرقام',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 96),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(width * 0.75,
                            height * 0.058), // Set minimum size for all buttons
                        maximumSize: Size(width * 0.75,
                            height * 0.058), // Set maximum size for all buttons
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255)),
                    onPressed: () {
                      print("Name: " +
                          Name +
                          " - PassWord: " +
                          PassWord +
                          " - Hash: " +
                          PassWordHash);
                      _checkInputLogIn();
                    },
                    child: Text(
                        style: TextStyle(
                            fontSize: 28,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        'تسجيل الدخول')),
                const Spacer(),
              ],
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.35,
                        height * 0.035), // Set minimum size for all buttons
                    maximumSize: Size(width * 0.35,
                        height * 0.035), // Set maximum size for all buttons
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    'عد الى الوراء')),
          ],
        )),
      ),
    );
  }
}
