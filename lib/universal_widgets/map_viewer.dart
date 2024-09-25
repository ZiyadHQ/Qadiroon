
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

Future<LatLng> getCurrentLocationLatLng() async
{

  bool serviceEnabled = await Location.instance.serviceEnabled();
  if(!serviceEnabled)
  {
    await Location.instance.requestPermission();
    serviceEnabled = await Location.instance.requestService();
    if(serviceEnabled)
    {
      print("Taking location!");
      LocationData location = await Location.instance.getLocation();
      var temp = LatLng(location.latitude!, location.longitude!);
      print("${temp.latitude}, ${temp.longitude}");
      return temp;
    }
  }
  else
  {
    print("Taking location!");
      LocationData location = await Location.instance.getLocation();
      var temp = LatLng(location.latitude!, location.longitude!);
      print("${temp.latitude}, ${temp.longitude}");
      return temp;
  }

  return LatLng(0, 0);
}

class MapViewer extends StatelessWidget
{

  MapViewer({this.initialLocation = const LatLng(0, 0)});

  LatLng initialLocation;

  @override
  Widget build(BuildContext context)
  {
    return GoogleMap
    (
      initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
    );
  }
}