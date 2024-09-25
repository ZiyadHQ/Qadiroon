
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/universal_widgets/animated_styled_widgets.dart';

enum ServiceType
{
  Legal,
  Business,
  Technical
}

Map<ServiceType, Color> serviceToColor = 
{
  ServiceType.Legal : Colors.blueGrey,
  ServiceType.Business : Colors.green,
  ServiceType.Technical : Colors.orange
};

class NewServiceConsultingScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewServiceConsultingScreenState();
  }

}

class _NewServiceConsultingScreenState extends State<NewServiceConsultingScreen>
{

  ServiceType activeService = ServiceType.Legal;

  @override
  Widget build(BuildContext context) 
  {
    return ClipRRect
    (
      borderRadius: BorderRadius.circular(24),
      child: DecoratedBox
      (
        decoration: BoxDecoration(gradient: LinearGradient(colors:
        [Colors.transparent, Colors.white70, Colors.white54, Colors.blueGrey, Colors.white54, Colors.white70, Colors.transparent]
        , begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Scaffold
    (
      backgroundColor: Colors.white70,
      body: Center
      (
        child: Column
        (
          children: 
          [
            StyledText(text: "خدمات الإستشارة هي الخدمات المعنية بتقديم الاستشارة في مجال معين للجهة المستفيدة من قبل مفدمين خدمة خبراء في مجالهم", size: 18, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.right,),
            Spacer(),
            Row
            (
              children: 
              [
                Expanded(
                  child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      ServiceTypeButton(function: (){activeService = ServiceType.Legal; setState((){});}, color: (activeService == ServiceType.Legal)? Colors.blue: Colors.black87, text: "قانون"),
                      ServiceTypeButton(function: (){activeService = ServiceType.Business; setState((){});}, color: (activeService == ServiceType.Business)? Colors.green: Colors.black87, text: "أعمال"),
                      ServiceTypeButton(function: (){activeService = ServiceType.Technical; setState((){});}, color: (activeService == ServiceType.Technical)? Colors.orange: Colors.black87, text: "تقني"),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancle"))
          ],
        ),
      )
    ),
      )
    );
  }
  
}

class ServiceTypeButton extends StatelessWidget
{

  ServiceTypeButton({required this.function, required this.color, required this.text});

  final void Function() function;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context)
  {
    return TextButton
    (
      onPressed: function,
      child: StyledText(text: text, size: 36, color: color, fontFamily: "Amiri"),
      style: ButtonStyle
      (
        backgroundColor: WidgetStatePropertyAll(Colors.white) 
      ),
    );
  }
  
}
