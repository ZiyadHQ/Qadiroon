
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/new_service_widgets/new_service_consulting_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_hint.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class ConsultingDisplayWidget extends StatelessWidget
{

  ConsultingDisplayWidget({required this.serviceData});
  Map<String, dynamic> serviceData;

  @override
  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return TextButton
    (
      onPressed: (){showDialog(context: context, builder: (context) => ConsultingDetailedWidget(serviceData: serviceData,));},
      child: Container
      (
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: Colors.lightBlue),
        height: height * 0.15,
        child: Column
        (
          children:
          [
            StyledText(text: serviceData['name'], size: 24, color: Colors.black, fontFamily: "Amiri"),
            //StyledText(text: serviceData['description'], size: 8, color: Colors.black, fontFamily: "Amiri"),
            StyledText(text: serviceData['serviceType'], size: 24, color: Colors.black, fontFamily: "Amiri"),
            StyledText(text: serviceData['subType'], size: 24, color: Colors.black, fontFamily: "Amiri"),
            //Icon(Icons.repeat, color: (serviceData['repeating'] == 'true')? Colors.blue : Colors.red) 
          ],
        ),
      ),
    );
  }

}

class ConsultingDetailedWidget extends StatelessWidget
{

  ConsultingDetailedWidget({required this.serviceData});
  Map<String, dynamic> serviceData;

  @override
  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Dialog
    (
      child: Column
      (
        children:
        [
          StyledText(text: serviceData['name'], size: 32, color: Colors.black, fontFamily: "Amiri"),
          Container
          (
            height: height * 0.5,
            child: ListView
            (
              scrollDirection: Axis.vertical,
              children: [StyledText(text: serviceData['description'], size: 14, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.center,)],
            ),
          ),
          StyledText(text: serviceData['serviceType'], size: 14, color: Colors.black, fontFamily: "Amiri"),
          StyledText(text: serviceData['subType'], size: 14, color: Colors.black, fontFamily: "Amiri"),
          Icon(Icons.repeat, color: (serviceData['repeating'] == 'true')? Colors.blue : Colors.red) 
        ],
      ),
    );
  }

}