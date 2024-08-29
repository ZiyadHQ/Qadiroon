
import 'package:flutter/material.dart';

class ServiceBrowserWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _service_browsing_widget_state();
  }
  
}

class _service_browsing_widget_state extends State<ServiceBrowserWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: Tab
      (
        child: ListView
        (
          scrollDirection: Axis.horizontal,
          children: [Text("TEST TEXT"), Text("TEST TEXT"), Text("TEST TEXT"), Text("TEST TEXT"), Text("TEST TEXT")],
        ),
      ),
      body: ListView
      (
        children: [Text("TEST TEXT"), SizedBox(height: 1000,), Text("TEST TEXT"), Text("TEST TEXT"), Text("TEST TEXT")],
      ),
    );
  }
  
}