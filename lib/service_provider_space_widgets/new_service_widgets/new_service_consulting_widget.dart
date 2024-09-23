
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

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
            StyledText(text: "خدمات الإستشارة هي الخدمات المعنية بتقديم الاستشارة في مجال معين للجهة المستفيدة من قبل مفدمين خدمة خبراء في مجالهم", size: 24, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.right,),
            StyledText(text: "اجعل وصف الخدمة معبر وموجز", size: 24, color: Colors.black87, fontFamily: "Amiri", alignment: TextAlign.right,),
            Spacer(),
            Row
            (
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: 
              [
                Spacer(),
                TextButton(onPressed: (){Navigator.pop(context);}, child: StyledText(text: "الغاء", size: 36, color: Colors.red, fontFamily: "Amiri")),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.info_outline, size: 36, color: Colors.black,)),
                Spacer()
              ],
            )
          ],
        ),
      )
    ),
      )
    );
  }
  
}