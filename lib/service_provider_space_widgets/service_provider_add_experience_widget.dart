
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class ServiceProviderAddExperienceScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _ServiceProviderAddExperienceScreenState();
  }

}

class _ServiceProviderAddExperienceScreenState extends State<ServiceProviderAddExperienceScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Center
      (
        child: Flex
        (
          direction: Axis.vertical,
          children: 
          [
            StyledText(text: "أضف خبرة جديدة لحسابك", size: 36, color: Colors.black87, fontFamily: "Amiri")
          ],
        ),
      ),
    );
  }

}