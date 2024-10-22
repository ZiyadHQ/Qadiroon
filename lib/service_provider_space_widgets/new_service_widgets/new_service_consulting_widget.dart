
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qadiroon_front_end/service_provider_space_widgets/service_provider_new_service_widget.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_hint.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_page_view.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';
import 'package:qadiroon_front_end/styled%20widgets/animated_styled_widgets.dart';

Future<bool> uploadConsultingService(BuildContext context,String userID, String name, String desc, ServiceType type, consultingServiceType subType, bool repeating) async
{

  showDialog(context: context, builder: (context) => CircularProgressIndicator.adaptive(),);

  Map<String, dynamic> data = 
  {
    'userID' : userID,
    'name' : name,
    'description' : desc,
    'serviceType' : type.toString(),
    'subType' : subType.toString(),
    'repeating' : repeating.toString(),
    'visible' : true
  };

  try
  {
    await FirebaseFirestore.instance.collection('Service').doc().set(data); 
  } catch (e)
  {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل اضافة الخدمة")));
    print("ERROR ADDING NEW CONSULTING SERVICE: $e");
    return false;
  }

  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تمت اضافة الخدمة بنجاح")));
  return true;
}

enum consultingServiceType
{
  Legal,
  Business,
  Technical,
  Health,
}

Map<consultingServiceType, Color> serviceToColor = 
{
  consultingServiceType.Legal : Colors.blue.shade300,
  consultingServiceType.Health : Colors.red.shade300,
  consultingServiceType.Business : Colors.green.shade300,
  consultingServiceType.Technical : Colors.orange.shade300
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

  ServiceType serviceType = ServiceType.Consulting;
  consultingServiceType activeService = consultingServiceType.Legal;
  bool repeatService = false;

  //input controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    DateTime.now().millisecondsSinceEpoch;
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
                StyledText(text: "خدمات الإستشارة هي الخدمات المعنية بتقديم الاستشارة في مجال معين للجهة المستفيدة من قبل مفدمين خدمة خبراء في مجالهم", size: 18, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.center),
                StyledText(text: "اعط خدمتك اسماً قصيراً ومعبر, لا تعط وصفاً مفصلاً في خانة الاسم, استعمل خانة الوصف للتفصيل, الاسم اول ما يعرض للمستفيدين عند تصفحهم للخدمات, يجب الا يتعدى 30 حرف", size: 18, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.center),
                StyledText(text: "عند كتابة الوصف, ارفق طرق ثانوية للتواصل مع المستفيد", size: 18, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.center)
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
              ServiceTypeButton(function: (){activeService = consultingServiceType.Legal; setState((){});}, color: (activeService == consultingServiceType.Legal)? Colors.blue: Colors.black87, text: "قانوني"),
              ServiceTypeButton(function: (){activeService = consultingServiceType.Business; setState((){});}, color: (activeService == consultingServiceType.Business)? Colors.green: Colors.black87, text: "أعمال"),
              ServiceTypeButton(function: (){activeService = consultingServiceType.Technical; setState((){});}, color: (activeService == consultingServiceType.Technical)? Colors.orange: Colors.black87, text: "تقني"),
              ServiceTypeButton(function: (){activeService = consultingServiceType.Health; setState((){});}, color: (activeService == consultingServiceType.Health)? Colors.red: Colors.black87, text: "صحى"),
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
            maxLength: 30,
            controller: nameController,
          ),
          SizedBox(height: height * 0.05,),
          StyledText(text: ":وصف الخدمة", size: 36, color: Colors.black, fontFamily: "Amiri", alignment: TextAlign.right,),
          CupertinoTextField
          (
            controller: descriptionController,
            expands: true,
            maxLines: null,
            minLines: null,
          ),
          TextButton(onPressed: (){print("name: ${nameController.text}, desc: ${descriptionController.text}, type: ${serviceType}, subtype: ${activeService}, repeating: ${repeatService}");}, child: Text("debug print")),
          TextButton(onPressed: () async {bool success = await uploadConsultingService(context, FirebaseAuth.instance.currentUser!.uid, nameController.text, descriptionController.text, serviceType, activeService, repeatService); if(success){Navigator.pop(context);}}, child: Text("upload")),
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