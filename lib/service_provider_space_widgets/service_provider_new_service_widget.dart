
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/new_service_widgets/new_service_companion_widget.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/new_service_widgets/new_service_consulting_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/animated_styled_widgets.dart';
import 'package:qadiroon_front_end/universal_widgets/map_viewer.dart';

class ServiceProviderNewServiceScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _ServiceProviderNewServiceScreenState();
  }

}

class _ServiceProviderNewServiceScreenState extends State<ServiceProviderNewServiceScreen>
{


  @override
  Widget build(BuildContext context)
  {
    return Column
    (
      children: 
      [
        StyledText(text: "اضافة خدمة جديدة", size: 56, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.center,),
        Spacer(),
        TextButton
        (
          style: ButtonStyle
          (
            
            backgroundColor: WidgetStatePropertyAll(Colors.white38)
          ),
          onPressed: (){showDialog(context: context, builder: (context) => NewServiceConsultingScreen());},
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: 
            [
              SizedBox(width: 16,),
              StyledText(text: "استشارة", size: 56, color: Colors.black87, fontFamily: "Amiri"),
              SizedBox(width: 16,),
              Icon(Icons.work, color: Colors.black87, size: 56,),
              SizedBox(width: 16,),
            ],
          ),
        ),
        Spacer(),
        GradientAnimatedWrapper(child: TextButton
        (
          style: ButtonStyle
          (
            
            backgroundColor: WidgetStatePropertyAll(Colors.white38)
          ),
          onPressed: () async {var location = await getCurrentLocationLatLng(); showDialog(context: context, builder: (context) => NewServiceCompanionScreen(initialLocation: location,));},
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: 
            [
              SizedBox(width: 16,),
              StyledText(text: "مرافقة", size: 56, color: Colors.black87, fontFamily: "Amiri"),
              SizedBox(width: 16,),
              Icon(Icons.elderly, color: Colors.black87, size: 56,),
              SizedBox(width: 16,),
            ],
          ),
        ), duration: const Duration(seconds: 3), gradient: [Colors.amber, Colors.blue]
        ),
        Spacer(),
        TextButton
        (
          style: ButtonStyle
          (
            
            backgroundColor: WidgetStatePropertyAll(Colors.white38)
          ),
          onPressed: (){},
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: 
            [
              SizedBox(width: 16,),
              StyledText(text: "توصيل", size: 56, color: Colors.black87, fontFamily: "Amiri"),
              SizedBox(width: 16,),
              Icon(Icons.mode_of_travel, color: Colors.black87, size: 56,),
              SizedBox(width: 16,),
            ],
          ),
        ),
        Row
        (
          children: 
          [
            Spacer(),
            GradientAnimatedWrapper(child: TextButton(onPressed: ()
            {
              showDialog(context: context, builder: (context)
              {
                return Container
                (
                  height: 256,
                  child: GradientAnimatedWrapper
                  (
                    gradient: [Colors.white54, Colors.white],
                    duration: const Duration(seconds: 1),
                    child: Column
                  (
                    children: 
                    [
                      const Spacer(),
                      StyledText(text: "عند تكوين خدمة جديدة استعمل وصفاً معبر وموجز, طول الوصف قد يأثر سلبياً على قدرة المستفيدين على ايجاد خدمتك", size: 36, color: Colors.white, fontFamily: "Amiri", alignment: TextAlign.right,),
                      Spacer(),
                      TextButton
                      (
                        onPressed: () {Navigator.pop(context);},
                        child: StyledText(text: "عد الى الوراء", size: 36, color: Colors.red, fontFamily: "Amiri"),
                      )
                    ],
                  ),
                ),
                  ); 
              },);
            }, child: GradientAnimatedIcon(icon: Icons.info, size: 36, gradient: [Colors.black, Colors.white]), style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),), duration: const Duration(seconds: 3), gradient: [Colors.yellow, Colors.blue]),
          ],
        )
      ]
    );
  }
  
}