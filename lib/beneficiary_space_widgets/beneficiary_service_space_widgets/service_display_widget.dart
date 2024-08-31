
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/data_stores/calendar_record.dart';

class ServiceBrowserWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _service_browsing_widget_state();
  }
  
}

class _service_browsing_widget_state extends State<ServiceBrowserWidget>
{

  List<CalenderRecord>? records;

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