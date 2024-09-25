
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
    return FlutterMap
    (
      options: MapOptions(initialCenter: initialLocation),
      children: 
      [
        TileLayer
        (
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 19,
        ),
        const RichAttributionWidget
        (
          attributions: 
          [
            TextSourceAttribution
            (
              'OpenStreetMap contributors',
            )
          ],
        ),
        TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: "عد الى الوراء", size: 24, color: Colors.red, fontFamily: "Amiri"), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),),
        TextButton(onPressed: () async {try{print(await getCurrentLocationLatLng());}catch(e){print(e);}}, child: Text("Test TEXT"))
      ],
    );
  }
}