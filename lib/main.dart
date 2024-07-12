import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/start_widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Started App!');
  runApp(
    MaterialApp(
      home: baseWidget(BaseWidget: StartScreen())
    )
  );
}

class baseWidget extends StatefulWidget
{

  baseWidget({super.key, required this.BaseWidget});

  Widget BaseWidget;

  State<StatefulWidget> createState()
  {
    return _baseWidgetState( baseWidget: BaseWidget );
  }
  
}

class _baseWidgetState extends State<baseWidget>
{

  _baseWidgetState({required this.baseWidget});

  Widget baseWidget;

  void _changeWidget(Widget newWidget)
  {
    setState(
      ()
      {
        baseWidget = newWidget;
      }
    );
  }

  Widget build(BuildContext context)
  {
    return baseWidget;
  }
  
}