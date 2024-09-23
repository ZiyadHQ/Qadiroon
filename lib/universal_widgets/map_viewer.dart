
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

LatLng getCurrentLocationLatLng()
{
  Geolocator.getCurrentPosition().then
  (
    (value)
    {
      return new LatLng(value.latitude, value.longitude);  
    },
  );
  return LatLng(0, 0);
}

class MapViewer extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return FlutterMap
    (
      options: MapOptions(initialCenter: getCurrentLocationLatLng()),
      children: 
      [
        TileLayer
        (
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 19,
        ),
        RichAttributionWidget
        (
          attributions: 
          [
            TextSourceAttribution
            (
              'OpenStreetMap contributors',
            )
          ],
        ),
        TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: "عد الى الوراء", size: 24, color: Colors.red, fontFamily: "Amiri"), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),)
      ],
    );
  }
}