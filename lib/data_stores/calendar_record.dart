

import 'package:flutter/material.dart';

enum EventType
{
    Leisure,
    Work,
    Education,
    Health,
    Shopping,
    Social,
    Sports,
    Travel,
    Family,
    Entertainment
}

var EventToIcon = 
{
  EventType.Education : Row(children: [Icon(Icons.library_books), SizedBox(width: 64,), Text('education')],),
  EventType.Entertainment : Row(children: [Icon(Icons.gamepad), SizedBox(width: 64,), Text('emtertaimnemt')],),
  EventType.Family : Row(children: [Icon(Icons.family_restroom), SizedBox(width: 64,), Text('family')],),
  EventType.Health : Row(children: [Icon(Icons.health_and_safety), SizedBox(width: 64,), Text('health')],),
  EventType.Leisure : Row(children: [Icon(Icons.beach_access), SizedBox(width: 64,), Text('leisure')],),
  EventType.Shopping : Row(children: [Icon(Icons.money), SizedBox(width: 64,), Text('shopping')],),
  EventType.Social : Row(children: [Icon(Icons.people), SizedBox(width: 64,), Text('social')],),
  EventType.Sports : Row(children: [Icon(Icons.sports_basketball), SizedBox(width: 64,), Text('sports')],),
  EventType.Travel : Row(children: [Icon(Icons.flight_takeoff), SizedBox(width: 64,), Text('travel')],),
  EventType.Work : Row(children: [Icon(Icons.work), SizedBox(width: 64,), Text('work')],)
};

class CalenderRecord
{

  CalenderRecord(this.Name, this.Contents, this.Date, this.type);

  String Name;
  String Contents;
  DateTime Date;
  EventType type;
  //object document id
  late String? oid;

}