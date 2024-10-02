
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_credits_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_home_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_info_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_new_service_widget.dart';
import 'package:qadiroon_front_end/start_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/personal_account_widget/user_personal_account.dart';

//WARNING!! MUST ONLY BE USED FOR CHILD WIDGETS OF THIS WIDGET !!WARNING
GlobalKey<_serviceProviderScreenState> globalServiceProviderStateKey = GlobalKey<_serviceProviderScreenState>();
void serviceProvider_changeBaseWidget(Widget newWidget)
{
  globalServiceProviderStateKey.currentState?._changeWidget(newWidget);
}

class ServiceProviderScreen extends StatefulWidget
{

  ServiceProviderScreen({super.key, required this.user});

  final UserCredential user;
  final Widget initialWidget = serviceProviderHomeScreen();

  State<StatefulWidget> createState()
  {
    return _serviceProviderScreenState();
  }

}

class _serviceProviderScreenState extends State<ServiceProviderScreen>
{

  late Widget _currentWidget;
  Map<String, dynamic> userData = {};

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

  void _changeWidget(Widget widget)
  {
    setState(() {
      _currentWidget = widget;
    });
  }

  Widget build(BuildContext context)
  {
    return Scaffold(
      drawerScrimColor: Colors.amber,
      backgroundColor: Colors.blueGrey.shade700,
      appBar: Tab(child: ListView(
        scrollDirection:  Axis.horizontal,
        children: [
          SizedBox(width: 32,),
          StyledText(text: userData?['Name']?? 'Default', size: 36, color: Colors.blueGrey, fontFamily: 'Amiri'),
          SizedBox(width: 72,),
          StyledText(text: userData?['userType']?? 'Default', size: 36, color: Colors.blueGrey, fontFamily: 'Amiri'),
          SizedBox(width: 72,),
          StyledText(text: FirebaseAuth.instance.currentUser?.uid?? 'Default', size: 36, color: Colors.blueGrey, fontFamily: 'Amiri')
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
                    backgroundColor: Colors.transparent,
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
              icon: Icon(color: Colors.red.shade900,Icons.logout_sharp),
            ),
            SizedBox(width: 32),
            IconButton(onPressed: (){if(_currentWidget != serviceProviderHomeScreen()){serviceProvider_changeBaseWidget(serviceProviderHomeScreen());}}, icon: (_currentWidget is serviceProviderHomeScreen)? Icon(color: Colors.white,Icons.home_outlined) : Icon(Icons.home_outlined)),
            SizedBox(width: 32),
            IconButton(onPressed: (){if(_currentWidget != userPersonalAccountScreen){serviceProvider_changeBaseWidget(userPersonalAccountScreen(userData: userData));}}, icon: (_currentWidget is userPersonalAccountScreen)? Icon(color: Colors.white,Icons.account_box) : Icon(Icons.account_box)),
            SizedBox(width: 32),
            IconButton(onPressed: (){if(_currentWidget != serviceProviderCreditsScreen()){serviceProvider_changeBaseWidget(serviceProviderCreditsScreen());}}, icon: (_currentWidget is serviceProviderCreditsScreen)? Icon(color: Colors.white,Icons.info) : Icon(Icons.info)),
            SizedBox(width: 32),
            IconButton(onPressed: (){if(_currentWidget != ServiceProviderNewServiceScreen()){serviceProvider_changeBaseWidget(ServiceProviderNewServiceScreen());}}, icon: (_currentWidget is ServiceProviderNewServiceScreen)? Icon(color: Colors.white,Icons.search) : Icon(Icons.search))
          ],
        ),
      ),
    );
  }

}
