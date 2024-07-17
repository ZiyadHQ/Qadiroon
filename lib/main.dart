import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qadiroon_front_end/start_widget.dart';
import 'firebase_options.dart';

GlobalKey<_baseWidgetState> baseWidgetKey = GlobalKey<_baseWidgetState>();

void main_switchBaseWidget(Widget newWidget)
{
  baseWidgetKey.currentState?._changeWidget(newWidget);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  print('Started App!');
  runApp(
    MaterialApp(
      home: baseWidget(initialWidget: StartScreen(), key: baseWidgetKey,)
    )
  );
}

class baseWidget extends StatefulWidget
{

  final Widget initialWidget;

  baseWidget({required Key key, required this.initialWidget}) : super(key: key);

  State<StatefulWidget> createState()
  {
    return _baseWidgetState();
  }
  
}

class _baseWidgetState extends State<baseWidget>
{

  late Widget _currentWidget;

  @override
  void initState()
  {
    super.initState();
    _currentWidget = widget.initialWidget;
  }

  void _changeWidget(Widget newWidget)
  {
    setState(
      ()
      {
        _currentWidget = newWidget;
      }
    );
  }

  Widget build(BuildContext context)
  {
    return _currentWidget;
  }
  
}