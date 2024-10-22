
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/animated_styled_widgets.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

void simple_alert_showWidget(BuildContext context, String message, {Color backgroundColor = Colors.white, bool isDismissible = true})
{
  showModalBottomSheet(context: context, builder: (context) => SimpleAlert(Message: message, backgroundColor: backgroundColor),isDismissible: isDismissible);
}

void simple_rotating_loading_screen(BuildContext context, {String message = '', Color backgroundColor = Colors.transparent, bool isDismissible = true})
{
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  WidgetsBinding.instance.addPostFrameCallback
  (
    (_){
      showDialog(context: context,
      builder: ((context) => 
      GradientAnimatedWrapper
      (
        duration: Duration(seconds: 2),
        gradient: [Colors.white, Colors.white54],
        child: Dialog(
          elevation: 5,
          shadowColor: Colors.white,
          child: SizedBox
          (
            height: height * 0.15,
            child: Center
            (
              child: StyledText(text: message, size: 24, color: Colors.black, fontFamily: 'Tajawal', alignment: TextAlign.center,),
            ),
          ),
        ),
      )),
      barrierDismissible: isDismissible
      );    
      }
  );

  /*showModalBottomSheet(context: context, builder: ((context) => Column(
    children: [
      StyledText(text: message, size: 24, color: backgroundColor, fontFamily: 'default'),
      Spacer(),
      CircularProgressIndicator.adaptive(backgroundColor: backgroundColor),
      Spacer()
    ],
  )),
  isDismissible: isDismissible 
  );*/
}

class SimpleAlert extends StatelessWidget
{
  SimpleAlert({required this.Message, this.backgroundColor = Colors.white});

  final String Message;
  final Color backgroundColor;

  Widget build(BuildContext context)
  {
    return SizedBox.fromSize(
      size: Size(512, 128),
      child: ClipOval(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
          child: Text(
            Message,
            style: TextStyle(
              fontSize: 24
            ),
            ),
        ),
        )
      ),
    );
  }

}