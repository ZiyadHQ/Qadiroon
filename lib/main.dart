import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qadiroon_front_end/beneficiary_space_widgets/beneficiary_widget.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_widget.dart';
import 'package:qadiroon_front_end/start_widget.dart';
import 'firebase_options.dart';
import 'package:location/location.dart';

GlobalKey<_baseWidgetState> baseWidgetKey = GlobalKey<_baseWidgetState>();

void main_switchBaseWidget(Widget newWidget) {
  baseWidgetKey.currentState?._changeWidget(newWidget);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationSettings setting = await FirebaseMessaging.instance.requestPermission
  (
    alert: true,
    badge: true,
    sound: true
  );

  print("User Granted Permission: ${setting.authorizationStatus}, with FCM token: ${await FirebaseMessaging.instance.getToken()}");

  FirebaseMessaging.onBackgroundMessage((message) async {
    print("notif from: ${message.from}");
    print("notif Time: ${message.sentTime.toString()}");
    print("recieved notification message: ${message.data}");    
  },);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  runApp(MaterialApp(
      home: baseWidget(
    initialWidget: StartScreen(),
    key: baseWidgetKey,
  )));

  print('Started App!');
}

class baseWidget extends StatefulWidget {
  final Widget initialWidget;

  baseWidget({required Key key, required this.initialWidget}) : super(key: key);

  State<StatefulWidget> createState() {
    return _baseWidgetState();
  }
}

class _baseWidgetState extends State<baseWidget> {
  late Widget _currentWidget;

  @override
  void initState() {
    super.initState();
    _currentWidget = widget.initialWidget;
  }

  void _changeWidget(Widget newWidget) {
    setState(() {
      _currentWidget = newWidget;
    });
  }

  Widget build(BuildContext context) {
    return _currentWidget;
  }
}
