
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/styled%20widgets/animated_styled_widgets.dart';
import 'package:qadiroon_front_end/universal_widgets/map_viewer.dart';

class NewServiceCompanionScreen extends StatefulWidget
{

  NewServiceCompanionScreen({this.initialLocation = const LatLng(0, 0)});

  LatLng initialLocation;

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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MapViewer
    (
      initialLocation: LatLng(0, 0),
    );
  }
  
}