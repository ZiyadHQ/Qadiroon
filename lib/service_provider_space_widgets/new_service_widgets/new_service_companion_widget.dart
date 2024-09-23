
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/animated_styled_widgets.dart';
import 'package:qadiroon_front_end/universal_widgets/map_viewer.dart';

class NewServiceCompanionScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _NewServiceCompanionScreenState();
  }

}

class _NewServiceCompanionScreenState extends State<NewServiceCompanionScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return 
    
       MapViewer()
    ;
  }
  
}