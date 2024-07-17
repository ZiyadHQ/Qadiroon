

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

class CalenderRecord
{

  CalenderRecord(this.Name, this.Contents, this.Date, this.type);

  String Name;
  String Contents;
  DateTime Date;
  EventType type;

}