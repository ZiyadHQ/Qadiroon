
import 'package:qadiroon_front_end/login_widget.dart';

enum UserType
{
  B,  //beneficiary
  S,  //Service provider
}
enum LoginType
{
  L,  //login
  R,  //register
}

class Record
{

  Record({required this.Name, required this.PassWordHash, required this.issueTime, required this.userType});

  String Name;
  String PassWordHash;
  DateTime issueTime;
  UserType userType;

}