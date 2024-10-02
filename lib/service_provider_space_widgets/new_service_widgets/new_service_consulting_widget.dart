
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_hint.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_page_view.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/styled%20widgets/animated_styled_widgets.dart';

enum ServiceType
{
  Legal,
  Business,
  Technical,
  Health,
  Family
}

Map<ServiceType, Color> serviceToColor = 
{
  ServiceType.Legal : Colors.blue.shade300,
  ServiceType.Family : Colors.green.shade300,
  ServiceType.Health : Colors.red.shade300,
  ServiceType.Business : Colors.green.shade300,
  ServiceType.Technical : Colors.orange.shade300
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

  @override
  void dispose()
  {
    nameController.dispose();
    super.dispose();
  }

  void showHintWidget() async
  {
    ScaffoldMessenger.of(context).showSnackBar
    (
      SnackBar
      (
        duration: const Duration(minutes: 1),
        content: StyledText
        (
          color: Colors.black87,
          fontFamily: "Amiri",
          size: 36,
          text: "خاصية التكرار ستعيد عرض هذه الخدمة للمستفيدين تلقائياً بعد اكتمال الخدمة, عند عدم تفعيل هذه الخاصية لن تظهر الخدمة مجدداً للمستفيدين بعد انتهائها",
          alignment: TextAlign.right,
        )
      )
    );
  }

  ServiceType activeService = ServiceType.Legal;
  bool repeatService = false;

  //input controllers
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ClipRRect
    (
      borderRadius: BorderRadius.circular(24),
      child: Scaffold
      (
        backgroundColor: Colors.lightBlue.shade200,
        body: Center
            (
              child: ListView
              (
        children: 
        [
          SizedBox(height: height * 0.025),
          SizedBox(
            height: height * 0.12,
            child: StyledPageView
            (
              children: 
              [
                StyledText(text: "خدمات الإستشارة هي الخدمات المعنية بتقديم الاستشارة في مجال معين للجهة المستفيدة من قبل مفدمين خدمة خبراء في مجالهم", size: 20, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.center),
                StyledText(text: "اعط خدمتك اسماً قصيراً ومعبر, لا تعط وصفاً مفصلاً في خانة الاسم, استعمل خانة الوصف للتفصيل, الاسم اول ما يعرض للمستفيدين عند تصفحهم للخدمات", size: 20, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.center),
                StyledText(text: "عند كتابة الوصف, ارفق طرق ثانوية للتواصل مع المستفيد", size: 20, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.center)
              ],
            ),
          ),
          SizedBox(height: height * 0.1,),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              GradientAnimatedWrapper
              (
                child: IconButton(onPressed: (){showHintWidget();}, icon: Icon(Icons.info, size: 54, color: Colors.white,)),
                duration: const Duration(seconds: 5),
                gradient: [Colors.blue, Colors.black45],
              ),
              ServiceTypeButton
              (
                color: (repeatService)? Colors.blue : Colors.black,
                function: (){setState((){repeatService = !repeatService;});},
                text: "تكرار الخدمة",
              )
            ],
          ),
          SizedBox(height: height * 0.1,),
          StyledText(text: ":نوع الخدمة", size: 36, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.right,),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              ServiceTypeButton(function: (){activeService = ServiceType.Legal; setState((){});}, color: (activeService == ServiceType.Legal)? Colors.blue: Colors.black87, text: "قانوني"),
              ServiceTypeButton(function: (){activeService = ServiceType.Business; setState((){});}, color: (activeService == ServiceType.Business)? Colors.green: Colors.black87, text: "أعمال"),
              ServiceTypeButton(function: (){activeService = ServiceType.Technical; setState((){});}, color: (activeService == ServiceType.Technical)? Colors.orange: Colors.black87, text: "تقني"),
              ServiceTypeButton(function: (){activeService = ServiceType.Health; setState((){});}, color: (activeService == ServiceType.Health)? Colors.red: Colors.black87, text: "صحى"),
              ServiceTypeButton(function: (){activeService = ServiceType.Family; setState((){});}, color: (activeService == ServiceType.Family)? Colors.green: Colors.black87, text: "عائلي"),
            ],
          ),
          SizedBox(height: height * 0.1,),
          StyledText
          (
            color: Colors.black87,
            fontFamily: "Amiri",
            size: 36,
            alignment: TextAlign.right,
            text: ":اسم الخدمة",
          ),
          CupertinoTextField
          (
            controller: nameController,
          ),
          TextButton(onPressed: (){showDialog(context: context, builder: (context) => AlertDialog(content: Text(nameController.text),),);}, child: Text("Print text")),
          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancle"))
        ],
      ),
            )
          )
    );
  }
  
}

class ServiceTypeButton extends StatelessWidget
{

  ServiceTypeButton({required this.function, required this.color, required this.text, this.backgroundColor = Colors.white});

  final void Function() function;
  final Color color;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context)
  {

    return TextButton
    (
      onPressed: function,
      child: StyledText(text: text, size: 36, color: color, fontFamily: "Amiri"),
      style: ButtonStyle
      (
        backgroundColor: WidgetStatePropertyAll(backgroundColor) 
      ),
    );
  }
  
}