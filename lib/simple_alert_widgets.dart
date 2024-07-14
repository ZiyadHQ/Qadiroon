
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

void simple_alert_showWidget(BuildContext context, String message, {Color backgroundColor = Colors.white, bool isDismissible = true})
{
  showModalBottomSheet(context: context, builder: (context) => SimpleAlert(Message: message, backgroundColor: backgroundColor),isDismissible: isDismissible);
}

void simple_rotating_loading_screen(BuildContext context, {String message = '', Color backgroundColor = Colors.white, bool isDismissible = true})
{
  showModalBottomSheet(context: context, builder: ((context) => Column(
    children: [
      StyledText(text: message, size: 24, color: backgroundColor, fontFamily: 'default'),
      Spacer(),
      CircularProgressIndicator.adaptive(backgroundColor: backgroundColor)
    ],
  )),
  isDismissible: isDismissible 
  );
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