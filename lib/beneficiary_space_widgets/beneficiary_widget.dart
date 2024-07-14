

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_game_widget.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_home_widget.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_info_widget.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:qadiroon_front_end/start_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

//WARNING!! MUST ONLY BE USED FOR CHILD WIDGETS OF THIS WIDGET !!WARNING
GlobalKey<_BeneficiaryScreenState> globalBenificiaryStateKey = GlobalKey<_BeneficiaryScreenState>();
void Beneficiary_changeBaseWidget(Widget newWidget)
{
  globalBenificiaryStateKey.currentState?._changeWidget(newWidget);
}


class BeneficiaryScreen extends StatefulWidget
{

  BeneficiaryScreen({required Key key, required this.user, required this.initialWidget}) : super(key: key);

  final Widget initialWidget;
  final UserCredential user;

  State<StatefulWidget> createState()
  {
    return _BeneficiaryScreenState();
  }

}

class _BeneficiaryScreenState extends State<BeneficiaryScreen>
{

  late Widget _currentWidget;

  void _changeWidget(Widget newWidget)
  {
    setState(
      ()
      {
        _currentWidget = newWidget;
      }
    );
  }

  Map<String, dynamic>? userData;
  @override
  void initState()
  {
    super.initState();
    _currentWidget = widget.initialWidget;
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
          StyledText(text: userData?['Name']?? 'Default', size: 36, color: Colors.blueGrey, fontFamily: 'Amiri'),
          SizedBox(width: 72,),
          StyledText(text: userData?['userType']?? 'Default', size: 36, color: Colors.blueGrey, fontFamily: 'Amiri')
        ],
      )),
      body: Center(
        child: _currentWidget,
      ),
      bottomNavigationBar: Tab(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(
              onPressed: ()
              {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => 
                  Scaffold(
                    body: Center(
                      child: Row(
                      children: [
                        TextButton(
                              onPressed: (){Navigator.pop(context);},
                              child: StyledText(text: 'لا', size: 24, color: Colors.grey, fontFamily: 'Amiri'),
                        ),
                        TextButton(
                              onPressed: (){FirebaseAuth.instance.signOut(); Navigator.pop(context); main_switchBaseWidget(StartScreen());},
                              child: StyledText(text: 'نعم', size: 24, color: Colors.grey, fontFamily: 'Amiri'),
                        ),
                        StyledText(text: 'تسجيل الخروج؟', size: 36, color: Colors.black87, fontFamily: 'Amiri'),
                      ],
                    ),
                    ),
                  )
                );
              },
              icon: Icon(Icons.logout_sharp),
            ),
            SizedBox(width: 32),
            IconButton(onPressed: (){if(_currentWidget != BeneficiaryHomeScreen){Beneficiary_changeBaseWidget(BeneficiaryHomeScreen());}}, icon: Icon(Icons.home_outlined)),
            SizedBox(width: 32),
            IconButton(onPressed: (){if(_currentWidget != BeneficiaryGameScreen()){Beneficiary_changeBaseWidget(BeneficiaryGameScreen());}}, icon: Icon(Icons.gamepad_outlined)),
            SizedBox(width: 32),
            IconButton(onPressed: (){if(_currentWidget != BeneficiaryGameScreen()){Beneficiary_changeBaseWidget(BeneficiaryInfoScreen());}}, icon: Icon(Icons.account_box)),
            SizedBox(width: 32),
            IconButton(onPressed: (){}, icon: Icon(Icons.info)),
          ],
        ),
      ),
    );
  }

}
